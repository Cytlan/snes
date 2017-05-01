# ------------------------------------------------------------------------------
# Makefile
#
# POSIX shell tools needed! (Busybox?)
#
# Author:  Cytlan
# License: Copyright © 2017, Shibesoft AS
#          All rights reserved
#
# ------------------------------------------------------------------------------

# Default target CPU of the assembly sources
CPU = 65816

# Name of the target ROM
TARGET = bin/game.sfc

# Config file containing the memory map, etc.
CONFIG = game.conf

# C sources (Notice: ca65 can only compile C sources to 6502, not 65c816)
CSOURCES =

# Assembly sources
ASMSOURCES = register_definitions.asm \
             graphics.asm \
             main.asm \
             initialize_hardware.asm \
             cartridge_header.asm \
             interrupt_vectors.asm

# Additional libraries to link
LIBRARIES = 

# Additional directories to add to the include path
INCDIR = 

# Object file directory
ODIR = obj

# ------------------------------------------------------------------------------

# Compile & Link, Compile, Assemble and Link utilities
CL65=cl65
CC65=cc65
CA65=ca65
LD65=ld65

# Compiler, assembler and linker options
CFLAGS=
AFLAGS=--cpu $(CPU)
LDFLAGS=

# System utilities 
# RM - Some utility that can delete files
RM=rm -f

# ------------------------------------------------------------------------------

# Finalizing flags
CFLAGS+=$(patsubst %,-I %,$(INCDIR))
#AFLAGS+=

# Get object names
OBJS_=$(CSOURCES:.c=.o) $(ASMSOURCES:.asm=.o)
OBJS=$(patsubst %,$(ODIR)/%,$(OBJS_)) $(LIBRARIES)

# ------------------------------------------------------------------------------

all: clean $(TARGET)

$(TARGET): $(OBJS) $(LIBRARIES)
	$(LD65) $(LDFLAGS) --config $(CONFIG) --obj $(OBJS) -o $(TARGET)

$(ODIR)/%.o: %.c
	$(CC65) $(CFLAGS) -O -o $@ $<

$(ODIR)/%.o: %.asm
	$(CA65) $(AFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET)
	$(RM) $(ODIR)/*.o

.PHONY: all start done clean clean_all

# EOF --------------------------------------------------------------------------