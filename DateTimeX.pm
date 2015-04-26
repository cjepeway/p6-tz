use TimeZone;
use UTC-TZ;

class DateTimeX is DateTime {
    has TimeZone:D $.timezone;

    method posix() {
	say ">0\n", Backtrace.new.concise;
	self.perl.say;
	$.timezone.perl.say;
	$.timezone.WHAT.say;
	$.timezone.say;
	callwith(True) - $.timezone.utc-offset-in-seconds(self);
    }

    multi method in-timezone(Int $offset) returns DateTimeX {
	die "slicing TimeZone off " ~ self
		unless $offset == 0;
	return self.in-timezone(UTC-TZ.new);
    }

    # stolen from DateTime, augmented to keep a TimeZone around
    multi method new(Instant:D $i, TimeZone :$timezone=UTC-TZ.new, :&formatter=&default-formatter) {
	say ">1\n", Backtrace.new.concise;
	$timezone.perl.say;
        my ($p, $leap-second) = $i.to-posix;
        my DateTimeX $dtx = self.new: floor($p - $leap-second).Int, :&formatter, :$timezone;
        $dtx.clone(second => ($dtx.second + $p % 1 + $leap-second)
            ).in-timezone($timezone);
    }

    multi method in-timezone(TimeZone:D $tz) {
	say ">2\n", Backtrace.new.concise;
	self.perl.say;
	$tz.perl.say;
	$tz.utc-offset-in-seconds(self).say;
	my DateTime $dt .= new(self.posix, :timezone($tz.utc-offset-in-seconds(self)));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($tz),
					     :formatter($dt.formatter));
    }


    multi method new(TimeZone :$timezone = UTC-TZ.new, *%_) {
	#say ">3\n", Backtrace.new.concise;
	#$timezone.perl.say;
	#%_.say;
	my $me = self.bless(:$timezone, |%_);
	#$me.perl.say;
	$me;
	#my $dtx = callwith(|%_);
	##$dtx.perl.say;
	#$dtx.timezone = $timezone;
	#$dtx;
    }
}
