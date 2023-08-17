function onCreate()
	
	makeAnimatedLuaSprite('black', 'stages/expunged/red',-400,-200)
	addAnimationByPrefix('black', 'dance', 'Void', 24, true);
	objectPlayAnimation('black', 'dance');
	addLuaSprite('black',false) 
	scaleObject('black', 1.5, 1.5);
	setScrollFactor('black', 0.1, 0.1);
	

end

function onBeatHit()
	objectPlayAnimation('black', 'dance', false);

end