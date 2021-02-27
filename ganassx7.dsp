import("stdfaust.lib");
freq = vslider("freq[style:knob]",440,400,500,1);
mod = os.osc(freq/2);
dxOsc(freq,mod,index) = os.osc(freq+mod*index);

timbre = hgroup("[0]Modulation", dxOsc(freq,index1) : dxOsc(freq,index1) : dxOsc(freq,index2) : dxOsc(freq,index3))
with{
index1 = vslider("Mod Index1",10,0,500,0.1);
index2 = vslider("Mod Index2",10,0,500,0.1);
index3 = vslider("Mod Index3",10,0,500,0.1);
};

sound = timbre : hgroup("[i]Filters",filters);
filters = seq(i,4,someFilter(i))
with{
    someFilter(i) = vgroup("[%j]Peak EQ (%j)",fi.peak_eq(lvlfx*lfo,peakfreq,40))
    with{
        j = i+1;
        lvlfx = vslider("[0]Level FX",0,0,10,0.01);
    	peakfreq = hslider("[1]Peak[style:knob]",(j^2)*200,0,4000,1);
    	bandwidth = hslider("[2]Bandwidth[style:knob]",40,20,200,1);
	lfoFreq = hslider("[3]LFO Freq[style:knob]",5,0.1,10,0.01);
	lfoDepth = hslider("[4]LFO Dpth[style:knob]",5,1,10,0.1);
	lfo = os.osc(lfoFreq)*lfoDepth;
    };
};
 envelope = vgroup("[1]Envelope",en.adsr(attack,decay,sustain,release,gate)*gain)
    with{
        attack = hslider("[0]Attack[style:knob]",50,1,1000,1)*0.001;
        decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
        sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
        release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
        gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
        gate = button("[5]gate");
};

process = hgroup("DX7 _ patch 1 1 2 3",envelope*sound) <:_,_:dm.zita_rev1;