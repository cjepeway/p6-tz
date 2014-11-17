role TimeZone {
	has Str $.name;

	method utc-offset-in-seconds(Int $when? = time) returns Int { ... }
	method abbreviation(Int $when? = time) returns Str { ... }

	method Numeric() { self.utc-offset-in-seconds() }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
