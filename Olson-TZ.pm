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

class Olson-TZ does TimeZone { 
	has OpaquePointer $!olson-timezone;

	submethod BUILD(:$!name) {
		$!olson-timezone = tzalloc($!name);	
	}

	method tm(Instant $t) {
		my tm $tm .= new;
		localtime_rz($!olson-timezone, LongPointer.new(i => $t.Int), $tm);
	}

	method utc-offset-in-seconds(Instant $when? = now) returns Int {
		return self.tm($when).gmtoff;
	}

	method abbreviation(Instant $when? = now) {
		return self.tm($when).zone;
	}
}
