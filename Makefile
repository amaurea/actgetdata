PREFIX ?= /usr
CFLAGS ?= -O2

all: libactgetdata.a libactgetdata.so
libactgetdata.a: getdata.o dirfile.o
	ar crs $@ $^
libactgetdata.so: dirfile.o getdata.o
	gcc -shared -fPIC -o $@ -I. $^ $(LDFLAGS) -lzzip -lslim -lc

%.o: %.c
	gcc -fPIC -c $(CFLAGS) -I. $<

install: all
	mkdir -p $(PREFIX)/include/actpol $(PREFIX)/lib
	cp libactgetdata.a libactgetdata.so $(PREFIX)/lib
	cp actpol/*.h $(PREFIX)/include/actpol

clean:
	rm -f *.o *.a *.so
