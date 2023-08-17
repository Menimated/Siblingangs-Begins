function opponentNoteHit()
	health = getProperty('health')
	if difficulty == 2 then
		setProperty('health', health- 0.007);
	else
		setProperty('health', health- 0.005);
	end
end