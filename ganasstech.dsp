import("stdfaust.lib");
dirac = 1-1';
gaina = vslider("blend", 0, 0, 1, 0.01);
gainb = vslider("blend2", 0, 0, 1, 0.01);
mix = hgroup("vv", gaina, gainb);
phase1 = 1 : +~_ : %(4000);
phase2 = 1 : +~_ : %(8000);
loop1 = (10,dirac,phase1 : rdtable) + (os.sawtooth(440));
loop2 = (10,dirac,phase2 : rdtable) + (os.sawtooth(220));
process = (gaina*loop1 + gainb*loop2) <: _,_;
			