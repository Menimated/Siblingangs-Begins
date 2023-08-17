-- Dialogue shit
local playDialogue = false;
local playedVideo = false;
function onStartCountdown()
	if not playedVideo and isStoryMode and not seenCutscene then -- Block the first countdown and play video cutscene
		startVideo('TimeCard');
		playDialogue = true;
		playedVideo = true;
		return Function_Stop;
	elseif playDialogue then -- Block the second countdown and start a timer of 0.8 seconds to play the dialogue
		playedVideo = true;
		playDialogue = false;
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);

		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue');
	end
end

local allowEndShit = false

function onEndSong()
	if isStoryMode and not seenDaEnd then
		makeLuaSprite('bg','',0,0)
		makeGraphic('bg',1280,720,'000000')
		addLuaSprite('bg',true)
		setObjectCamera('bg','camHUD')

		setProperty('camGame.visible',false)
		setProperty('camHUD.visible',false)
		seenDaEnd = true
		startVideo('SGCutscenes4')
		return Function_Stop;
	else
		return Function_Continue;
	end
end