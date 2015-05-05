use TimeZone;
use NativeCall;

#`{
	int tm_sec;      /∗ seconds (0–60) ∗/
	int tm_min;      /∗ minutes (0–59) ∗/
	int tm_hour;     /∗ hours (0–23) ∗/
	int tm_mday;     /∗ day of month (1–31) ∗/
	int tm_mon;      /∗ month of year (0–11) ∗/
	int tm_year;     /∗ year - 1900 ∗/
	int tm_wday;     /∗ day of week (Sunday = 0) ∗/
	int tm_yday;     /∗ day of year (0–365) ∗/
	int tm_isdst;    /∗ is summer time in effect? ∗/
	char ∗tm_zone;   /∗ abbreviation of time zone name ∗/
	long tm_gmtoff;  /∗ offset from UT in seconds ∗/
}

my class LongPointer is repr('CStruct') {
	has int $.i;
}

my class tm is repr('CStruct') {
	has int32 $.sec;	# seconds (0–60)
	has int32 $.min;	# minutes (0–59)
	has int32 $.hour;	# hours (0–23)
	has int32 $.mday;	# day of month (1–31)
	has int32 $.mon;	# month of year (0–11)
	has int32 $.year;	# year - 1900
	has int32 $.wday;	# day of week (Sunday = 0)
	has int32 $.yday;	# day of year (0–365)
	has int32 $.isdst;	# is summer time in effect?
	has   int $.gmtoff;	# offset from UT in seconds
	has   Str $.zone;	# abbreviation of time zone name
}

sub tzalloc(Str) returns OpaquePointer is native('libtz') { * }
sub localtime_rz(OpaquePointer, LongPointer, tm) returns tm is native('libtz') { * }
sub mktime_z(OpaquePointer, tm) returns int is native('libtz') { * }

class Olson-TZ is TimeZone { 
	has OpaquePointer $!olson-timezone;

	submethod BUILD(:$name = 'UTC') {
		$!olson-timezone = tzalloc($name);
	}

	method utc() {
		self.new();
	}

	method local() {
		self.new(:name(Str));	# this passes a NULL to tzalloc, which will then return the local timezone
	}

	multi method tm(Int $t) {
		my tm $tm .= new;
		localtime_rz($!olson-timezone, LongPointer.new(i => $t.Int), $tm);
	}

	multi method tm(DateTime $dt) {
		tm.new(sec => $dt.second.floor,
		       min => $dt.minute,
		       hour => $dt.hour,
		       mday => $dt.day,
		       mon => $dt.month,
		       year => $dt.year - 1900,
		       isdst => -1,
		       ); #gmtoff => $dt.timezone.Int);
	}

	method mktime(DateTime $dt) returns Int {
		return mktime_z($!olson-timezone, self.tm($dt));
	}

	multi method utc-offset-in-seconds(Int $when) returns Int {
		return self.tm($when).gmtoff;
	}

	multi method utc-offset-in-seconds(DateTime $when) returns Int {
		return self.utc-offset-in-seconds(self.mktime($when));
	}

	multi method abbreviation(Int $when? = time) {
		return self.tm($when).zone;
	}

	multi method abbreviation(DateTime $when) {
		return self.abbreviation(self.mktime($when));
	}
}
