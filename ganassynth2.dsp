import("stdfaust.lib");
waveGenerator = hgroup("[0]Wave Generator",no.noise,os.triangle(freq),os.square(freq),os.sawtooth(freq) : ba.selectn(4,wave))
with{
  wave = nentry("[0]Waveform",3,0,3,1);
  freq = hslider("[1]freq",440,50,2000,0.01);
};

filters = seq(i,2,someFilter(i))
with{
 
  someFilter(i) = hgroup("[2]Peak eq %i",fi.peak_eq(Lfx,fx,band))
  with{
    lfoFreq = hslider("[2]LFO Frequency %i [style:knob]",10,0.1,20,0.01);
    lfoDepth = hslider("[3]LFO Depth %i [style:knob]",500,1,10000,1);
    freq = hslider("[1]PeakFreq %i [style:knob]", 440,50,2000,0.01);
    Lfx = hslider("[4]PeakAmplitude(DB) %i [style:knob]", 0,-10,10,0.1);
    fx = os.osc(lfoFreq)*lfoDepth + freq;
    //fx = freq;
    band = hslider("[5]PeakBand(Hz) %i [style:knob]", 500,1,10000,1);
  };
};

envelope = hgroup("[3]Envelope",en.adsr(attack,decay,sustain,release,gate)*gain*0.3)
with{
  attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
  decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
  sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
  release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
  gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
  gate = button("[5]gate");
  //gate = 1;
};

process = (waveGenerator : filters) * envelope;