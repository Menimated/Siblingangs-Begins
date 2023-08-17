
function onStepHit()
	if (curStep > 1168 and curStep < 1440) then
	-- background shit
	makeLuaSprite('redBg', 'cheater', -600, -200);
	setLuaSpriteScrollFactor('redBg', 0.6, 0.6);
	scaleObject('redBg', 1, 1)
	addLuaSprite('redBg', false);



local shadname = "stridentCrisisWavy"

if (curStep > 1168 and curStep < 1440) then
		initLuaShader("stridentCrisisWavy")
		setSpriteShader('redBg', shadname)
	end
	
	function onUpdate(elapsed)
	setShaderFloat('redBg', 'uWaveAmplitude', 0.1)
	setShaderFloat('redBg', 'uFrequency', 5)
	setShaderFloat('redBg', 'uSpeed', 2.25)
		end

	function onUpdatePost(elapsed)
	setShaderFloat('redBg', 'uTime', os.clock())
	end
end
end