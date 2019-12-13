################################################################################
#
#    Makefile for the GME2LM
#
################################################################################
#
#
################################################################################
#
#    Declaration of Variables
#
################################################################################
#
.SILENT:
#
STDROOT      = ${PWD}
SRCDIR       = $(STDROOT)/src
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

################################################################################
# Actions that can be performed
################################################################################
#
exe:    parexe
#
parexe:  check_is_not_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(EXTOBJ) $(SRCOBJ)
	echo linking parallel program
	if [ -f $(SRCDIR)/mpif.h ]; then \
          echo "ERROR: there is an mpif.h in src/ !"; \
          exit 1; \
        fi
	($(LDPAR) $(LDFLG) -o $(PROGRAM) $(DATAOBJ) $(UTILOBJ) $(EXTOBJ)      \
                                        $(PUBLICUTILS) $(SRCOBJ) $(LIB))
#
seqexe:  check_is_mpifh / $(OBJDIR) $(DATAOBJ) $(PUBLICUTILS) $(UTILOBJ) $(OBJDIR)/dummy_mpi.o \
                   $(EXTOBJ) $(SRCOBJ)
	echo linking sequential int2lm
	if [ ! -f $(SRCDIR)/mpif.h ]; then  \
          echo "ERROR: mpif.h is not contained in src/ !";  \
          exit 1;  \
        fi
	( $(LDSEQ) $(LDFLG) -o $(PROGRAM)_seq $(DATAOBJ) $(UTILOBJ) $(EXTOBJ) \
                   $(OBJDIR)/dummy_mpi.o                                      \
                   $(PUBLICUTILS)        $(SRCOBJ) $(LIB) )
#
################################################################################
#
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
	rm -f $(PROGRAM)
	rm -f loadmap
	rm -f $(OBJDIR)/*.o
	rm -f $(OBJDIR)/*.i
	rm -f $(OBJDIR)/*.T
	rm -f $(OBJDIR)/*.L
	rm -f $(OBJDIR)/i.*
	rm -f $(OBJDIR)/*.mod
	rm -f $(OBJDIR)/*.lst

#
################################################################################
#
#   Dependencies and Rules for compiling
#
################################################################################

include ObjDependencies
