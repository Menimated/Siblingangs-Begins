function onCreate()
	
	makeLuaSprite('blackout', 'stages/livingroom/blackout',-100,-50)
	addLuaSprite('blackout',true) 
	scaleObject('blackout', 5.2, 5.2);
	
	makeLuaSprite('a', 'stages/livingroom/sofa',-1050,-50)
	addLuaSprite('a',false) 
	scaleObject('a', 1.2, 1.2);
	
	makeLuaSprite('ae', 'stages/livingroom/light',100,350)
	addLuaSprite('ae',false) 
	scaleObject('ae', 1.2, 1.2);
	
	makeLuaSprite('prop', 'stages/livingroom/table',500,700)
	addLuaSprite('prop',true) 
	scaleObject('prop', 1.2, 1.2);

end