role TimeZone {
	has Str $.name;

	method utc-offset-in-seconds(:(Instant $when? = now)) returns Int { ... }
	method abbreviation(:(Instant $when? = now)) { ... }

	method Numeric() { self.utc-offset-in-seconds() }
	method Str() { self.abbreviation() }
}

class NYT-TZ does TimeZone { 
	method new() { self.bless(name => 'America/New_York'); }
	method utc-offset-in-seconds(:(Instant $when? = now)) returns Int { 4 * 60 * 60 }
	method abbreviation(:(Instant $when? = now)) returns Str { 'EDT' }
}


use Test;

constant dt = 60 * 60 * 4;
constant name = 'America/New_York';
constant tz = 'EDT';
#my $tz = NYT-TZ.new(:name(name));
my $tz = NYT-TZ.new();
is($tz.name, name, 'name');
is($tz.abbreviation(), tz, 'abbr');
is(~$tz, tz, ".Str()");
is($tz.utc-offset-in-seconds(), dt, 'dt');
is(+$tz, dt, ".Numeric()");
