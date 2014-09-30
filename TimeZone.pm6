role TimeZone {
	has Str $.name;

	multi method rule(:(Instant $when? = now)) returns Int { 4 * 60 * 60 };
	method offset-in-seconds(:(Instant $when? = now)) returns Int { return .rule($when) }

	multi method rule(:(Instant $when? = now)) returns Str {...};
	method abbreviation(:(Instant $when? = now)) { say 'abbr: ', $when; say .rule($when); .rule($when) }

	method Numeric() { .offset-in-seconds() }
	method Str() { .abbreviation() }
}

class NYT-TZ does TimeZone { 
	multi method rule(:(Instant $when? = now)) returns Int { say 'rule Int'; 4 * 60 * 60 }
	multi method rule(:(Instant $when? = now)) returns Str { 'EDT' }
}

class foo {
	multi method eek() returns Int { 1 }
	mulit method eek() returns Str { 's' }
}

use Test;

is (+foo.new.eek(), 1, 'foo Int');
is (+foo.new.eek(), 's', 'foo Str');

constant dt = 60 * 60 * 4;
constant name = 'America/New_York';
constant tz = 'EDT';
my $tz = NYT-TZ.new(:name(name));
say $tz;
dd $tz;
is($tz.abbreviation(), tz, 'abbr');
is(~$tz, tz, ".Str()");
is($tz.offset-in-seconds(), dt, 'dt');
is(+$tz, dt, ".Numeric()");
