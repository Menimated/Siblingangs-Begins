function onCreate()
	
	makeLuaSprite('bg', 'stages/gameroom/background',-400,-600)
	addLuaSprite('bg',false) 
	setScrollFactor('bg', 0.9, 0.9);
	scaleObject('bg', 2, 2);

	makeLuaSprite('ae', 'stages/gameroom/computer',-500,100)
	addLuaSprite('ae',false) 
	setScrollFactor('ae', 0.8, 0.8);
	scaleObject('ae', 1.9, 1.9);

	makeLuaSprite('ae2', 'stages/gameroom/chair',-50,250)
	addLuaSprite('ae2',false) 
	setScrollFactor('ae2', 0.8, 0.8);
	scaleObject('ae2', 1.7, 1.7);
	

end