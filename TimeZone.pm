class TimeZone {
	has Str $.name;

	method unimplemented($which) is hidden-from-backtrace {
	    die self ~~ TimeZone ?? "abstract class TimeZone instantiated"
				 !! "abstract method unimplemented in subclass";
	}

	multi method utc-offset-in-seconds(Int $when) returns Int { self.unimplemented(&?ROUTINE); }
	multi method utc-offset-in-seconds(DateTime $when) returns Int { self.unimplemented(&?ROUTINE); }
	multi method abbreviation(Int $when) returns Str { self.unimplemented(&?ROUTINE); }
	multi method abbreviation(DateTime $when) returns Str { self.unimplemented(&?ROUTINE); }

	method utc() returns TimeZone { ... }
	method local() returns TimeZone { ... }

	method Numeric() { self.utc-offset-in-seconds(time) }
	method Str() { self.abbreviation() }
	method Int() { self.Numeric() }
}
