use TimeZone;
class UTC-TZ {...};

role Basic-TZ is TimeZone {
	method new() { self.unimplemented(&?ROUTINE); }
	multi method abbreviation(Int $when = time) returns Str { $.name }
	multi method abbreviation(DateTime $when) returns Str { $.name }
	method utc() { UTC-TZ.new; }
	method local() { die "{$.name} doesn't know local timezone"; }
}

class UTC-TZ does Basic-TZ {
	method new() { self.bless(name => 'UTC'); }
	multi method utc-offset-in-seconds(Int $when = time) returns Int { 0 }
	multi method utc-offset-in-seconds(DateTime $when) returns Int { 0 }
	method utc() returns TimeZone { return self; }
}
