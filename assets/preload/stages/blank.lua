local modchart = true

function onCreate()
	
	makeLuaSprite('back', 'stages/blank/white',250,150)
	addLuaSprite('back',false) 

end

	function onStartCountdown()
		setProperty('gf.alpha', 0)
		setProperty('dad.alpha', 0)
		setProperty('iconP2.alpha', 0)
end
	
function onCreatePost()
	setProperty('healthBar.visible', false)
	setProperty('healthBarBG.visible', false)
	setProperty('iconP2.visible', false)
	setProperty('iconP1.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
	originy = getProperty('boyfriend.y')

	setProperty('gf.visible',false)
	
	if modchart == true then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			setPropertyFromGroup('opponentStrums',i,'visible',false)
		setPropertyFromGroup('opponentStrums',i,'y',130)
		setPropertyFromGroup('opponentStrums',i,'x',-9999)
		end
	end
end