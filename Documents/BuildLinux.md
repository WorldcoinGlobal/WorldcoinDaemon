Worldcoin Daemon Linux
======================

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
-  OpenSSL       1.0.1j (DON'T USE 1.0.1k onwards until some issues are resolved and tested)
-  Berkeley DB   6.0.30.NC
-  Boost         1.57
-  miniupnpc     1.9

Dependency Build Instructions
-----------------------------

It is strongly recommended to download the exact same versions detailed above.

Define variable LIBRARIES to a suitable directory 
export LIBRARIES=<library dir>


 - MiniUPNPC  -- [TAGS] (http://miniupnp.tuxfamily.org/files)
   ---------

	tar -xzvf miniupnpc-1.9.tar.gz
	cd miniupnpc-1.9
	INSTALLPREFIX=$LIBRARIES/MiniUPNPC make install-static

 - BerkeleyDB  -- [TAGS] (http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/downloads/index-082944.html)
   ----------

	tar -xzvf db-6.0.30.NC.tar.gz
        cd db-6.0.30.NC/build_unix
	../dist/configure --enable-cxx --prefix=$LIBRARIES/BerkeleyDB --disable-shared
	make
	make install

 - Openssl  --  [TAGS] (https://www.openssl.org/source/old/1.0.1/)
   -------

	tar -xzvf openssl-1.0.1j.tar.gz
	cd openssl-1.0.1j
	./config --prefix=$LIBRARIES/OpenSSL no-shared 
	make
	make test
	make install

 - Boost  -- [TAGS] (http://sourceforge.net/projects/boost/files/boost/)
   -----
        tar -xjvf boost_1_57_0.tar.bz2
	cd boost_1_57_0
	./bootstrap.sh
        ./b2 install --prefix=$LIBRARIES/Boost link=static


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

	Edit Build.sh to configure parameters
	./Build.sh

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

