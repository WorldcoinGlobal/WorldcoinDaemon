Worldcoin Daemon Windows
========================
This guide is for compiling Worldcoin daemon and dependencies with Visual Studio (2013 was used) 64 bits

Dependencies
------------

 Library     Purpose           Description
 -------     -------           -----------
 libssl      SSL Support       Secure communications
 libdb4.8    Berkeley DB       Blockchain & wallet storage
 libboost    Boost             C++ Library
 miniupnpc   UPnP Support      Optional firewall-jumping support

Is advised to build all libraries statically

Licenses of statically linked libraries:
 Berkeley DB   New BSD license with additional requirement that linked
               software must be free open source
 Boost         MIT-like license
 miniupnpc     New (3-clause) BSD license

- Versions used in this release:
-  OpenSSL       1.0.1j (DON'T USE 1.0.1k and above until some issues are resolved and tested)
-  Berkeley DB   6.0.30.NC
-  Boost         1.57
-  miniupnpc     1.9

Dependency Build Instructions
-----------------------------

It is strongly recommended to download the exact same versions detailed above.

<Library Dir> Will represent the directory where dependencies will be deployed
<Project Dir> Will represent the main source code directory of the relevant project


 - MiniUPNPC  -- [TAGS] (http://miniupnp.tuxfamily.org/files)
   ---------

	Uncompress miniupnpc-1.9.tar.gz
        Create a file called <Project Dir>/miniupnpcstrings.h  with the contents below. Actual strings don't matter

               #ifndef __MINIUPNPCSTRINGS_H__ 
               #define __MINIUPNPCSTRINGS_H__ 

               #define OS_STRING "Windows/7.0.0000" 
               #define MINIUPNPC_VERSION_STRING "1.9" 
               #endif 

	Run VS and open project file : <Project Dir>\msvc\miniupnpc.sln  (if asked say yes to upgrade)
	Configure VS to compile 64 bit  [TAGS]  (https://msdn.microsoft.com/en-us/library/9yb4317s.aspx)
        Change code generation setting to MT
        Build miniupnpc 
        Copy  <Project Dir>\msvc\x64\Release\miniupnpc.lib   <Library Dir>\MiniUPNPC\lib
	Copy  <Project Dir>\*.h	  <Library Dir>\MiniUPNPC\include

 - BerkeleyDB  -- [TAGS] (http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/downloads/index-082944.html)
   ----------

	Uncompress db-6.0.30.NC.zip
        Run VS and open project file : <Project Dir>\build_windows\Berkeley_DB.sln  (if asked say yes to upgrade)
	Configure VS to compile 64 bit  [TAGS]  (https://msdn.microsoft.com/en-us/library/9yb4317s.aspx)
	Change code generation setting to MT
	Build solution
        Copy  <Project Dir>\build_windows\x64\Release\libdb60.lib   <Library Dir>\BerkeleyDB\lib64\
        Copy  <Project Dir>\build_windows\db.h   <Library Dir>\BerkeleyDB\include\
        Copy  <Project Dir>\build_windows\db_cxx.h   <Library Dir>\BerkeleyDB\include\

 - Openssl  --  [TAGS] (http://www.npcglib.org/~stathis/blog/precompiled-openssl/)
   -------
	Download from here precompiled version 1.0.1j 
	Inside directory <Project Dir>\lib64, copy files  libeay32MT.lib and ssleay32MT.lib  to <Library Dir>\OpenSSL\lib
	Rename these files without the MT suffix
	Copy  <Project Dir>\include\openssl\*.h	  <Library Dir>\OpenSSL\include\openssl

 - Boost  -- [TAGS] (http://sourceforge.net/projects/boost/files/boost/)
   -----
	Unzip boost_1_57_0.zip
        Open the Visual Studio Command Prompt (64 bits )
	Run: bootstrap.bat
        Run: b2 release install toolset=msvc-12.0 --build-type=complete address-model=64 --prefix=<Library Dir>\Boost link=static
        Move folder: <Library Dir>\Boost\include\Boost_1_57\boost  to  <Library Dir>\Boost\include\boost


Build Worldcoin Daemon
----------------------

 - Notes
   -----
    
   UPnP support is compiled in and
   turned off by default.  Set USE_UPNP to a different value to control this:

	USE_UPNP=     No UPnP support miniupnp not required
	USE_UPNP=0    (the default) UPnP support turned off by default at runtime
	USE_UPNP=1    UPnP support turned on by default at runtime

   IPv6 support may be disabled by setting:

	USE_IPV6=0    Disable IPv6 support

  - Build
    -----

	Set enviroment variable (In conontrol panel) LIBRARIES=<Library Dir>
	Run VS and open project file : <Project Dir>\leveldb\vs2010.sln  (if asked say yes to upgrade)
        Change code generation setting to MT
	Build solution
        Open project file : <Project Dir>\worldcoin.sln  (if asked say yes to upgrade)
        Change code generation setting to MT
        Build solution

    DONE !

Security
--------
To help make your worldcoin installation more secure by making certain attacks impossible to
exploit even if a vulnerability is found, you can take the following measures:

* Position Independent Executable
    Build position independent code to take advantage of Address Space Layout Randomization
    offered by some kernels. An attacker who is able to cause execution of code at an arbitrary
    memory location is thwarted if he doesn't know where anything useful is located.
    The stack and heap are randomly located by default but this allows the code section to be
    randomly located as well.

    On an Amd64 processor where a library was not compiled with -fPIC, this will cause an error
    such as: "relocation R_X86_64_32 against `......' can not be used when making a shared object;"

    To build with PIE, use:
    make -f makefile.unix ... -e PIE=1

    To test that you have built PIE executable, install scanelf, part of paxutils, and use:

    	scanelf -e ./worldcoin

    The output should contain:
     TYPE
    ET_DYN

* Non-executable Stack
    If the stack is executable then trivial stack based buffer overflow exploits are possible if
    vulnerable buffers are found. By default, bitcoin should be built with a non-executable stack
    but if one of the libraries it uses asks for an executable stack or someone makes a mistake
    and uses a compiler extension which requires an executable stack, it will silently build an
    executable without the non-executable stack protection.

    To verify that the stack is non-executable after compiling use:
    `scanelf -e ./worldcoin`

    the output should contain:
	STK/REL/PTL
	RW- R-- RW-

    The STK RW- means that the stack is readable and writeable but not executable.

