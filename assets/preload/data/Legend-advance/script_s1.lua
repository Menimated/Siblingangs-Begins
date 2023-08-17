local fase = 0

function onCreatePost()
	makeLuaSprite('blackbg', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg', 1300, 740, '000000');
	scaleObject('blackbg', 1, 1);
	--setProperty('blackbg.alpha', 0);
	addLuaSprite('blackbg', false);
	setObjectCamera('blackbg', 'other');
	
	if (seenCutscene) then
		setProperty('blackbg.visible', false);
	end
end

function onStartCountdown()
	return onFaseChange();
end

function onEndSong()
	return onFaseChange();
end

function onFaseChange()
	fase = fase + 1;
	if ((fase == 1 and seenCutscene)) then
		fase = 5;
	end
	if (fase == 1) then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		return Function_Continue;
	elseif (fase == 3) then
		if (fase == 1) then
			return Function_Continue;
		end
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'default', '');
		triggerEvent('startDialogue', 'w1a1d2', '');
		return Function_Stop;
	elseif (fase == 4) then
		--removeLuaSprite('blackbg', true);
		seenCutscene = true;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		triggerEvent('dialogue.setSkin', 'default', '');
		triggerEvent('startDialogue', 'w1a1d1', '');
		playMusic('nothing', 0, true);
		soundFadeIn('', 2, 0, 1);
	end
end

function onEvent(name, value1, value2)
	if (isAny(name, 'dialogue.skipped', 'dialogue.ended') and value1 == 'w1a1d1') then
		setProperty('blackbg.visible', false);
		soundFadeOut('', 0.9);
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '6') then
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '14') then
	elseif (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '15') then
	elseif (name == 'dialogue.step' and value1 == 'w1a1d2' and value2 == '1') then
		setProperty('blackbg.visible', true);
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