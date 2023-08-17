if curStep == 1 then
    addLuaSprite('Black1',true)
    addLuaSprite('Black2',true)
    doTweenY('Black1FadeIn','Black1',0,2,'QuartOut')
    doTweenY('Black2FadeIn','Black2',0,2,'QuartOut')
    for i = 0,7 do
      if not downscroll then
        noteTweenY('coolMoviment'..i, i, 120, 2, 'QuartOut')
       else
         noteTweenY('coolMoviment'..i, i, 490, 2, 'QuartOut')
       end
    triggerEvent('Set Cam Zoom',1.1,2)
    end
  end

  if curStep == 100 then
    doTweenY('Black1FadeOut','Black1',-150,2,'QuartOut')
    doTweenY('Black2FadeOut','Black2',150,2,'QuartOut')
    for i = 0,7 do
      triggerEvent('Set Cam Zoom',0.9,2)
      if not downscroll then
       noteTweenY('coolMoviment'..i, i, 50, 2, 'QuartOut')
      else
        noteTweenY('coolMoviment'..i, i, screenHeight - 150, 2, 'QuartOut')
      end
    end
  end