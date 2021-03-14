import("stdfaust.lib");
freq = vslider("freq[style:knob]",440,400,500,1);
mod = os.osc(freq/2);
dxOsc(freq,mod,index) = os.triangle(freq+mod*index)+os.triangle(freq*2)+(os.triangle(freq*4)/7)+(os.sawtooth(freq/2)/9) ;

timbre = vgroup("[0]Modulation", dxOsc(freq,index1) : dxOsc(freq,index2) : dxOsc(freq,index2) : dxOsc(freq,index3))
with{
index1 = hslider("Mod 1",500,0,500,0.1);
index2 = hslider("Mod 2",2,0,10,0.1);
index3 = hslider("Mod 3",40,0,100,0.1);
};

sound = timbre : vgroup("[i]Filters",filters);
filters = seq(i,2,someFilter(i))
with{
    someFilter(i) = hgroup("[%j]Peak EQ %j",fi.peak_eq(lvlfx*lfo,peakfreq,bandwidth))
    with{
        j = i+1;
        lvlfx = hslider("[0]Level FX",4,0,5,0.01);
    	peakfreq = hslider("[1]Peak[style:knob]",(j^2)*10,10,100,1);
    	bandwidth = hslider("[2]Bandwidth[style:knob]",100,20,200,1);
	lfoFreq = hslider("[3]LFO Freq[style:knob]",((i+2)^2)*1,0,100,0.01);
	lfoDepth = hslider("[4]LFO Dpth[style:knob]",3,1,5,0.1);
	lfo = os.osc(lfoFreq)*lfoDepth;
    };
};
 envelope = hgroup("[1]Envelope",en.adsr(attack,decay,sustain,release,gate)*gain)
    with{
        attack = hslider("[0]Attack[style:knob]",0,0,1000,1)*0.001;
        decay = hslider("[1]Decay[style:knob]",50,1,1000,1)*0.001;
        sustain = hslider("[2]Sustain[style:knob]",0.8,0.01,1,1);
        release = hslider("[3]Release[style:knob]",50,1,1000,1)*0.001;
        gain = hslider("[4]gain[style:knob]",1,0,1,0.01);
        gate = button("[5]gate");
};
process = vgroup("scandinavian",envelope*sound)<:_,_:dm.zita_rev1 ;