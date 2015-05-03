P6 = perl6
PROVE = prove --nocolor -e '$(P6) -I $(PWD)'
export LD_LIBRARY_PATH = /lib:/usr/lib:$(HOME)/lib

.PHONY: all test clean DNE

# for tests, so "make t/23-eek" works
t/% : DNE ; $(PROVE) -v $@

all:	test

test: 	
	@$(P6) --version
	$(PROVE) t/*

clean:
	rm -f core
