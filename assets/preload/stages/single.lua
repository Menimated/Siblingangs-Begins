function onCreate()
	
	makeAnimatedLuaSprite('black', 'stages/noescape/black',-400,-600)
	addAnimationByPrefix('black', 'dance', 'glitch', 24, true);
	objectPlayAnimation('black', 'dance');
	addLuaSprite('black',false) 
	scaleObject('black', 2, 2);
	

end

function onBeatHit()
	objectPlayAnimation('black', 'dance', true);

end