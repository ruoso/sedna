all:
	make -C driver/c

clean:
	make -C driver/c clean
	make -C kernel/common/errdbg clean
	for I in `find . -name '*.d'`; do rm -v $I; done
