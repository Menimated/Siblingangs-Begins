function onCreate()

	makeLuaSprite('floor', 'nightmare/floor',-1050,250)
	scaleObject('floor', 2.7, 2.7); 

	setProperty('skipCountdown',true)

	makeAnimatedLuaSprite('MeniFire','nightmare/MeniFire',-2210,-550)addAnimationByPrefix('MeniFire','dance','funny fire',24,true)
    objectPlayAnimation('MeniFire','dance',false)
	scaleObject('MeniFire', 1.9, 1.9); 

	addLuaSprite('MeniFire', false);
	addLuaSprite('floor',false) 

end

function onBeatHit()
	objectPlayAnimation('MeniFire', 'idle', true);

end