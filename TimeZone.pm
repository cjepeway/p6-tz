class TimeZone {
	has Str $.name;

	multi method utc-offset-in-seconds(Int $when) returns Int { die; }
	multi method utc-offset-in-seconds(DateTime $when) returns Int { die; }
	multi method abbreviation(Int $when) returns Str { die; }
	multi method abbreviation(DateTime $when) returns Str { die; }

	method Numeric() { self.utc-offset-in-seconds(time) }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
