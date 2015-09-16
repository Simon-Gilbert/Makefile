LIBMAJOR := .1
LIBMINOR := .0
LIBPATCH := .0
LINKERNAME ?= arithmetique_library
LIBSTATIC := lib$(LINKERNAME).a
LINKERFILENAME := lib$(LINKERNAME).so
SONAME := $(SONAME)$(LIBMINOR)$(LIBPATCH)

CC := gcc
AR := ar


CFLAGS := -Wall
LDFLAGS := -L.
LDLIBS := -l$(LINKERNAME)

libCFLAGS := -fPIC -Wall -shared
libLDFLAGS := .L.
libDLLIBS := -lc
libC := -c

addition.o: addition.c
 	$(CC) $(libCFLAGS) $(libC) $(libCFLAGS) addition.c

soustraction.o: soustraction.c
	$(CC) $(libCFLAGS) $(libC) $(libCFLAGS) soustraction.c

multiplication.o: multiplication.c
	$(CC) $(libCFLAGS) $(libC) $(libCFLAGS) multiplication.c

division.o: division.c
	$(CC) $(libCFLAGS) $(libC) $(libCFLAGS) division.c

libarithmetique_library.a: addition.o soustraction.o multiplication.o division.o
	ar rcs $(LIBSTATIC) addition.o soustraction.o multiplication.o division.o

libarithmetique_library.so.1.0.0: addition.o soustraction.o multiplication.o division.o
	gcc $(libCFLAGS) $(libCFLAGS) -Wl,-soname,libarithmetique_library.so.1 -o libarithmetique_library.so.$(LIBMAJOR)$(LIBMINOR)$(LIBPATCH) addition.o soustraction.o multiplication.o division.o $(libDLLIBS)
	ln -sf $(LINKERFILENAME).1.0.0 $(LINKERFILENAME)
	ln -sf $(LINKERFILENAME)$(LIBMAJOR)$(LIBMINOR)$(LIBPATCH) $(LINKERFILENAME)$(LIBMAJOR)

prog: libarithmetique_library.so.1.0.0 libarithmetique_library.a
	gcc -c $(libCFLAGS) main.c
	gcc -o arithmetique.static main.o $(LDFLAGS) -l:libarithmetique_library.a
	gcc -o arithmetique main.o $(LDFLAGS) -larithmetique_library
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./arithmetique

 
