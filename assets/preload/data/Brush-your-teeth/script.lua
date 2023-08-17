local modchart = true

function onCreatePost()
	bunzoNum = getProperty('dad.y')
	heightLimit = getProperty('dad.y') + 1700
	bfY = getProperty('boyfriend.y') - 1700
	-- INVISIBRUU
	setProperty('healthBar.visible', false)
	setProperty('healthBarBG.visible', false)
	setProperty('iconP2.visible', false)
	setProperty('iconP1.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)


	if modchart == true then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			setPropertyFromGroup('opponentStrums',i,'visible',false)
		setPropertyFromGroup('opponentStrums',i,'y',130)
		setPropertyFromGroup('opponentStrums',i,'x',-9999)
		end
	end
end