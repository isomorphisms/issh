IDRIC ?= idris2

.PHONY: all check clean

all:
	$(IDRIC) --build issh.ipkg

check:
	$(IDRIC) --build tests.ipkg
	./build/exec/issh-wire-tests

clean:
	rm -rf build
