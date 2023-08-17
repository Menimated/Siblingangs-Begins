function onCreate()
	makeLuaSprite('bg', 'stages/dandas/wall', -410, -140)
	addLuaSprite('bg', false)
	scaleObject('bg', 1.4, 0.999999999999998)
	setScrollFactor('bg', 1.6, 1)
	
end

function onCreatePost()
    setProperty('boyfriend.visible',false)
end