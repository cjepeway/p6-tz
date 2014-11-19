use TimeZone;
my Int $i;
class DateTimeX is DateTime {
    multi method in-timezone(Int $offset) returns DateTimeX {
	my DateTime $dt .= new(self.posix, :timezone($offset));
	return self.clone-without-validating(:year($dt.year), :month($dt.month), :day($dt.day),
					     :hour($dt.hour), :second($dt.second),
					     :timezone($dt.timezone),
					     :formatter($dt.formatter));
    }

    multi method in-timezone(TimeZone $tz) returns DateTimeX {
	self.in-timezone($tz.utc-offset-in-seconds(self.posix));
    }
}
