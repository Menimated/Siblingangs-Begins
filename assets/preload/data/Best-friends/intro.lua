local allowCountdown = false;
function onStartCountdown()
    if not allowCountdown and not seenCutscene then
        setProperty('inCutscene', true);
        runTimer('best friend', 0.5)
        runTimer('shutup', 0.5)
        runTimer('stat', 0.1);
        setProperty('gf.visible', false);
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end


function onTimerCompleted(tag)
    if tag == 'best friend' then
        characterPlayAnim('dad', 'best friend', true)
        setProperty('dad.specialAnim', true)
        runTimer('hey', 10);
        playSound('bambibestfriend', 0.7)
     end
    if tag == 'hey' then
        runTimer('start', 2);
    end
    if tag == 'start' then
        --setProperty('camHUD.visible', true);
        startDialogue('dialogue');
    end

    if tag == 'shutup' then
        characterPlayAnim('bf', 'shutup', true)
        setProperty('bf.specialAnim', true)
        runTimer('hey2', 10);
     end
    if tag == 'start' then
        --setProperty('camHUD.visible', true);
        startDialogue('dialogue');
    end
end
