use TimeZone;

class UTC-TZ is TimeZone {
	method new() { self.bless(name => 'UTC'); }
	multi method utc-offset-in-seconds(Int $when) returns Int { 0 }
	multi method utc-offset-in-seconds(DateTime) returns Int { 0 }
	multi method abbreviation(Int $when) returns Str { 'UTC' }
	multi method abbreviation(DateTime $when) returns Str { 'UTC' }
}
