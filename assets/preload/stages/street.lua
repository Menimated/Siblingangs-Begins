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

end