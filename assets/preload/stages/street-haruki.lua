function onCreate()
	makeLuaSprite('bg', 'stages/street/sky', -500,-780);
	addLuaSprite('bg', false);
	scaleObject('bg', 1.8, 1.8);
	setScrollFactor('bg', 0.5, 0.5);

	makeLuaSprite('ae', 'stages/street/house',-700,100)
	addLuaSprite('ae',false) 
	scaleObject('ae', 1.9, 1.9);
	setScrollFactor('ae', 0.6, 0.6);
	
	makeLuaSprite('touchgrass', 'stages/street/grass',-700,450)
	addLuaSprite('touchgrass',false) 
	scaleObject('touchgrass', 1.5, 1.5);
	
	makeLuaSprite('floor', 'stages/street/road',-700,380)
	addLuaSprite('floor',false) 
	scaleObject('floor', 1.5, 1.9);

	makeAnimatedLuaSprite('lol', 'stages/street/funny-gf',280,100)addAnimationByPrefix('lol','dance','idle',24,true)
	addAnimationByPrefix('lol', 'idle', 'GF Dancing Beat', 35, true);
	objectPlayAnimation('lol', 'idle');
	addLuaSprite('lol', false);

	makeAnimatedLuaSprite('lol2', 'stages/street/meh',-180,190)
	addAnimationByPrefix('lol2', 'idle', 'hinata idle', 24, true);
	objectPlayAnimation('lol2', 'idle');
	addLuaSprite('lol2', false);


end

function onBeatHit()
	objectPlayAnimation('lol', 'idle', false);

	objectPlayAnimation('lol2', 'idle', true);

end