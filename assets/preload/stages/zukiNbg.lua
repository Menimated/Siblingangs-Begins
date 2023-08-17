function onCreate()

	makeLuaSprite('floor', 'nightmare/floor',-1050,250)
	scaleObject('floor', 2.7, 2.7); 

	makeAnimatedLuaSprite('zukiFire','nightmare/zukiFire',-2210,-550)addAnimationByPrefix('zukiFire','dance','funny fire',24,true)
    objectPlayAnimation('zukiFire','dance',false)
	scaleObject('zukiFire', 1.9, 1.9); 

	addLuaSprite('zukiFire', false);
	addLuaSprite('floor',false) 

end

function onBeatHit()
	objectPlayAnimation('zukiFire', 'idle', true);

end