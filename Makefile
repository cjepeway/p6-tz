P6 = perl6
HARNESS = $(P6) -I.

.PHONY: all test

all:	test
test: 
	$(HARNESS) t/*
