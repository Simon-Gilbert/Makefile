CC ?= gcc
AR ?= ar
OBJ ?= addition.o soustraction.o division.o multiplication.o
PROG ?= arithmetique
MAIN ?= main.o
LINK ?= ln -sf

#Bibliothèques

LIBMAJOR := .1
LIBMINOR := .0
LIBPATCH := .0

LINKERNAME = $(PROG)_library
LIBSTATIC = lib$(LINKERNAME).a
LINKERFILENAME = lib$(LINKERNAME).so
SONAME = $(LINKERFILENAME)$(LIBMAJOR)
REALNAME= $(SONAME)$(LIBMINOR)$(LIBPATCH)

CFLAGS ?= -Wall -fPIC
LDFLAGS ?= -L.


$(PROG): $(LIBSTATIC) $(REALNAME) $(MAIN)	
	$(CC) -o $@.static main.o $(LDFLAGS) -l:$(LIBSTATIC)
	$(CC) -o $@ $(MAIN) $(LDFLAGS) -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$@

compilation : $(OBJ)

$(LIBSTATIC): $(OBJ)
	$(AR) rcs $@ $^

$(REALNAME): $(OBJ)
	$(CC) $(CFLAGS) -shared -Wl,-soname,$(SONAME) -o $@ $^ -lc
	$(LINK) $@ $(SONAME)
	$(LINK) $@ $(LINKERFILENAME)

clean:
	rm -f *.o *$(PROG)*

 
