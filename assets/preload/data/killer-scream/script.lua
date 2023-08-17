function onCreate()
	-- triggered when the lua file is started, some variables weren't created yet
    makeLuaSprite('Black', '');
	makeGraphic('Black', 2000, 2000, '000000')
	setObjectCamera('Black', 'other');
	addLuaSprite('Black', true);
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
    runTimer('blackalpha',1)

end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'blackalpha' then
		doTweenAlpha('Alpha', 'Black', 0, 4.8, 'linear');
	end

end
