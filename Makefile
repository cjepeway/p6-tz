P6 = perl6
PROVE = $(P6) -I.

.PHONY: all test

all:	test
test: 	t/*
	@for i in $? ; do echo $(PROVE) $$i ; $(PROVE) $$i ; done
