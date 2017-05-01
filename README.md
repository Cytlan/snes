Unnamed SNES Game
=================

This is a new SNES game that has just started development.
You can find game design related notes in Design.txt.

If you want to join the discussion, head over to our Discord: https://discord.gg/pgYgRbA

cc65 and C
----------

The SNES uses the 65c816 CPU, an enchanced 16-bit version of the 6502, and is partially supported by the cc65 toolchain. Assembling and linking with ca65 and cl65 are fully supported for the 65c816, but compiling C sources with cc65 is limited to the 6502.

cc65 is refrenced in the makefile, but isn't needed unless you actually add any C-sources to the project, which for SNES purposes doesn't make a whole lot of sense, but it should compile.

Compiling and Assembling
------------------------

In order to successfully assemble this project, the following programs are needed:

```
ca65
cl65
make
```

Assembling should be as simple as:
```
make
```

The assembled game can be found in bin/game.sfc.

Syntax highlighting
-------------------

If you're using Sublime Text, or any other editor that supports TextMate syntax highlighting, check out the ca65 directory. It has a syntax highlighting file made spesifically for this project (and may be updated frequently).
