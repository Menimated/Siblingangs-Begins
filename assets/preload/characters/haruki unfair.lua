function opponentNoteHit()
	triggerEvent('Screen Shake', '0.2, 0.02', '0.2, 0.006');
	health = getProperty('health')
	if difficulty == 2 then
		setProperty('health', health- 0.007);
	else
		setProperty('health', health- 0.005);
	end
end

function onUpdate(elapsed)
	started = true
	songPos = getSongPosition()
	local currentBeat = (songPos/4000)*(curBpm/60)
	doTweenY('opponentmove', 'dad', 190 - 100*math.sin((currentBeat*0.75)*math.pi), 0.05)
end