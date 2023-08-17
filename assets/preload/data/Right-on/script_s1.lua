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
		triggerEvent('dialogue.setSkin', 'default', '');
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		removeLuaSprite('blackbg', true);
		removeLuaSprite('blackbg2', true);
		seenCutscene = true;
	end
	return Function_Continue;
end

local music = 'cutscene2';

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		triggerEvent('startDialogue', 'w1a1d1', '');
		playMusic(music, 0, true);
		soundFadeIn('', 2, 0, 1);
	end
end

function onEvent(name, value1, value2)
	if (name == 'dialogue.step' and value1 == 'w1a1d1' and value2 == '8') then
		setProperty('blackbg2.visible', true);
	elseif (name == 'dialogue.step' and value1 == 'w1a1d2' and value2 == '3') then
		setProperty('blackbg2.visible', false);
	elseif (name == 'dialogue.skipped' and isAny(value1, 'w1a1d1', 'w1a1d2', 'w1a1d3')) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 0.9);
		fase = 4;
	elseif (name == 'dialogue.ended' and value1 == 'w1a1d3') then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 0.9);
	end
end