CC = gcc
AR = ar

NAME = journal
CFLAGS = -Wall
LDFLAGS = -L.
LINK=ln -sv

LINKERNAME = $(PROG)_library
SONAME:=$(LINKERFILENAME)$(LIBMAJOR)
REALNAME=$(SONAME)$(LIBMINOR)$(LIBPATCH)
STATICNAME = lib$(LINKERNAME).a

OBJ = journal.o
LIBMAJOR:=.1
LIBMINOR=.1
LIBPATCH=.57


libCFLAGS = -fPIC -Wall -shared
libLDFLAGS = -L.
libLDLIBS = -lc


$(NAME): libjournal.a libjournal.so.1.1.57 


libjournal.a : 
	$(CC) -c $(CFLAGS) lib/journal.c 
	$(AR) rcs $(STATICNAME) $(OBJ)	 	
 		 	
 		 
libjournal.so.1.1.57 : 
	
	gcc -fPIC -c -Wall lib/journal.c
	gcc -shared -fPIC -Wl,-soname,libjournal.so.1 -o libjournal.so.1.1.57 journal.o -lc
	ln -sv libjournal.so.1.1.57 libjournal.so.1
	ln -sv libjournal.so.1.1.57 libjournal.so

clean : 
	rm -f *.o *libjournal* 

