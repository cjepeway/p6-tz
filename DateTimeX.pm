use TimeZone;
use UTC-TZ;
use Olson-TZ;

class DateTimeX is DateTime {
    has TimeZone:D $.timezone;

    submethod BUILD(:$timezone = UTC-TZ.new, |) {
	$!timezone = $timezone;
    }

    method posix() {
	my $t = callwith(True);
	$t - $.timezone.utc-offset-in-seconds(self);
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
	my DateTime $dt .= new(self.posix, :timezone($tz.utc-offset-in-seconds(self)));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($tz),
					     :formatter($dt.formatter));
    }
}
