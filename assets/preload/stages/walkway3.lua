function onCreate()
	
	makeLuaSprite('theSky', 'stages/walkway/night',-1087,-795)
	addLuaSprite('theSky',false) 
	scaleObject('theSky', 3, 3);
	
	makeLuaSprite('theGround', 'stages/walkway/walkNight',-1410,-600)
	addLuaSprite('theGround',false) 
	scaleObject('theGround', 2.5, 2.5);

	makeAnimatedLuaSprite('everyone', 'stages/walkway/crowdNight',-610,30)
	addAnimationByPrefix('everyone', 'idle', 'wow', 24, false);
	objectPlayAnimation('everyone', 'idle');
	addLuaSprite('everyone',false) 
	scaleObject('everyone', 3, 3);

	makeAnimatedLuaSprite('lol', 'stages/walkway/funny-gf',280, 50)
	addAnimationByPrefix('lol', 'idle', 'GF Dancing Beat', 42, true);
	objectPlayAnimation('lol', 'idle');
	addLuaSprite('lol', false);


end

function onBeatHit()
	objectPlayAnimation('lol', 'idle', false);
	
	objectPlayAnimation('everyone', 'idle', true);

end