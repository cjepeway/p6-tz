use TimeZone;

class EDT-TZ is TimeZone {
	my constant utc-offset = -4 * 60 * 60;
	my constant abbr = 'EDT';

	method new() { self.bless(name => abbr); }

	multi method utc-offset-in-seconds(Int $when? = time) returns Int { utc-offset }
	multi method utc-offset-in-seconds(DateTime:D $when) returns Int { utc-offset }
	multi method abbreviation(Int $when? = time) returns Str { abbr }
	multi method abbreviation(DateTime:D $when) returns Str { abbr }
}
