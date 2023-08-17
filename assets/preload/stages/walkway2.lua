function onCreate()
	
	makeLuaSprite('theSky', 'stages/walkway/sun',-1087,-795)
	addLuaSprite('theSky',false) 
	scaleObject('theSky', 3, 3);
	
	makeLuaSprite('theGround', 'stages/walkway/walk',-1410,-600)
	addLuaSprite('theGround',false) 
	scaleObject('theGround', 2.5, 2.5);

	makeAnimatedLuaSprite('everyone', 'stages/walkway/crowd',-610,30)
	addAnimationByPrefix('everyone', 'idle', 'wow', 24, false);
	objectPlayAnimation('everyone', 'idle');
	addLuaSprite('everyone',false) 
	scaleObject('everyone', 3, 3);

end

function onBeatHit()
	objectPlayAnimation('everyone', 'idle', true);
end