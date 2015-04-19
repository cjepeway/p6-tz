use TimeZone;
use UTC-TZ;

class DateTimeX is DateTime {
    method posix() {
	self.timezone.mktime(self);
    }

    multi method in-timezone(Int $offset) returns DateTimeX {
	say ">1\n", Backtrace.new.concise;
	die 'too deep'
		if Backtrace.new.concise.gist.comb(/\n/).elems > 10;
	my DateTime $dt .= new(self.posix, :timezone($offset));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($dt.timezone),
					     :formatter($dt.formatter));
    }

    multi method in-timezone(TimeZone $tz) {
	say ">2\n", Backtrace.new.concise;
	my DateTimeX $dtx .= new(self.posix, :timezone($tz.utc-offset-in-seconds(self.posix)));
	$dtx.clone-without-validating(:timezone($tz));
    }

    multi method new(TimeZone :$timezone = UTC-TZ.new, *%_) {
	say ">3\n", Backtrace.new.concise;
	%_.say;
	my DateTime $dt .= new(|%_);
	$dt.perl.say;
	$timezone.perl.say;
	say '[ ', self.new($dt.earlier(seconds => $timezone.utc-offset-in-seconds($dt.posix)).posix, :$timezone).perl, ' ]';
	self.new($dt.earlier(seconds => $timezone.utc-offset-in-seconds($dt.posix)).posix, :$timezone);
    }
}
