local static = 1
function onCreate()
	
	makeLuaSprite('bg', 'stages/street/sky', -500,-780);
	addLuaSprite('bg', false);
	scaleObject('bg', 1.8, 1.8);
	setScrollFactor('bg', 0.5, 0.5);

	makeLuaSprite('a', 'stages/livingroom/sofan',-710,90)
	scaleObject('a', 1.0, 1.0);
	
	makeLuaSprite('ae', 'stages/livingroom/light',60,390)
	scaleObject('ae', 1.3, 1.3);
	

	addLuaSprite('a',false) 
	addLuaSprite('ae',false) 
	close(true);


end