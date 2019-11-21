PREFIX ?= /usr
CFLAGS ?= -O2
CC     ?= gcc

all: libactgetdata.a libactgetdata.so
libactgetdata.a: getdata.o dirfile.o
	ar crs $@ $^
libactgetdata.so: dirfile.o getdata.o
	$(CC) -shared -fPIC -o $@ -I. $^ $(LDFLAGS) -lzzip -lslim -lc

%.o: %.c
	$(CC) -fPIC -c $(CFLAGS) -I. $<

install: all
	mkdir -p $(PREFIX)/include/actgetdata $(PREFIX)/lib
	cp libactgetdata.a libactgetdata.so $(PREFIX)/lib
	cp actgetdata/*.h $(PREFIX)/include/actgetdata

clean:
	rm -f *.o *.a *.so
