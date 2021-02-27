import("stdfaust.lib");
waveGenerator = hgroup("[0]Wave Generator",os.osc(freq),os.triangle(freq),os.square(freq),os.sawtooth(freq) : ba.selectn(4,wave))

with{
	wave = nentry("[0]Waveform",0,0,2,1);
	freq = hslider("[1]freq",440,50,2000,0.01);
};
envelope = hgroup("[Envelope]",en.adsr(attack,decay,sustain,release,gate)*gate*0.3)

with{
	attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
	decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
	sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
	release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
	gain = hslider("[4]Gain[style:knob]",1,0,1,0.01);
	gate = button("[5]gate");
};
process = vgroup("Synth",waveGenerator*envelope);
			