function onCreate()
	makeLuaSprite('bg', 'stages/skyNight', -500, -780)
	addLuaSprite('bg', false)
	scaleObject('bg', 1.8, 1.8)
	setScrollFactor('bg', 0.5, 0.5)
	
	makeLuaSprite('hills', 'stages/farm/orangey hills', 100, 110)
	addLuaSprite('hills', false)
	scaleObject('hills', 1.2, 1.1)
	
	makeLuaSprite('farm', 'stages/farm/funfarmhouse', 400, 80)
	addLuaSprite('farm', false)
	setScrollFactor('farm', 0.8, 0.8)
	
	makeLuaSprite('farmlandbackground', 'stages/farm/grass lands', -320, 470)
	addLuaSprite('farmlandbackground', false)
	
	makeLuaSprite('fence1', 'stages/farm/cornFence', -150, 170)
	addLuaSprite('fence1', false)
	
	makeLuaSprite('fence2', 'stages/farm/cornFence2', 1400, 170)
	addLuaSprite('fence2', false)
	
	makeLuaSprite('sign', 'stages/farm/sign', 240, 320)
	addLuaSprite('sign', false)

	makeLuaSprite('farmlandnightoverlay','stages/nightoverlay',-200,-1600)
	addLuaSprite('farmlandnightoverlay',true)

	scaleObject('farmlandnightoverlay', 3, 3)
	
end
