eT = 0 --elapsed time
reach = {
  x = 6.6,
  y = 4.9
}
speed = {
  x = 2.7,
  y = 3.8
}
offset = {
  x = 0,
  y = 0
}

  function onUpdate(e)
    luaDebugMode = true
    eT = eT + e
    setProperty('dadGroup.x', getProperty 'dadGroup.x' + math.sin((eT * speed.x) + offset.x) * reach.x)
    setProperty('dadGroup.y', getProperty 'dadGroup.y' + math.cos((eT * speed.y) + offset.y) * reach.y)
    if not mustHitSection then
      runHaxeCode 'game.moveCameraSection();'
    end
  end


function onCreatePost()
	setProperty('introSoundsSuffix', 'Bambi')
end

function onUpdatePost(elapsed)
	noteCount = getProperty('notes.length');

	for i = 0, noteCount-1 do

		noteData = getPropertyFromGroup('notes', i, 'noteData')
		if getPropertyFromGroup('notes', i, 'isSustainNote') then
            if (getPropertyFromGroup('notes', i, 'mustPress')) then
                setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup("playerStrums", noteData, 'direction') - 90)
            else
				
                setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup("opponentStrums", noteData, 'direction') - 90)
            end	
		else
            if (noteData >= 4) then
                setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup("playerStrums", noteData, 'angle'))
            else
                setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup("opponentStrums", noteData, 'angle'))
            end	
		end
	end
end

function onUpdatePost(elapsed)
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets_3D')
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D');
			end
		end
	end
end