PREFIX ?= /usr
CFLAGS ?= -O2

all: libactgetdata.a libactgetdata.so
libactgetdata.a: getdata.o dirfile.o
	ar crs $@ $^
libactgetdata.so: getdata.o dirfile.o
	gcc -shared -o $@ $^

%.o: %.c
	gcc -fPIC -c -I. $(CFLAGS) $<

install: all
	mkdir -p $(PREFIX)/include/actpol $(PREFIX)/lib
	cp libactgetdata.a libactgetdata.so $(PREFIX)/lib
	cp actpol/*.h $(PREFIX)/include/actpol

clean:
	rm -f *.o *.a *.so
