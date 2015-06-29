Worldcoin integration/staging tree
================================

http://www.worldcoin.global

Copyright (c) 2009-2015 Bitcoin Developers
Copyright (c) 2011-2015 Litecoin Developers
Copyright (c) 2013-2015 Worldcoin Developers

What is Worldcoin?
----------------

Worldcoin is an improved version of Bitcoin using Scrypt as a proof-of-work algorithm.
 - 30 second block targets
 - 120 blocks to retarget difficulty
 - starts at 64 coins per block
 - subsidy is reduced 1% every week to a minimum reward of 1 WDC per block
 - ~265 million total coins


For more information, as well as an immediately usable, binary version of
the Worldcoin client software, see http://www.worldcoin.gloabl

License
-------

Worldcoin is released under the terms of the MIT license. See `COPYING` for more
information or see http://opensource.org/licenses/MIT.

Development process
-------------------

Developers work in their own trees, then submit pull requests when they think
their feature or bug fix is ready.

If it is a simple/trivial/non-controversial change, then one of the Worldcoin
development team members simply pulls it.

If it is a *more complicated or potentially controversial* change, then the patch
submitter will be asked to start a discussion (if they haven't already) on irc at
irc.freenode.net #worldcoin

The patch will be accepted if there is broad consensus that it is a good thing.
Developers should expect to rework and resubmit patches if the code doesn't
match the project's coding conventions (see `doc/coding.txt`) or are
controversial.

The `master` branch is regularly built and tested, but is not guaranteed to be
completely stable. [Tags](https://github.com/bitcoin/bitcoin/tags) are created
regularly to indicate new official, stable release versions of Worldcoin.

Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test. Please be patient and help out, and
remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write unit tests for new code, and to
submit new unit tests for old code.

Unit tests for the daemon code are in `Source/test/`. To compile and run them:

    cd Source
    make -f makefile.unix test


Build
-----

- Windows : Read  Documents/BuildWindows.md
- Linux : Read  Documents/BuildLinux.md
