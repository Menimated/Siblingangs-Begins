function onCreate()
	
	makeLuaSprite('theSky', 'stages/newchallangestage/stageee',-650,-200)
	addLuaSprite('theSky',false) 
	scaleObject('theSky', 1.1, 1.1); 

	makeAnimatedLuaSprite('everyone', 'stages/newchallangestage/everyone',-400,570)addAnimationByPrefix('everyone', 'dance','idle',24,true)
	addAnimationByPrefix('everyone', 'idle', 'yay', 24, false);
	objectPlayAnimation('everyone', 'idle');
	addLuaSprite('everyone', true);
	scaleObject('everyone', 1.5, 1.5); 
	
	makeLuaSprite('theGround2', 'stages/newchallangestage/dark',-650,-200)
	addLuaSprite('theGround2',true) 


end

function onBeatHit()
	objectPlayAnimation('everyone', 'idle', true);

end