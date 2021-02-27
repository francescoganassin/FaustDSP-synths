import("stdfaust.lib");
am = carrier*modulator
with{
 carrier = os.osc(carFreq);
 modulator = os.osc(modFreq);
 	modFreq = hslider("mod Hz",20,0.1,2000,0.01);
	carFreq = hslider("car Hz",440,50,2000,0.01);
};
gate = button("gate");
process = gate*hslider("gain",0,0,1,0.01)*am;