local modchart = true

function onCreate()
	
	makeLuaSprite('back', 'blackscreen',-400,-200)
	addLuaSprite('back',false) 
	scaleObject('back', 3.5, 3.5);
	setScrollFactor('back', 0.1, 0.1);

end