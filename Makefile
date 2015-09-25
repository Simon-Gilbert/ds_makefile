CC = gcc
AR = ar

NAME = journal
CFLAGS = -Wall
LDFLAGS = -L.
LINK=ln -sv
DIRECTORY=lib

LINKERNAME = $(NAME)_library
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


$(NAME): $(STATICNAME) $(REALNAME)
	
	$(CC) -o $@.static $< $(LDFLAGS) -l:$(STATICNAME)	
	touch $(NAME).log
	$(CC) -o $@.shared $< $(LDFLAGS) -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$@.shared
	cat $(NAME).log
	rm -f *.o *$(NAME)*

$(OBJ):$(DIRECTORY)/journal.c
	$(CC) -c $^ $(CFLAGS)

$(STATICNAME) : 
	$(CC) -c $(CFLAGS) $(DIRECTORY)/journal.c 
	$(AR) rcs $(STATICNAME) $(OBJ)	 	
 		 	
 		 
$(REALNAME) : $(OBJ)	
	$(CC) $(libCFLAGS) -Wl,-soname,$(SONAME) -o $@ $^ $(libLDLIBS)
	$(LINK) $@ $(SONAME)
	$(LINK) $@ $(LINKERFILENAME)

lib:$(STATICNAME) $(REALNAME)

clean : 
	rm -f *.o *$(NAME)* 

