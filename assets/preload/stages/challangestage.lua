function onCreate()
	
	makeLuaSprite('theSky', 'stages/challangestage/blackbackground',-1100,-1000)
	addLuaSprite('theSky',false) 

	makeAnimatedLuaSprite('crowd', 'stages/challangestage/crowd',-580,-200)addAnimationByPrefix('crowd','dance','idle',24,true)
	addAnimationByPrefix('crowd', 'idle', 'everyone', 24, false);
	objectPlayAnimation('crowd', 'idle');
	addLuaSprite('crowd', false);
	scaleObject('crowd', 1.9, 1.9); 
	
	makeLuaSprite('theGround', 'stages/challangestage/floor',-580,-200)
	addLuaSprite('theGround',false) 
	scaleObject('theGround', 2, 2); 
	
	makeLuaSprite('theGround2', 'stages/challangestage/dark',-1100,-300)
	addLuaSprite('theGround2',true) 

	makeLuaSprite('light2', 'stages/challangestage/light',-580,-200)
	addLuaSprite('light2',true) 
	scaleObject('light2', 1.3, 1.3); 

	makeLuaSprite('light', 'stages/challangestage/lightback',-1100,-1000)
	addLuaSprite('light',true) 

end

function onBeatHit()
	objectPlayAnimation('crowd', 'idle', true);

	objectPlayAnimation('GF_assets', 'idle', true);
end