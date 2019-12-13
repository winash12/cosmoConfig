####################################################
#
#    Makefile for the Fortran 90 program
#
####################################################
#
#
####################################################
#
#    Declaration of Variables
#
####################################################
#
#.SILENT:
#
STDROOT      = .
SRCDIR       = $(STDROOT)/src
OBJDIR       = $(STDROOT)/obj
WORKDIR      = $(STDROOT)/work
INCDIR       = $(STDROOT)/include
INSTALLDIR   = /home/winash12/meteorology_project/cosmo_weather_model/RTTOV10
#EXTDIR       = $(STDROOT)/ext

####################################################
#  Actions that can be performed
####################################################
SHELL := /bin/bash 
.PHONY: all lib bin includes 
all: lib bin includes

####################################################
#     Include  file information
####################################################
include ObjFiles
include ObjDependencies

####################################################
#  Declaration of the rules (1)
# These can be overriden by rules in Fopts if
# required (e.g. SX-9)
####################################################
override MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

lib:       $(BUILD_LIB)
bin:       $(BUILD_BIN)

$(BUILD_LIB): $(STDROOT)/%.a: 
	-rm -f $@
	$(AR) rcs $@ $^

$(BUILD_BIN): $(STDROOT)/%.exe: 
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)

$(OBJDIR)/%.o: $(SRCDIR)/%.f90
	( mkdir -p $(@D) && $(F90) $(F90FLAGS) $(F90OPT) -o $@ $< && \
	if [[ -e $*.mod ]] ; then mv $*.mod $(OBJDIR)/$*.mod ; fi )

$(SRCDIR)/%.f90: $(EXTDIR)/mod ;

$(OBJDIR)/%.mod: $(OBJDIR)/%.o ; 

$(INCDIR)/%.interface: $(SRCDIR)/%.interface
	(mkdir -p $(@D) && cp $< $@ )

$(INCDIR)/%.h: $(SRCDIR)/%.h
	(mkdir -p $(@D) && cp $< $@ )

clean:
	echo cleaning up
	-rm -rf $(OBJDIR)
	-rm -rf $(INCDIR)
#	-rm -rf $(EXTDIR)/mod
	-rm -f  $(BUILD_LIB) $(BUILD_BIN)
	-rm -f  $(STDROOT)/*.mod

install:
	echo installing libraries and executables
	cp rttov_conv_coef.exe $(INSTALLDIR)/bin
	cp modrttov10.2.a      $(INSTALLDIR)/lib
	cp librttov10.2.a      $(INSTALLDIR)/lib

####################################################
#     Include Platform settings
####################################################
include Fopts

override INCLUDES  := $(SRCDIR) $(OBJDIR) $(EXTDIR)/mod $(EXTDIR)/include $(INCLUDES)

####################################################
#  Declaration of the rules (2)
# These rules need some variables declared in Fopts
####################################################
#$(EXTDIR)/mod: $(EXT_MODULES)
#	mkdir -p $(EXTDIR)/mod
#	for f in $^; do \
#		(cd $(EXTDIR)/mod && $(AR) x $$f) \
#	done	
#
## vim:ts=8:sw=8:noet:
