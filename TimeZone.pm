role TimeZone {
	has Str $.name;

	method utc-offset-in-seconds(Instant $when? = now) returns Int { ... }
	method abbreviation(Instant $when? = now) { ... }

	method Numeric() { self.utc-offset-in-seconds() }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
