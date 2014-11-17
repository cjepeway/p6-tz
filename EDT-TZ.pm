use TimeZone;

class EDT-TZ does TimeZone {
	method new() { self.bless(name => 'EDT'); }
	method utc-offset-in-seconds(Int $when? = time) returns Int { -4 * 60 * 60 }
	method abbreviation(Int $when? = time) returns Str { 'EDT' }
}
