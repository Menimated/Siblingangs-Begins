function onCreate()
	
	makeLuaSprite('ae', 'stages/highschool/hallBlood', -1775, -249)
	addLuaSprite('ae', false)
	scaleObject('ae', 1.3, 1.4)
	

makeLuaSprite('eff2','dark', 0, 0)
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

