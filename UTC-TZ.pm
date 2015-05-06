use Basic-TZ;

class UTC-TZ does Basic-TZ {
	new() { self.bless(name => 'UTC'); }
	multi method utc-offset-in-seconds(Int $when = time) returns Int { 0 }
	multi method utc-offset-in-seconds(DateTime $when) returns Int { 0 }
	method utc() returns TimeZone { return self; }
}
