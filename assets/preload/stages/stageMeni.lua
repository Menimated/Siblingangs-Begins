function onCreate()
	-- background shit
	makeLuaSprite('stageback2', 'stageback2', -605, -200);
	setLuaSpriteScrollFactor('stageback2', 0.9, 0.9);
	
	makeLuaSprite('stagefront2', 'stagefront2', -650, 600);
	setLuaSpriteScrollFactor('stagefront2', 1, 1);
	scaleObject('stagefront2', 1.1, 1.1);

	makeAnimatedLuaSprite('stagecrowd','stagecrowd',-470, 700);
	addAnimationByPrefix('stagecrowd','idle','stage trolls',25,true);
	scaleObject('stagecrowd', 0.8, 0.8);

	makeLuaSprite('stagestuff', 'stagestuff', -50, 380);
	setLuaSpriteScrollFactor('stagestuff', 1, 1);
	scaleObject('stagestuff', 1, 1);
    

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('stagelight_left', 'stage_light', -125, -100);
		setLuaSpriteScrollFactor('stagelight_left', 0.9, 0.9);
		scaleObject('stagelight_left', 1.1, 1.1);
		
		makeLuaSprite('stagelight_right', 'stage_light', 1225, -100);
		setLuaSpriteScrollFactor('stagelight_right', 0.9, 0.9);
		scaleObject('stagelight_right', 1.1, 1.1);
		setPropertyLuaSprite('stagelight_right', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('stagecurtains2', 'stagecurtains2', -500, -300);
		setLuaSpriteScrollFactor('stagecurtains2', 1.3, 1.3);
		scaleObject('stagecurtains2', 0.9, 0.9);
	end

	addLuaSprite('stageback2', false);
	addLuaSprite('stagefront2', false);
	addLuaSprite('stagestuff', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains2', false);
	addLuaSprite('stagecrowd', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end