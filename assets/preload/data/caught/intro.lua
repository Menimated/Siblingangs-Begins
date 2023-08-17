local allowCountdown = false;
function onStartCountdown()
    if not allowCountdown and not seenCutscene then
        startVideo('caught');
        allowCountdown = false;
        return Function_Stop;
    end
    return Function_Continue;
end