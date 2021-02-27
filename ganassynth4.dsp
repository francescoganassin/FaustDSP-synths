import("stdfaust.lib");
gain = hslider("gain",0.1,0,1,0.01);
freq = hslider("freq",180,50,1000,1);
gate = button("play");
timbre(f) = os.osc(f+4)*0.5 + os.osc(f+40*2)*0.25 + os.osc(f*3.1)*0.125;
process = gain*gate*timbre(freq) <: dm.freeverb_demo;
			