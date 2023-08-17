local static = 1
function onCreate()
	
	
	makeLuaSprite('a', 'stages/livingroom/sofan',-910,-10)
	scaleObject('a', 1.2, 1.2);
	
	makeLuaSprite('ae', 'stages/livingroom/light',60,390)
	scaleObject('ae', 1.3, 1.3);
	

	addLuaSprite('a',false) 
	addLuaSprite('ae',false) 
	close(true);

	makeAnimatedLuaSprite('lol3', 'stages/livingroom/hinata_scared',-200,350)
	addAnimationByPrefix('lol3', 'idle', 'hinata scared', 24, true);
	objectPlayAnimation('lol3', 'idle');

	addLuaSprite('lol3', false);

	makeLuaSprite('eff2','metalred2', 0, 0)
	setGraphicSize('eff2',1280,720)
	setObjectCamera('eff2','camHud')
	updateHitbox('eff2')
	setBlendMode('eff2','multiply')
	addLuaSprite('eff2', false);
	
	makeLuaSprite('eff','metalred', 0, 0)
	setGraphicSize('eff',1280,720)
	setObjectCamera('eff','camHud')
	updateHitbox('eff')
	setBlendMode('eff','multiply')
	addLuaSprite('eff', false);
	
end

function onUpdatePost()

	if flashingLights then
		setProperty('eff.alpha',getProperty('health')/1.5)
	end
	if flashingLights then
		setProperty('eff2.alpha',getProperty('health')/1.5)
	end

end

function onBeatHit()


	objectPlayAnimation('lol3', 'idle', true);

end