local fase = 0

function onCreatePost()
	makeLuaSprite('blackbg', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg', 1300, 740, '000000');
	scaleObject('blackbg', 1, 1);
	--setProperty('blackbg.alpha', 0);
	addLuaSprite('blackbg', false);
	setObjectCamera('blackbg', 'other');
	
	if ((not isStoryMode) or seenCutscene) then
		setProperty('blackbg.visible', false);
	end
end

function onStartCountdown()
	fase = fase + 1;
	if ((not isStoryMode) or (fase == 1 and seenCutscene)) then
		fase = 4;
	end
	if (fase == 1) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'part2', '');
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		removeLuaSprite('blackbg', true);
		removeLuaSprite('blackbg2', true);
		seenCutscene = true;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		triggerEvent('startDialogue', 'w1a1d1', '');
		playMusic('harukicutscene', 0, true);
		soundFadeIn('', 0.2, 0, 0.5);
	end
end

function onEvent(name, value1, value2)
	if (isAny(name, 'dialogue.skipped', 'dialogue.ended') and value1 == 'w1a1d1') then
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '14') then
		playMusic('nothing', 0, true);
		soundFadeIn('', 2);
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '15') then
		playMusic('baby', 3, true);
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '17') then
		playMusic('himari', 0.5, true);
	end
end

function isAny(val, ...)
	local args = { ... };
	for _, target in ipairs(args) do
		if (val == target) then
			return true;
		end
	end
	return false;
end