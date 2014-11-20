use TimeZone;

class UTC-TZ does TimeZone {
	method new() { self.bless(name => 'UTC'); }
	method utc-offset-in-seconds(Int $when? = 0) returns Int { 0 }
	method abbreviation(Int $when? = time) returns Str { 'UTC' }
}
