function onCreate()

	makeLuaSprite('floor', 'nightmare/floor',-1050,250)
	scaleObject('floor', 2.7, 2.7); 

	makeAnimatedLuaSprite('KazashiFire','nightmare/KazashiFire',-2210,-550)addAnimationByPrefix('KazashiFire','dance','funny fire',24,true)
    objectPlayAnimation('KazashiFire','dance',false)
	scaleObject('KazashiFire', 1.9, 1.9); 

	addLuaSprite('KazashiFire', false);
	addLuaSprite('floor',false) 

end

function onBeatHit()
	objectPlayAnimation('KazashiFire', 'idle', true);

end