use Basic-TZ;
class GMT-TZ is UTC-TZ {
    method new() { self.bless(name => 'GMT'); }
}
