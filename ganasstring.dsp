import("stdfaust.lib");
a = hslider("base Hz",80,20,200,1);
string(j) = +~(de.fdelay4(maxDelLength,delLength-1) : dispersionFilter:*(damping))
with{
  damping = hslider("damp",1,0.990,1,0.001);
  freq = a*(1+j);
  maxDelLength = 1024;
  dispersionFilter = _ <: _,_' :> /(2);
  delLength = ma.SR/freq;
};
nStrings = 12;
strum = hslider("strum",0,0,nStrings,1);
process = strum <: par(j,nStrings,(_ == j) : ba.impulsify : string(j)):>_,_;	