#!/bin/bash
#
# Script to download, compile and install everything we need for development
# (Only tested on Ubuntu...)
#

# Install dependencies
sudo apt install build-essential git g++-4.9 gtk+-2.0 libcairo-dev libgtksourceview2.0-dev libsdl2-dev libao-dev libopenal-dev

# Make dirs
cd tools
mkdir bin
mkdir git

# Make cc65
cd git
git clone https://github.com/cc65/cc65
cd cc65
make -j8
cd ../../
cp git/cc65/bin/* bin

# Make emulator
cd git
git clone https://github.com/Cytlan/higan
cd higan/higan
make -j8
cd ../../../
cp -r git/higan/higan/systems/* bin
cp git/higan/higan/out/higan bin
