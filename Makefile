P6 = perl6
PROVE = prove --nocolor -e '$(P6) -I.'
export LD_LIBRARY_PATH = /lib:/usr/lib:$(HOME)/lib

.PHONY: all test DNE

# for tests, so "make t/23-eek" works
t/% : DNE ; $(PROVE) -v $@

all:	test
test: 	
	$(PROVE) t/*
