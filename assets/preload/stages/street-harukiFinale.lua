
function onCreate()
	
	makeLuaSprite('bg', 'stages/street/redsky2', -1900,-1080);
	addLuaSprite('bg', false);
	scaleObject('bg', 3.8, 3.8);
	
    makeAnimatedLuaSprite('lol', 'stages/street/speed',-680,-5500)addAnimationByPrefix('lol','dance','idle',24,true)
	addAnimationByPrefix('lol', 'idle', 'tunnel', 24, true);
	objectPlayAnimation('lol', 'idle');
	scaleObject('lol', 1.8, 18.8);
	
	addLuaSprite('lol', false);


end

function onBeatHit()
	objectPlayAnimation('lol', 'idle', false);

end