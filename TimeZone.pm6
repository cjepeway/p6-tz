role TimeZone {
	has Str $.name;
	has Int $.offset-in-seconds;
	has Str $.abbreviation;

	multi method rule(:(Instant $when? = now)) returns Int {...};
	method offset-in-seconds(:(Instant $when? = now)) { return .rule($when) }

	multi method rule(:(Instant $when? = now)) returns Str {...};
	method abbreviation(:(Instant $when? = now)) { return .rule($when) }

	method Numeric() { $!offset-in-seconds }
	method Str() { $!abbreviation }
}

class NYT-TZ does TimeZone { 
	multi method rule(:(Instant $when? = now)) returns Int { 4 * 60 * 60 }
	multi method rule(:(Instant $when? = now)) returns Str { 'EDT' }
}

use Test;

constant dt = 60 * 60 * 4;
constant name = 'America/New_York';
constant tz = 'EDT';
my $tz = NYT-TZ.new(:name(name));
is(+$tz, dt, ".Numeric()");
is(~$tz, tz, ".Str()");
