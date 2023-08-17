-- Created by RamenDominoes (Feel free to credit or not I don't really care)
--Not bad for my first event created... I think

hudStuff = {'healthBarBG', 'healthBar', 'scoreTxt', 'iconP1', 'iconP2', 'timeBar',  'timeBarBG', 'timeTxt'}

function onCreate()
	
	if getPropertyFromClass('flixel.FlxG', 'save.data.psychUI') == false then -- kade ui
		hudStuff = {'healthBarBG', 'healthBar', 'scoreTxt', 'iconP1', 'iconP2'}
	end

	--THE TOP BAR
	makeLuaSprite('UpperBar', '', 0, -200)
	makeGraphic('UpperBar', 1500, 200, '000000')
	setObjectCamera('UpperBar', 'hud')
	addLuaSprite('UpperBar', false)

	--THE BOTTOM BAR
	makeLuaSprite('LowerBar', '', 0, 730)
	makeGraphic('LowerBar', 1500, 200, '000000')
	setObjectCamera('LowerBar', 'hud')
	addLuaSprite('LowerBar', false)
end

function onEvent(name,value1,value2)
	if name == 'Cinematics' then
		local start = tonumber(value1)

		if start == 1 then
			doTweenY('Cinematics1', 'UpperBar', -100, 0.2, 'Linear')
			doTweenY('Cinematics2', 'LowerBar', 630, 0.2, 'Linear')
			for i = 1, #hudStuff do
				doTweenAlpha('AlphaTween'..i, hudStuff[i], 0, 0.25)
			end
		end

		if start == 2 then
			doTweenY('Cinematics1', 'UpperBar', -200, 0.5, 'Linear')
			doTweenY('Cinematics2', 'LowerBar', 730, 0.5, 'Linear')
			for i = 1, #hudStuff do
				doTweenAlpha('AlphaTween'..i, hudStuff[i], 1, 0.25)
			end
		end
	end
end
