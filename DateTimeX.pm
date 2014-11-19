use TimeZone;
my Int $i;
class DateTimeX is DateTime {
    multi method in-timezone(Int $offset) returns DateTimeX {
	$i++;
	say "$i: ", Backtrace.new.concise;
	return DateTimeX if $i > 3;
	return self.later(seconds => $offset)
    }

    multi method in-timezone(TimeZone $tz) returns DateTimeX {
	say 2;
	return self.later(seconds => $tz.utc-offset-in-seconds(self.posix));
    }
}
