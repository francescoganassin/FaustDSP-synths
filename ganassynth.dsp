import("stdfaust.lib");
waveGenerator = os.sawtooth(freq) + os.triangle(freq*4) + os.triangle(freq*2)
  with {
  freq = hslider("freq",500,20,5000,1);
};

envelope = hgroup("[Envelope]",en.adsr(attack,decay,sustain,release,gate)*gate*0.3)
with{
	attack = hslider("[0]Attack[style:knob]",100,1,1000,1)*0.001;
	decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
	sustain = hslider("[2]Sustain[style:knob]",0.8,0.1,1,1);
	release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
	gain = hslider("[4]Gain[style:knob]",1,0,1,0.01);
	gate = button("[5]gate");
};
process = vgroup("Synth",waveGenerator*envelope);