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
.SILENT:
#
STDROOT      = ${PWD}
SRCDIR       = $(STDROOT)/src
SRCDIR2      = $(STDROOT)/LOCAL/TWOMOM
SRCDIR3      = $(STDROOT)/LOCAL/EMVORADO
OBJDIR       = $(STDROOT)/obj
WORKDIR      = $(STDROOT)/work
#
#
####################################################
#  include (or build) an appropriate compiler file
#     some compiler files are available in LOCAL
#     and can be copied to Fopts
####################################################

include Fopts

####################################################
#  Declaration of the Object Files
####################################################

include ObjFiles
#include LOCAL/EMVORADO/ObjFiles.radar
#include LOCAL/TWOMOM/ObjFiles.twomom
#include LOCAL/TWOMOM/ObjFiles.cloud_opt

####################################################
#  Actions that can be performed
####################################################
#
exe:    allpar
#
purpar:  check_is_not_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ)
	echo linking parallel program
	( $(LDPAR) $(LDFLG) -o $(PROGRAM)_pur $(DATAOBJ) $(UTILOBJ) $(EXTOBJ) \
                                    $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(LIB) )
#
allpar:  check_is_not_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ) $(ASSOBJ) $(SATOBJ)
	echo linking parallel program
	( $(LDPAR) $(LDFLG) -o $(PROGRAM)_all $(DATAOBJ) $(UTILOBJ) $(EXTOBJ) \
                                    $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(ASSOBJ) $(SATOBJ) $(LIB) )
#
nudpar:  check_is_not_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ) $(ASSOBJ)
	echo linking parallel program
	( $(LDPAR) $(LDFLG) -o $(PROGRAM)_nud $(DATAOBJ) $(UTILOBJ) $(EXTOBJ) \
                                    $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(ASSOBJ) $(LIB) )
#
satpar:  check_is_not_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ) $(SATOBJ)
	echo linking parallel program
	( $(LDPAR) $(LDFLG) -o $(PROGRAM)_sat $(DATAOBJ) $(UTILOBJ) $(EXTOBJ) \
                                    $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(SATOBJ) $(LIB) )
#
###############################################################################
#
purseq:  check_is_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ)  \
         $(OBJDIR)/dummy_mpi.o
	echo linking sequential program
	( $(LDSEQ) $(LDFLG) -o $(PROGRAM)_purseq $(DATAOBJ) $(UTILOBJ)           \
              $(OBJDIR)/dummy_mpi.o $(EXTOBJ) $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(LIB) )
#
allseq:  check_is_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ)  \
         $(ASSOBJ) $(SATOBJ) $(OBJDIR)/dummy_mpi.o
	( $(LDSEQ) $(LDFLG) -o $(PROGRAM)_allseq $(DATAOBJ) $(UTILOBJ)           \
              $(OBJDIR)/dummy_mpi.o $(EXTOBJ) $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(ASSOBJ) $(SATOBJ) $(LIB) )
#
nudseq:  check_is_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ)  \
         $(ASSOBJ) $(OBJDIR)/dummy_mpi.o
	echo linking sequential program
	( $(LDSEQ) $(LDFLG) -o $(PROGRAM)_nudseq $(DATAOBJ) $(UTILOBJ)           \
              $(OBJDIR)/dummy_mpi.o $(EXTOBJ) $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(ASSOBJ) $(LIB) )
#
satseq:  check_is_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(NEWPHY) $(SRCOBJ)  \
         $(SATOBJ) $(OBJDIR)/dummy_mpi.o
	echo linking sequential program
	( $(LDSEQ) $(LDFLG) -o $(PROGRAM)_satseq $(DATAOBJ) $(UTILOBJ)           \
              $(OBJDIR)/dummy_mpi.o $(EXTOBJ) $(PUBLICUTILS) $(NEWPHY) $(SRCOBJ) $(SATOBJ) $(LIB) )
#
###############################################################################
#
$(OBJDIR):
	mkdir -p $(OBJDIR)
#
check_is_mpifh:
	if [ ! -f $(SRCDIR)/mpif.h ]; then  \
          echo "ERROR: mpif.h is not contained in src/ !";  \
          exit 1;  \
        fi
#
check_is_not_mpifh:
	if [ -f $(SRCDIR)/mpif.h ]; then  \
          echo "ERROR: there is an mpif.h in src/ !";  \
          exit 1;  \
        fi
#
addmods:
	for DATEI in `ls -x $(WORKDIR)` ; do \
	   cp -p $(WORKDIR)/$${DATEI}  $(SRCDIR) ; \
	done
#
clean:
	echo cleaning up
	rm -f $(PROGRAM)*
	rm -f $(OBJDIR)/*
#
####################################################
#
#     Dependencies of the Data Modules
#
####################################################

#include LOCAL/TWOMOM/ObjDependencies.twomom
#include LOCAL/TWOMOM/ObjDependencies.cloud_opt
#include LOCAL/EMVORADO/ObjDependencies.radar
include ObjDependencies
