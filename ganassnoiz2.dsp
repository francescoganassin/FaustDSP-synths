import("stdfaust.lib");
fm = os.osc(carFreq + os.osc(modFreq)*index)

with{
 	modFreq = hslider("Mod freq",0.4,0.1,2000,0.01);
	carFreq = hslider("Car freq",260,50,2000,0.01);
	index = hslider("Mod index",600,0,1000,0.1);
};
process = fm + no.noise*(vslider("Noise[style:knob]",0.1,0,1,0.01)) <: dm.freeverb_demo;

