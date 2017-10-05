(
~tone = {
	arg freq=500, amp=0.5, gate=0;
	var sig, env;
	env = EnvGen.kr(
		Env.asr,
		gate,
		doneAction:2
	);
	sig = SinOsc.ar(freq, 0, amp);
	sig = sig * env;
	Out.ar(0, sig!2);
}
)





x = ~tone.play(args:[\freq, exprand(100, 1000)]);
x.set(\gate, 1, \amp, 0.2);


(
SynthDef.new(\pureTone,
	{
	arg freq=500, amp=0.5, gate=1;
	var sig, env;
	env = EnvGen.kr(
		Env.asr,
		gate,
		doneAction:2
	);
	sig = SinOsc.ar(freq, 0, amp);
	sig = sig * env;

	Out.ar(0, sig!2);
}).add;
)

(
x = Synth.new(\pureTone);
x.set(\freq, exprand(100, 1000));
)
