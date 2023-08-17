function onCreate()
    makeLuaSprite('Ready','3ready',400,300)
    scaleObject('Ready',0.7,0.7)
    setObjectCamera('Ready','other')
    addLuaSprite('Ready',true)
    removeLuaSprite('Ready',false)


    makeLuaSprite('Set','2set',470,310)
    scaleObject('Set',0.7,0.7)
    setObjectCamera('Set','other')
    addLuaSprite('Set',true)
    removeLuaSprite('Set',false)

    makeLuaSprite('Go','1go',500,310)
    scaleObject('Go',0.7,0.7)
    setObjectCamera('Go','other')
    addLuaSprite('Go',true)
    removeLuaSprite('Go',false)
end

function onStepHit()
    if curStep == 2820 then
       addLuaSprite('Ready',true)
       setProperty('Ready.alpha',1)
    end
    if curStep == 2824 then
        addLuaSprite('Set',true)
        setProperty('Set.alpha',1)
    end
    if curStep == 2827 then
        addLuaSprite('Go',true)
        setProperty('Go.alpha',1)
    end
end
function onUpdate()
    setProperty('Ready.alpha',getProperty('Ready.alpha') - 0.05)
    setProperty('Set.alpha',getProperty('Set.alpha') - 0.05)
    setProperty('Go.alpha',getProperty('Go.alpha') - 0.05)
end
