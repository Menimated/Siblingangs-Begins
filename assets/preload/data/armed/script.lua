function onCreate()
if songPath == 'armed' then
	runHaxeCode([[
		regi = new Character(150, 90, 'bambi');
		game.add(regi);
	]]);
end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Opponent 2 Sing' or noteType == 'Both Opponents Sing' then
        if songPath == 'reinforcements' then
	        runHaxeCode([[
	    	    ellie.playAnim(game.singAnimations[]]..direction..[[], true);
	    	    ellie.holdTimer = 0;
	        ]]);
        elseif songPath == 'armed' then
            runHaxeCode([[
                regi.playAnim(game.singAnimations[]]..direction..[[], true);
                regi.holdTimer = 0;
            ]])
        end
	end
end

function onBeatHit()
    if songPath == 'reinforcements' then
	    runHaxeCode([[
		    if (]]..curBeat..[[ % ellie.danceEveryNumBeats == 0 && ellie.animation.curAnim != null && !StringTools.startsWith(ellie.animation.curAnim.name, 'sing') && !ellie.stunned)
		    {
		    	ellie.dance();
		    }
	    ]]);
    elseif songPath == 'armed' then
        runHaxeCode([[
            if (]]..curBeat..[[ % regi.danceEveryNumBeats == 0 && regi.animation.curAnim != null && !StringTools.startsWith(regi.animation.curAnim.name, 'sing') && !regi.stunned)
		    {
		    	regi.dance();
		    }
        ]])
    end
end