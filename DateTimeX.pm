use TimeZone;
use UTC-TZ;

class DateTimeX is DateTime {
    multi method in-timezone(Int $offset) returns DateTimeX {
	say '>1';
	self.WHAT.note:
	die 'too deep'
		if Backtrace.new.concise.gist.comb(/\n/).elems > 10;
	my DateTime $dt .= new(self.posix(True), :timezone($offset));
	say '>1.5';
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($dt.timezone),
					     :formatter($dt.formatter));
    }

    multi method in-timezone(TimeZone $tz) returns DateTimeX {
	say '>2';
	self.in-timezone($tz.utc-offset-in-seconds(self.posix(True)));
    }

    multi method new(TimeZone :$timezone = UTC-TZ.new, *%_) {
	say '>4';
	%_.say;
	my DateTime $dt .= new(|%_);
	$dt.perl.say;
	self.new($dt.earlier(seconds => $timezone.utc-offset-in-seconds($dt.posix)).posix, :$timezone);
    }
}
