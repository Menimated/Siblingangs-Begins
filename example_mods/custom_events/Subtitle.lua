function onCreatePost()
	makeLuaText('Lyrics', (value1), 1250, 0, 430)
	setTextAlignment('Lyrics', 'Center')
	addLuaText('Lyrics')
	setTextSize('Lyrics', 28)
	setTextFont('Lyrics', 'MochiyPopOne-Regular.ttf')
end
function onEvent(name, value1, value2)
	if name == 'Subtitle' then
		setProperty('Lyrics.alpha',1)
		setTextString('Lyrics', (value1));
		runTimer('begonelyric',1)
		if value2 == '' then
		    --do nothing lol
		else
		setTextColor('Lyrics', (value2))
		end
	end
end


--Comical Chaos made this event