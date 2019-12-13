####################################################
#
#    Makefile for building hrit library
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
LIBDIR       = $(STDROOT)/lib
BINDIR       = $(STDROOT)/bin
# INSTALL is defined in Fopts

INSTALLDIR   = $(INSTALL)

####################################################
#  Basic actions that can be performed
####################################################
SHELL := /bin/bash 
.PHONY: all lib bin
all: lib bin

####################################################
#  Define objects and dependencies
####################################################

HRITBIN =  $(BINDIR)/test.out

HRITOBJ =  $(OBJDIR)/hrit2nc.o \
           $(OBJDIR)/hrit_error.o \
           $(OBJDIR)/hrit.o \
           $(OBJDIR)/hrit_read_conf.o \
           $(OBJDIR)/hrit_read_file.o \
           $(OBJDIR)/hrit_read_stream.o \
           $(OBJDIR)/hrit_time.o \
           $(OBJDIR)/hrit_types.o \
           $(OBJDIR)/hrit_utils.o \
           $(OBJDIR)/read_stream.o

HRITMOD =  $(OBJDIR)/hrit_error.mod \
           $(OBJDIR)/hrit.mod \
           $(OBJDIR)/hrit_read_conf.mod \
           $(OBJDIR)/hrit_read_file.mod \
           $(OBJDIR)/hrit_read_stream.mod \
           $(OBJDIR)/hrit_time.mod \
           $(OBJDIR)/hrit_types.mod \
           $(OBJDIR)/hrit_utils.mod

$(OBJDIR)/hrit2nc.o:           $(OBJDIR)/hrit.o

$(OBJDIR)/hrit_error.o:        $(OBJDIR)/hrit_types.o

$(OBJDIR)/hrit.o:              $(OBJDIR)/hrit_error.o \
                               $(OBJDIR)/hrit_read_conf.o \
                               $(OBJDIR)/hrit_read_file.o \
                               $(OBJDIR)/hrit_time.o \
                               $(OBJDIR)/hrit_types.o \
                               $(OBJDIR)/hrit_utils.o

$(OBJDIR)/hrit_read_conf.o:    $(OBJDIR)/hrit_error.o \
                               $(OBJDIR)/hrit_types.o \
                               $(OBJDIR)/hrit_utils.o

$(OBJDIR)/hrit_read_file.o:    $(OBJDIR)/hrit_error.o \
                               $(OBJDIR)/hrit_read_stream.o \
                               $(OBJDIR)/hrit_time.o \
                               $(OBJDIR)/hrit_types.o \
                               $(OBJDIR)/hrit_utils.o

$(OBJDIR)/hrit_read_stream.o:  $(OBJDIR)/hrit_error.o \
                               $(OBJDIR)/hrit_types.o


$(OBJDIR)/test.o:              $(OBJDIR)/hrit.o \
                               $(OBJDIR)/hrit_read_stream.o \
                               $(OBJDIR)/hrit_types.o

####################################################
#  Further actions that can be performed
####################################################

lib: islibdir / isobjdir / $(HRITOBJ) $(HRITMOD)
	-rm -f $(LIBDIR)/libhrit.a $(LIBDIR)/modhrit.a
	$(AR) rcs $(LIBDIR)/libhrit.a  $(HRITOBJ)
	$(AR) rcs $(LIBDIR)/modhrit.a  $(HRITMOD)

bin: isbindir / $(HRITBIN)

	
clean:
	echo cleaning up compilation
	-rm -rf $(OBJDIR)
	-rm -rf $(LIBDIR)
	-rm -rf $(BINDIR)

distclean:
	echo cleaning up installation
	-rm -rf $(OBJDIR)
	-rm -rf $(LIBDIR)
	-rm -f  $(INSTALLDIR)/lib/libhrit.a
	-rm -f  $(INSTALLDIR)/lib/modhrit.a
	-rm -f  $(INSTALLDIR)/include/hrit*.mod

islibdir:
	mkdir -p $(LIBDIR)

isbindir:
	mkdir -p $(BINDIR)

isobjdir:
	mkdir -p $(OBJDIR)

install:
	echo installing libraries
	cp $(LIBDIR)/*.a $(INSTALLDIR)/lib
	cp obj/*.mod     $(INSTALLDIR)/include

# Suffix rules

$(BINDIR)/%.out: $(SRCDIR)/%.f90
	$(LD) $(LDFLAGS) -o $@ $< $(LIBS)

$(OBJDIR)/%.o: $(SRCDIR)/%.f90
	( $(F90) $(F90OPT) -o $@ $< && \
	if [[ -e $*.mod ]] ; then mv $*.mod $(OBJDIR)/$*.mod ; fi )
	
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	( $(CC) $(CCFLAGS) -o $@ $< )
	
$(OBJDIR)/%.mod: $(OBJDIR)/%.o ;

####################################################
#     Include Platform settings
####################################################
include Fopts

override INCLUDES  := $(SRCDIR) $(OBJDIR) $(INCLUDES)
