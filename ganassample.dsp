import("stdfaust.lib");
looper(detune) = rwtable(tablesize,0.0,recIndex,_,readIndex)
with{
  record = button("Sample") : int;
  readSpeed = hslider("Read Speed[style:knob]",1,0.001,10,0.01);
  tablesize = 48000;
  recIndex = +(1)~*(record) : %(tablesize);
  readIndex = readSpeed*(detune+1)/float(ma.SR) : (+ : ma.decimal) ~ _ : *(float(tablesize)) : int;
};

polyLooper = hgroup("Looper",_ <: par(i,nVoices,looper(detune*i)) :> _,_)
with{
  nVoices = 10;
  detune = hslider("Detune[style:knob]",0.01,0,1,0.01);
};


efx = ba.bypass1(_,vcf)
with{
	mvcf_group(x) = hgroup("MOOG VCF",x);
	cb_group(x) = mvcf_group(hgroup("[0]",x));
	
		freq = mvcf_group(hslider("[1] Corner Freq [unit:PK]  [style:knob]",
		25, 1, 88, 0.01) : ba.pianokey2hz) : si.smoo;
	res = mvcf_group(hslider("[2] Corner Reso [style:knob]", 0, -1, 1, 0.01));
	outgain = mvcf_group(hslider("[3] VCF Out [unit:dB] [style:knob]", 5, -60, 20, 0.1)) : ba.db2linear : si.smoo;
	vcfbq = _ <: select2(_, ve.moog_vcf_2b(res,freq), ve.moog_vcf_2bn(res,freq));
	vcfarch = _ <: select2(_, ve.moog_vcf(res^4,freq), vcfbq);
	vcf = vcfarch : *(outgain);
};

dist = ba.bypass1(_, ef.cubicnl_nodc(drive:si.smoo,offset:si.smoo))
with{
	cnl_group(x)  = hgroup("Soft Dist", x);
drive = cnl_group(hslider("[1] Drive [style:knob]",
		0, 0, 1, 0.01));
	offset = cnl_group(hslider("[2] Destroy [style:knob]",
		0, 0, 1, 0.01));
};

Nightmare = dm.zita_light :> efx : dist;
process = hgroup("Ghostify",polyLooper:Nightmare)<:_,_;