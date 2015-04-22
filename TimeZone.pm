role TimeZone {
	has Str $.name;

	multi method utc-offset-in-seconds(::T $when where Int|DateTime) returns Int { ... }
	multi method abbreviation(::T $when where Int|DateTime) returns Str { ... }

	method Numeric() { self.utc-offset-in-seconds() }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
