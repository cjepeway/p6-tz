role TimeZone {
	has Str $.name;

	multi method utc-offset-in-seconds(Int $when? = time) returns Int { ... }
	multi method utc-offset-in-seconds(DateTime:D $when) returns Int { ... }
	multi method abbreviation(Int $when? = time) returns Str { ... }
	multi method abbreviation(DateTime:D $when) returns Str { ... }

	method Numeric() { self.utc-offset-in-seconds() }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
