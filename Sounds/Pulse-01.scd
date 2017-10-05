

s.boot;

(
SynthDef.new(\pulse, {
	arg room, mix, damp, ampHz=4, fund=40, maxPartial=4, width=0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	//Create amplitude pulse hits
	amp1 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, 0.0, 0.12) * 0.75;
	//Create random frequencies using LFNoise
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	//Pulse the Frequencies
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	//Pulse signals using freq and amp variables
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	//Add reverb to both
	sig1 = FreeVerb.ar(sig1, mix, room, damp);
	sig2 = FreeVerb.ar(sig2, mix, room, damp);

	//Output signals to both speakers
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

(
x = Synth.new(\pulse);

x.set(\width, 0.5);
x.set(\ampHz, 1);
x.set(\fund, 400);
x.set(\matPartial, 40);
x.set(\damp, 0.25);
x.set(\mix, 0.33);
x.set(\room, 5.0);
)

s.quit;
