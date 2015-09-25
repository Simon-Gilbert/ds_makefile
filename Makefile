CC = gcc
AR = ar

PROG = devoir
CFLAGS = -Wall
LDFLAGS = -L.
LINKERNAME = $(PROG)_library
STATICNAME = lib$(LINKERNAME).a
OBJ = journal.o



libCFLAGS = -fPIC -Wall -shared
libLDFLAGS = -L.
libLDLIBS = -lc


static: 
	$(CC) -c $(CFLAGS) lib/journal.c 
	$(AR) rcs $(STATICNAME) $(OBJ)
	


