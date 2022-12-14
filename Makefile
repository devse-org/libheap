CFLAGS += -I. -fPIC

# enable asan
CFLAGS += -fsanitize=address -fno-omit-frame-pointer

# enable ubsan
CFLAGS += -fsanitize=undefined

.PHONY: all
all: libheap.so libheap.a

.PHONY: clean
clean:
	rm -f *.o *.so *.a *.d
	rm -f impl/*.o impl/*.d

%.so:
	$(CC) -shared -o $@ $^

%.a:
	$(AR) rcs $@ $^

libheap.so: libheap.o
libheap.a: libheap.o

libheap-posix.so: libheap.o impl/posix.o
libheap-posix.a: libheap.o impl/posix.o

tests: tests.o libheap.o impl/mmap.o
	$(CC) $(CFLAGS) -o $@ $^