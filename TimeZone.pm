class TimeZone {
	has Str $.name;

	multi method utc-offset-in-seconds(Int $when) returns Int {}
	multi method utc-offset-in-seconds(DateTime $when) returns Int {}
	multi method abbreviation(Int $when) returns Str {}
	multi method abbreviation(DateTime $when) returns Str {}

	method Numeric() { self.utc-offset-in-seconds(time) }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
