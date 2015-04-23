use TimeZone;

class UTC-TZ does TimeZone {
	method new() { self.bless(name => 'UTC'); }
	multi method utc-offset-in-seconds(Int $when? = 0) returns Int { 0 }
	multi method abbreviation(Int $when? = time) returns Str { 'UTC' }
}
