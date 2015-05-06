use UTC-TZ;

class EDT-TZ is UTC-TZ {
	my constant utc-offset = -4 * 60 * 60;

	method new() { self.bless(name => 'EDT'); }

	multi method utc-offset-in-seconds(Int $when? = time) returns Int { utc-offset }
	multi method utc-offset-in-seconds(DateTime:D $when) returns Int { utc-offset }

	method utc() { UTC-TZ.new }
}
