#!/bin/bash
# bash script for building worldcoind(1) on OSX
# Copyright (c) 2015 Worldcoin Developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

make -f makefile.osx
strip worldcoind