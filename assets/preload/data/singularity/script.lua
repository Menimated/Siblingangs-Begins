function onCreate()

	makeLuaSprite('bartop','',0,-30)
    makeGraphic('bartop',1381,100,'000000')
    addLuaSprite('bartop',false)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0,650)
    makeGraphic('barbot',1381,100,'000000')
    addLuaSprite('barbot',false)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
	
	close(true);

end

function onStepHit()
	if curStep == 527 then
		setProperty('cameraSpeed', 7)
    end
    if curStep == 544 then
		setProperty('cameraSpeed', 1)
    end
    if curStep == 800 then
		setProperty('cameraSpeed', 3)
    end
    if curStep == 923 then
		setProperty('cameraSpeed', 9)
    end
    if curStep == 1056 then
		setProperty('cameraSpeed', 1)
	end
end