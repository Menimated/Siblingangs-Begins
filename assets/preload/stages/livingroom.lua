local static = 1
function onCreate()
	
	makeLuaSprite('blackout', 'stages/livingroom/blackout',-900,-50)
	scaleObject('blackout', 199, 199);
	
	makeLuaSprite('a', 'stages/livingroom/sofa',-1050,-50)
	scaleObject('a', 1.2, 1.2);
	
	makeLuaSprite('ae', 'stages/livingroom/light',100,350)
	scaleObject('ae', 1.2, 1.2);
	
	makeLuaSprite('prop', 'stages/livingroom/table',500,700)
	scaleObject('prop', 1.2, 1.2);

	addLuaSprite('blackout',false) 
	addLuaSprite('a',false) 
	addLuaSprite('ae',false) 
	addLuaSprite('prop',true) 
	close(true);

end