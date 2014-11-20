use TimeZone;
use UTC-TZ;

class DateTimeX is DateTime {
    multi method in-timezone(Int $offset) returns DateTimeX {
	say '>1';
	die 'too deep'
		if Backtrace.new.concise.gist.comb(/\n/).elems > 10;
	my DateTime $dt .= new(self.posix, :timezone($offset));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($dt.timezone),
					     :formatter($dt.formatter));
    }

    multi method in-timezone(TimeZone $tz) returns DateTimeX {
	say '>2';
	self.in-timezone($tz.utc-offset-in-seconds(self.posix));
    }

    multi method new(Int :$year, Int :$month = 1, Int :$day = 1,
		     Int :$hour = 0, Int :$minute = 0, :$second = 0,
		     TimeZone :$timezone,
		     :&formatter = &DateTime::default-formatter) {
	say '>3';
	my DateTimeX $dt .= new($year, $month, $day, $hour, $minute, $second);
	self.new($dt.earlier($timezone.utc-offset-in-seconds($dt.posix)).posix, $timezone);
    }

    multi method new(TimeZone :$timezone = UTC-TZ.new, *%_) {
	say '>4';
	%_.say;
	my DateTime $dt .= new(|%_);
	$dt.perl.say;
	self.new($dt.earlier(seconds => $timezone.utc-offset-in-seconds($dt.posix)).posix, :$timezone);
    }
}
