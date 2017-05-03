# ------------------------------------------------------------------------------
# Makefile
#
# POSIX shell tools needed! (Busybox?)
#
# Copyright (c) 2017, Cytlan, Shibesoft AS
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
ASMSOURCES = registers.asm \
             memory.asm \
             graphics.asm \
             main.asm \
             nmi.asm \
             initialize_hardware.asm \
             cartridge_header.asm \
             interrupt_vectors.asm

# Additional libraries to link
LIBRARIES = 

# ------------------------------------------------------------------------------

TOOLDIR=tools/bin/

# Compile & Link, Compile, Assemble and Link utilities
CL65=$(TOOLDIR)cl65
CC65=$(TOOLDIR)cc65
CA65=$(TOOLDIR)ca65
LD65=$(TOOLDIR)ld65

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

$(BUILDDIR)/memory.o: AFLAGS+=-DRAM_EXPORT

clean:
	$(RM) $(TARGET)
	$(RM) $(BUILDDIR)/*.o

.PHONY: all start done clean clean_all

# EOF --------------------------------------------------------------------------
