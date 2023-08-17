function onCreate()
	
	makeLuaSprite('theSky', 'stages/corrupted/stageee2',-650,-200)
	addLuaSprite('theSky',false) 
	scaleObject('theSky', 1.1, 1.1); 

	makeAnimatedLuaSprite('gf', 'stages/corrupted/gf',280,50)addAnimationByPrefix('gf', 'dance','idle',24,true)
	addAnimationByPrefix('gf', 'idle', 'OhNo', 24, false);
	objectPlayAnimation('gf', 'idle');
	addLuaSprite('gf', false);

	makeLuaSprite('theGround2', 'stages/corrupted/dark2',-650,-200)
	addLuaSprite('theGround2',true) 


end

function onBeatHit()
	objectPlayAnimation('gf', 'idle', true);

end