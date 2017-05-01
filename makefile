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
CONFIG = layout.conf

# Directories
SRCDIR      := src
RESDIR      := res
INCDIR      := inc
BUILDDIR    := obj
TARGETDIR   := bin

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
MKDIR=mkdir -p

# ------------------------------------------------------------------------------

# Finalizing flags
CFLAGS+=$(patsubst %,-I %,$(INCDIR))
AFLAGS+=$(patsubst %,-I %,$(INCDIR))

# Get object names
OBJS_=$(CSOURCES:.c=.o) $(ASMSOURCES:.asm=.o)
OBJS=$(patsubst %,$(BUILDDIR)/%,$(OBJS_)) $(LIBRARIES)

#Fix paths
PATHS = $(sort $(dir $(OBJS)))

# ------------------------------------------------------------------------------

all: clean makedirs $(TARGET)

makedirs:
	$(MKDIR) $(PATHS)

$(TARGET): $(OBJS) $(LIBRARIES)
	$(LD65) $(LDFLAGS) --config $(CONFIG) --obj $(OBJS) -o $(TARGET)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC65) $(CFLAGS) -O -o $@ $<

$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	$(CA65) $(AFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET)
	$(RM) $(BUILDDIR)/*.o

.PHONY: all start done clean clean_all

# EOF --------------------------------------------------------------------------