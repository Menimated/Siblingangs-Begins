function onEvent(name)
	if name == 'Electric' then
		makeAnimatedLuaSprite('vs', 'shock', 550, 110);
		luaSpriteAddAnimationByPrefix('vs', 'hello_there', 'electric' , 24, false)
	    objectPlayAnimation('vs', 'electric');
		scaleLuaSprite('vs', 1.5, 1.5)
		addLuaSprite('vs', true)
		runTimer('fade', 13.63);
		playSound('elec', 1)
	end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'fade' then
		doTweenAlpha('remove', 'vs', 0, 0.3, 'linear');
    end
end

function onBeatHit()
	objectPlayAnimation('vs', 'electric', false);

end