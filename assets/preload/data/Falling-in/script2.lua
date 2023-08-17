function onUpdate(elapsed)
	started = true
	songPos = getSongPosition()
	local currentBeat = (songPos/4000)*(curBpm/60)
	doTweenY('bfmove', 'boyfriend', 190 - 100*math.sin((currentBeat*0.75)*math.pi), 0.05)
	doTweenX('opponentmoves', 'dad', -250 + 250*math.sin((currentBeat+1)*math.pi), 4)
		doTweenY('opponentmove', 'dad', 150 + 200*math.sin((currentBeat+1)*math.pi), 4)
		doTweenAngle('opponentmovess', 'dad', 0 + 30*math.cos((currentBeat+1)*math.pi), 4)
end