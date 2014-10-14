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

my class tm is repr('CStruct') {
	has int $.sec;      # seconds (0–60)
	has int $.min;      # minutes (0–59)
	has int $.hour;     # hours (0–23)
	has int $.mday;     # day of month (1–31)
	has int $.mon;      # month of year (0–11)
	has int $.year;     # year - 1900
	has int $.wday;     # day of week (Sunday = 0)
	has int $.yday;     # day of year (0–365)
	has int $.isdst;    # is summer time in effect?
	has CPointer $.zone;# abbreviation of time zone name
	has int $.gmtoff;   # offset from UT in seconds
}

sub tzalloc(Str) returns OpaquePointer is native('libtz') { * }

class Olson-TZ does TimeZone { 
	has OpaquePointer $!olson-timezone;
	submethod BUILD(Str $name) {
		$!olson-timezone = tzalloc($name);	
	}
}
