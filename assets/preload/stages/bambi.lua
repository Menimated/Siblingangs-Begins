function onCreate()
	
	makeLuaSprite('disruptor', 'stages/bambi/skygreen', -3475, -1275);
	scaleObject('disruptor', 1.75, 1.75);
	addLuaSprite('disruptor', false)

	makeAnimatedLuaSprite('black', 'stages/bambi/blocks',-800,-700)
	addAnimationByPrefix('black', 'dance', 'blocks', 24, true);
	objectPlayAnimation('black', 'dance');
	addLuaSprite('black',false) 
	scaleObject('black', 2.0, 2.0);
	setScrollFactor('black', 0.5, 0.5);

end

function onStartCountdown()
	doTweenAngle('anglelele', 'disruptor', 54040, 205, 'linear');
end

function onBeatHit()
	objectPlayAnimation('black', 'dance', false);

end

function onUpdatePost()
	songPos = getSongPosition()
	currentBeat = (songPos/1000)*(bpm/60)
	setProperty("gf.scale.x",0.4)
	setProperty("gf.scale.y",0.4)
	setProperty("gf.y",150+math.sin(currentBeat*math.pi/16)*200)
	setProperty("gf.x",-1500+math.fmod(currentBeat*100,3200))
	setProperty("gf.angle",currentBeat*10)
end