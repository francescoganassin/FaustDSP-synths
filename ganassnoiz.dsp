import("stdfaust.lib");
am = carrier*modulator
with{
 carrier = os.osc(carFreq);
 modulator = os.osc(modFreq);
	modFreq = hslider ("Modfreq[style:knob]",575,0.1,2000,30);
	carFreq = hslider ("Carfreq[style:knob]",428,50,2000,30);
};
process = (os.triangle(200) + os.osc(203) + os.osc(51) + am + no.noise/4 + os.sawtooth(400)) * (os.triangle(100) + os.osc(101) + am + no.noise/6 )/4;