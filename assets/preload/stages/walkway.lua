function onCreate()
	
	makeLuaSprite('theSky', 'stages/walkway/day',-1087,-795)
	addLuaSprite('theSky',false) 
	scaleObject('theSky', 3, 3);
	
	makeLuaSprite('theGround', 'stages/walkway/walk',-1410,-600)
	addLuaSprite('theGround',false) 
	scaleObject('theGround', 2.5, 2.5);

end