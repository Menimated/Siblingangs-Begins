function onCreate()
    makeLuaSprite('blackScreen','',0,0)
    setObjectCamera('blackScreen','hud')
    makeGraphic('blackScreen',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreen',false)
end
function onStepHit()
    if curStep ==  288 then
        doTweenAlpha('byeBlack','blackScreen',0,0.2,'linear')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if (isSustainNote) then
        setProperty('health', getProperty('health') + 0.01)
    else
        setProperty('health', getProperty('health') + 0.02)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    cameraShake('camGame', 0.0025, 0.1);
    cameraShake('hud', 0.0025, 0.01);

    if (getProperty('health') > 0.4) then
        if (isSustainNote) then
            setProperty('health', getProperty('health') - 0.0375)
        else
            setProperty('health', getProperty('health') - 0.045)
        end
    end
end

function onBeatHit()
	if curBeat == 728 then
		makeLuaSprite('blackScreen','',0,0)
    setObjectCamera('blackScreen','hud')
    makeGraphic('blackScreen',screenWidth,screenHeight,'ffffff')
    addLuaSprite('blackScreen',false)
	end
end