function onCreate()
    makeLuaSprite('blackScreen','',0,0)
    setObjectCamera('blackScreen','hud')
    makeGraphic('blackScreen',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreen',false)
end
function onStepHit()
    if curStep ==  15 then
        doTweenAlpha('byeBlack','blackScreen',0,0.2,'linear')
    end
end