p6-tz
=====

toy implementation of timezones for perl6

In its current incarnation, this module hooks into the [IANA Olson TZ library](https://github.com/eggert/tz)
via NativeCall.

### Building a Shared Version of the Olson DB ###

These instructions are for Linux.

First, download the sucker from https://github.com/eggert/tz.
Then, build it as a shared library:

```
  $ make LDFLAGS=-shared CFLAGS=-fpic -g -DNETBSD_INSPIRED clean all
  $ ld -fpic -shared -o libtz.so localtime.o asctime.o difftime.o
```

Next, put the resulting libtz.so somewhere in your LD_LIBRARY_PATH.
Me, I stick it in ~/lib:

```
  $ cp libtz.so ~/lib
```

The Makefile in p6-tz will look for it there.

### Make p6-tz ###

The Makefile will, by default, just run all the tests:

```
  $ make
```

### Working with DateTime ###

The `04-datetime` test is meant to test p6-tz's integration with
perl6's builtin DateTime class.  That integration isn't quite right,
so the test fails.

Ah, but how isn't it right?  That's a tale for another commit,
but for now, suffice it to say that the problem seems to me
to be that DateTime expects TZ offsets to remain static
when instead they are a function of the time to which they are applied.
