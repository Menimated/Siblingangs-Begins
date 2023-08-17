local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0
local xx = 870;
local yy = 500;
local xx2 = 870;
local yy2 = 500;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdate()
	setProperty('gf.alpha', 0);
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    if curBeat == 16 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 32 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 48 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;

    end
    if curBeat == 68 then
        setProperty('defaultCamZoom',0.5)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 100 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 116 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 132 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 148 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 164 then
        setProperty('defaultCamZoom',0.5)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 180 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 194 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
    end
    if curBeat == 196 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 212 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 228 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 244 then
        setProperty('defaultCamZoom',0.85)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 260 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 292 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 308 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 324 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 340 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 356 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 360 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 376 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 392 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;
        
    end
    if curBeat == 408 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 424 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 670;
        yy = 500;
        xx2 = 670;
        yy2 = 500;

    end
    if curBeat == 440 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1070;
        yy = 500;
        xx2 = 1070;
        yy2 = 500;
    end
    if curBeat == 456 then
        setProperty('defaultCamZoom',0.8)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 472 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    if curBeat == 488 then
        setProperty('defaultCamZoom',0.5)
		followchars = true
        xx = 870;
        yy = 500;
        xx2 = 870;
        yy2 = 500;

    end
    
end
