use TimeZone;

class UTC-TZ is TimeZone {
	method new() { self.bless(name => 'UTC'); }
	multi method utc-offset-in-seconds(Int $when = time) returns Int { 0 }
	multi method utc-offset-in-seconds(DateTime $when) returns Int { 0 }
	multi method abbreviation(Int $when = time) returns Str { $.name }
	multi method abbreviation(DateTime $when) returns Str { $.name }
	method utc() { return self; }
	method local() { die "{$.name} doesn't know local timezone"; }
}
