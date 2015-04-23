use TimeZone;
use UTC-TZ;

class DateTimeX is DateTime {
    has TimeZone $.timezone;

    method posix() {
	callwith(True);
    }

#
#	really, this method should fail(); if it were ever implemented, we'd know
#	we'd created a DateTimeX that didn't have a TimeZone
#
#    multi method in-timezone(Int $offset) returns DateTimeX {
#	say ">0\n", Backtrace.new.concise;
#	die 'too deep'
#		if Backtrace.new.concise.gist.comb(/\n/).elems > 10;
#	my DateTime $dt .= new(self.posix, :timezone($offset));
#	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
#					     :hour($dt.hour), :second($dt.second),
#					     :timezone($dt.timezone),
#					     :formatter($dt.formatter));
#    }

    # stolen from DateTime, augmented to keep a TimeZone around
    multi method new(Instant:D $i, TimeZone :$timezone=UTC-TZ.new, :&formatter=&default-formatter) {
	say ">1\n", Backtrace.new.concise;
        my ($p, $leap-second) = $i.to-posix;
        my $dt = self.new: floor($p - $leap-second).Int, :&formatter, :$timezone;
        $dt.clone(second => ($dt.second + $p % 1 + $leap-second)
            ).in-timezone($timezone);
    }

    multi method in-timezone(TimeZone $tz) {
	say ">2\n", Backtrace.new.concise;
	my DateTime $dt .= new(self.posix, :timezone($tz.utc-offset-in-seconds(self)));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($tz),
					     :formatter($dt.formatter));
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
