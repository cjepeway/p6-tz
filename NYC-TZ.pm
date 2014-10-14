use TimeZone;

class NYT-TZ does TimeZone { 
	method new() { self.bless(name => 'America/New_York'); }
	method utc-offset-in-seconds(:(Instant $when? = now)) returns Int { 4 * 60 * 60 }
	method abbreviation(:(Instant $when? = now)) returns Str { 'EDT' }
}
