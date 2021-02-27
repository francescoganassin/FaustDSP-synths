import("stdfaust.lib");

waveGenerator = hgroup("[0]Wave Generator",no.noise,os.triangle(freq),os.square(freq),os.sawtooth(freq) : ba.selectn(4,wave))
with{
  wave = nentry("[0]Waveform",3,0,3,1);
  freq = vslider("[1]freq[style:knob]",440,40,2000,0.01);
};

subtractive = waveGenerator : hgroup("[i]Filters",filters);
filters = seq(i,3,someFilter(i))
with{
    someFilter(i) = hgroup("[%j]Peak EQ (%j)",fi.peak_eq(lvlfx*lfo,peakfreq,40))
    with{
        j = i+1;
        lvlfx = vslider("[0]Level FX",0,-10,10,0.01);
    	peakfreq = hslider("[1]Peak[style:knob]",(j^2)*200,0,4000,1);
    	bandwidth = hslider("[2]Bandwidth[style:knob]",40,20,200,1);
	lfoFreq = hslider("[3]LFO Freq[style:knob]",5,0.1,10,0.01);
	lfoDepth = hslider("[4]LFO Dpth[style:knob]",5,1,10,0.1);
	lfo = os.osc(lfoFreq)*lfoDepth;
    };
};

envelope = hgroup("[2]Envelope",en.adsr(attack,decay,sustain,release,gate)*gain*0.3)
with{
  attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
  gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
  gate = button("[5]gate");
};

process = vgroup("Sub Synth w Filters",subtractive*envelope);