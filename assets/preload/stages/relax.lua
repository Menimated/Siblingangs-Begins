function onCreate()
	
	makeLuaSprite('bg', 'stages/tv/relax',-450,-200)
	addLuaSprite('bg',false) 
	scaleObject('bg', 1.5, 1.5);


	addLuaSprite('sky', false);
	addLuaSprite('bwall', false);
	addLuaSprite('wall', false);
	addLuaSprite('ground', false);
	addLuaSprite('lights', false);

	makeLuaSprite('bartop','',0,-30)
    makeGraphic('bartop',1381,100,'000000')
    addLuaSprite('bartop',true)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0,650)
    makeGraphic('barbot',1381,100,'000000')
    addLuaSprite('barbot',false)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
	
	close(true);

end