Unnamed SNES Game
=================

This is a new SNES game that has just started development.

If you want to join the discussion, head over to our Discord: https://discord.gg/pgYgRbA

cc65 and C
----------

The SNES uses the 65c816 CPU, an enchanced 16-bit version of the 6502, and is partially supported by the cc65 toolchain. Assembling and linking with ca65 and cl65 are fully supported for the 65c816, but compiling C sources with cc65 is limited to the 6502.

cc65 is refrenced in the makefile, but isn't needed unless you actually add any C-sources to the project, which for SNES purposes doesn't make a whole lot of sense, but it should compile.

Installing the toolchain
------------------------

In order to successfully assemble this project, the following programs are needed:

```
ca65
ld65
make
```

Run the `setup.sh` script on an Ubuntu system to install dependencies, and to clone and compile the cc65 and higan repos.

The build system expects these tools to be found in `tools/bin`.

Compiling and Assembling
------------------------

Assembling should be as simple as running `make` in the project directory.

The assembled game can be found in `bin/game.sfc`.

Testing
-------

If you've run the `setup.sh` script, you should have a modified version of higan located at `tools/bin/higan`. This is because the higan emulator is very accurate, so it's preferrable to test our game on it. Unfortunately higan has this whole idea of maintaining its own library of games with complicated manifest files and what not, which really isn't suited for development. To get around that, frankly, annoying feature, I've modified it slightly to "import" the game into memory and run it immediatly.

To launch the emulator and load the rom, run:
```
$ tools/bin/higan bin/game.sfc
```

Compiling on Windows
--------------------

This is still a bit of a pain in the ass, sorry. Hopefully we can do something about it soon.

Syntax highlighting
-------------------

If you're using Sublime Text, or any other editor that supports TextMate syntax highlighting, check out the ca65 directory. It has a syntax highlighting file made spesifically for this project (and may be updated frequently).

Resources
---------

 * Super Nintendo Development Wiki: https://wiki.superfamicom.org/snes/show/HomePage
 * Super Nintendo Developers Manual: https://www.romhacking.net/documents/226/

License
-------

Everything in this repo is GPLv3.

TODOs
-----

 * Include a BRR encoder/decoder
 * Find or make a decent tile editor and tilemap editor
 * Calculate the ROM checksum for the header

