local static = 1
function onCreate()
	
	
	makeLuaSprite('a', 'stages/livingroom/sofan',-910,-10)
	scaleObject('a', 1.2, 1.2);
	
	makeLuaSprite('ae', 'stages/livingroom/light',60,390)
	scaleObject('ae', 1.3, 1.3);

	makeLuaSprite('ae222', 'stages/livingroom/sofaa',290,400)
	scaleObject('ae222', 1.2, 1.2);
	
	makeLuaSprite('prop', 'stages/livingroom/table',500,700)
	scaleObject('prop', 1.2, 1.2);

	makeAnimatedLuaSprite('lol2', 'stages/livingroom/fire',-590,-590)
	addAnimationByPrefix('lol2', 'idle', 'FIREE', 24, true);
	objectPlayAnimation('lol2', 'idle');
	scaleObject('lol2', 5, 5);

	addLuaSprite('a',false) 
	addLuaSprite('ae',false) 
	addLuaSprite('ae222',false) 
	addLuaSprite('lol2', false);
	close(true);
    
	
	addLuaSprite('prop',false) 
	addLuaSprite('lol3', false);

	makeLuaSprite('eff','metalred2', 0, 0)
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

end