function onCreate()
	makeLuaSprite('cloud', 'stages/dave/sky', -666.1, -767.1)
	addLuaSprite('cloud', false)
	scaleObject('cloud', 2.2, 1.9)
	setScrollFactor('cloud', 0.3, 0.3);
	
	makeLuaSprite('cloud2', 'stages/dave/hills', -589, 116.7)
	addLuaSprite('cloud2', false)
	scaleObject('cloud2', 2, 1.4)
	setScrollFactor('cloud2', 0.2, 0.2);
	
	makeLuaSprite('gatee', 'stages/dave/grassbg', -954, 412)
	addLuaSprite('gatee', false)
	scaleObject('gatee', 3.5, 3.3)
	
	makeLuaSprite('gate', 'stages/dave/gate', -714, 226.35)
	addLuaSprite('gate', false)
	scaleObject('gate', 2, 1.4)
	
	makeLuaSprite('gate2', 'stages/dave/grass', -512.95, 597.75)
	addLuaSprite('gate2', false)
	scaleObject('gate2', 1.8, 1.7)
	
end
