function onBeatHit()
	if curBeat == 416 then
		setProperty('camGame.alpha', 0)
	end
	if curBeat == 432 then
		setProperty('camGame.alpha',1)
	end
	if curBeat == 722 then
		setProperty('camGame.alpha', 0)
	end
end

function opponentNoteHit()
	if curStep >= 1728 then
	triggerEvent('Screen Shake', '0.1, 0.01', '0.1, 0.005');
end
end