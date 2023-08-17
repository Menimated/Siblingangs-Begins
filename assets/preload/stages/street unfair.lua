function onCreate()
	makeLuaSprite('bg', 'stages/street/redsky2', -500,-780);
	addLuaSprite('bg', false);
	scaleObject('bg', 1.8, 1.8);
	setScrollFactor('bg', 0.5, 0.5);

	makeLuaSprite('ae', 'stages/street/house',-700,100)
	addLuaSprite('ae',false) 
	scaleObject('ae', 1.9, 1.9);
	setScrollFactor('ae', 0.6, 0.6);

	makeAnimatedLuaSprite('lol2', 'stages/street/fire',-590,-790)
	addAnimationByPrefix('lol2', 'idle', 'FIREE', 24, true);
	objectPlayAnimation('lol2', 'idle');
	addLuaSprite('lol2', false);
	scaleObject('lol2', 5, 5);
	
	makeLuaSprite('touchgrass', 'stages/street/grassRED',-700,450)
	addLuaSprite('touchgrass',false) 
	scaleObject('touchgrass', 1.5, 1.5);
	
	makeLuaSprite('floor', 'stages/street/road',-700,380)
	addLuaSprite('floor',false) 
	scaleObject('floor', 1.5, 1.9);

	makeAnimatedLuaSprite('lol3', 'stages/street/scared',-180,190)
	addAnimationByPrefix('lol3', 'idle', 'hinata scared', 24, true);
	objectPlayAnimation('lol3', 'idle');
	addLuaSprite('lol3', false);

end

function onBeatHit()


	objectPlayAnimation('lol3', 'idle', true);

end