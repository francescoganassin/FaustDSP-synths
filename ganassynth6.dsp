
declare name “ganassynth6”;

import("stdfaust.lib");
waveGenerator = no.noise/34 + os.triangle(freq)
  with{
freq = hslider("freq[style:knob]",60,50,2000,0.1);
};
subtractive = waveGenerator : hgroup("[1]Filter",fi.resonlp(resFreq,q,1))
with{
ctFreq = hslider("[0]Cutoff Frequency[style:knob]",2000,50,10000,0.1);
q = hslider("[1]Q[style:knob]",5,1,30,0.1);
lfoFreq = hslider("[2]LFO Freq[style:knob]",110,0.1,200,0.01);
lfoDepth = hslider("[3]LFO Depth[style:knob]",500,1,10000,1);
resFreq = ctFreq + os.osc(lfoFreq)*lfoDepth : max(30);
};
process = subtractive;
 

