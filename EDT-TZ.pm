use TimeZone;

class EDT-TZ does TimeZone { 
	method new() { self.bless(name => 'EDT'); }
	method utc-offset-in-seconds(Instant $when? = now) returns Int { -4 * 60 * 60 }
	method abbreviation(Instant $when? = now) returns Str { 'EDT' }
}
