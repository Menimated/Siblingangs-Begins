function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet_Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Bullet_Note'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let BF's notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

local shootAnims = {"shoot", "shoot", "shoot", "shoot"}
local dodgeAnims = {"dodgeLEFT", "dodgeDOWN", "dodgeUP", "dodgeRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet_Note' then
		if getProperty('dad.curCharacter') == 'haruki gun' then
			characterPlayAnim('dad', shootAnims[direction + 1], true);
		elseif getProperty('dad.curCharacter') == 'hank-scared' then
			curDad = getProperty('dad.curCharacter');
			setProperty('dad.curCharacter', 'haruki gun');
			characterPlayAnim('dad', shootAnims[direction + 1], true);
			runTimer('shootanim', 1, 1);
		end
		setProperty('dad.specialAnim', true);
		if getProperty('bf.curCharacter') == 'bf-accelerant' then
			characterPlayAnim('boyfriend', dodgeAnims[direction + 1], true);
		else
			characterPlayAnim('boyfriend', 'dodge', true);
		end
		setProperty('boyfriend.specialAnim', true);
		cameraShake('camGame', 0.01, 0.2);
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet_Note' and difficulty == 1 then
		setProperty('health', -1);
	elseif noteType == 'Bullet_Note' and difficulty == 0 then
		setProperty('health', getProperty('health')-0.8);
		runTimer('bleed', 0.2, 20);
		characterPlayAnim('boyfriend', 'hurt', true);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'bleed' then
		setProperty('health', getProperty('health')-0.001);
	end
	if tag == 'shootanim' then
		setProperty('dad.curCharacter', curDad);
	end
end