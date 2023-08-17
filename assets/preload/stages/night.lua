function onCreate()
	makeLuaSprite('bg', 'stages/night/ocean', 359,360);
	addLuaSprite('bg', false);
	scaleObject('bg', 1.7, 1.7);

    makeLuaSprite('floor', 'stages/night/floor', 43,342);
	addLuaSprite('floor', false);
	scaleObject('floor', 1.6, 1.6);

	makeLuaSprite('a', 'stages/night/dark', 621,326);
	addLuaSprite('a', true);
	scaleObject('a', 1.6, 1.6);

end