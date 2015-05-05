use TimeZone;
use UTC-TZ;
use Olson-TZ;

class DateTimeX is DateTime {
    has TimeZone:D $.timezone;

    submethod BUILD(:$timezone = UTC-TZ.new, |) {
	$!timezone = $timezone;
    }

    method posix() {
	#say ">0\n", Backtrace.new.concise;
	#say "<{self.perl}>";
	#say "[{$.timezone.perl}]";
	#$.timezone.WHAT.say;
	#$.timezone.utc-offset-in-seconds(self).say;
	#say 'abbr: ', $.timezone.abbreviation(self);
	#$.timezone.say;
	my $t = callwith(True);
	$t - $.timezone.utc-offset-in-seconds(self);
    }

    # stolen from DateTime
    multi method new(Instant:D $i, TimeZone :$timezone=UTC-TZ.new, :&formatter=&default-formatter) {
	#say ">1\n", Backtrace.new.concise;
	#say "[{$timezone.perl}]";
        my ($p, $leap-second) = $i.to-posix;
        my DateTimeX $dtx = self.new: floor($p - $leap-second).Int, :&formatter, :$timezone;
        $dtx.clone(second => ($dtx.second + $p % 1 + $leap-second)
            ).in-timezone($timezone);
    }

    method   utc() { return self.in-timezone($.timezone.utc);   }
    method local() { return self.in-timezone($.timezone.local); }

    multi method in-timezone(Int $offset) returns DateTimeX {
	given $offset {
	    when 0	{ return self.utc();   }
	    when +$*TZ	{ return self.local(); }
	}
	die "slicing TimeZone off " ~ self;
    }

    multi method in-timezone(TimeZone:D $tz) {
	#say ">2\n", Backtrace.new.concise;
	#self.perl.say;
	#$tz.perl.say;
	#$tz.utc-offset-in-seconds(self).say;
	my DateTime $dt .= new(self.posix, :timezone($tz.utc-offset-in-seconds(self)));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($tz),
					     :formatter($dt.formatter));
    }

    multi method new(TimeZone :$timezone = UTC-TZ.new, *%_) {
	##say ">3\n", Backtrace.new.concise;
	##$timezone.perl.say;
	##%_.say;
	my $me = self.bless(:$timezone, |%_);
	##$me.perl.say;
	$me;
	#my $dtx = callwith(|%_);
	###$dtx.perl.say;
	#$dtx.timezone = $timezone;
	#$dtx;
    }
}
