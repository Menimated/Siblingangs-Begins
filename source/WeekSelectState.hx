package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import editors.MasterEditorMenu;
import Achievements;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxSave;

using StringTools;

class WeekSelectState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	public static var firstStart:Bool = true;
	
	var optionShit:Array<String> = [
		'week1',
		'weeklocked',
		'weeklocked',
		'weeklocked',
		'weeklocked'
	];

	var menuDescs:Array<String> = [
		"Kazashi's Best life",
		'???',
		'???',
		"???",
		'???'
	];

	var selectedText:FlxText;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	//var chess:FlxSprite;
	var chess:FlxBackdrop;
	var backdrop:FlxBackdrop;
	var discord:FlxBackdrop;
	var save:FlxSave = new FlxSave();
	var menuGameDesc:FlxText;

	var logoBl:FlxSprite;

	public static var finishedFunnyMove:Bool = false;
	
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Game select menu", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		WeekData.loadTheFirstEnabledMod();
        FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

        if (!FlxG.sound.music.playing)
		{	
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
        	FlxG.sound.music.time = 0;
			Conductor.changeBPM(102);
		}

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('kazashiBg'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		
		backdrop = new FlxBackdrop(Paths.image('yeyu'));
		backdrop.velocity.set( -50);
		backdrop.antialiasing = ClientPrefs.globalAntialiasing;
		add(backdrop);
		
		
		chess = new FlxBackdrop(Paths.image('yay'), 0, 0, true, false);
		chess.scrollFactor.set(0, 0);
		chess.y -= 150;
		add(chess);
		
		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;

	

		
		

		
		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);

		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		/* if(StoryMenuState.weekCompleted.get('week1')){
			optionShit.insert(1,"week2");
			optionShit.remove("weeklocked");
		}

		if(StoryMenuState.weekCompleted.get('week2')){
			optionShit.insert(2,"week3");
			optionShit.remove("weeklocked");
		}

		if(StoryMenuState.weekCompleted.get('week3')){
			optionShit.insert(3,"week4");
			optionShit.remove("weeklocked");
		}

		if(StoryMenuState.weekCompleted.get('week4')){
			optionShit.insert(4,"week5");
			optionShit.remove("weeklocked");
		} */

		if(Highscore.getScore('Prick', 2) != 0){
			ClientPrefs.week1 = true;
			ClientPrefs.saveSettings();
		}
		if(ClientPrefs.week1){
			optionShit.insert(1,"week2");
			optionShit.remove("weeklocked");
			menuDescs.remove("???");
			menuDescs.insert(1,"Cheer up");
		}



		if(Highscore.getScore('Begin', 2) != 0){
			ClientPrefs.week2 = true;
			ClientPrefs.saveSettings();
		}
		if(ClientPrefs.week2){
			optionShit.insert(2,"week3");
			optionShit.remove("weeklocked");
			menuDescs.remove("???");
			menuDescs.insert(2,"Violence never solved");
		}



		if(Highscore.getScore('Together', 2) != 0){
			ClientPrefs.week3 = true;
			ClientPrefs.saveSettings();
		}
		if(ClientPrefs.week3){
			optionShit.insert(3,"week4");
			optionShit.remove("weeklocked");
			menuDescs.remove("???");
			menuDescs.insert(3,"Hinata's new friend");
		}



		if(Highscore.getScore('The-most-powerful', 2) != 0){
			ClientPrefs.week4 = true;
			ClientPrefs.saveSettings();
		}
		if(ClientPrefs.week4){
			optionShit.insert(4,"week5");
			optionShit.remove("weeklocked");
			FlxG.sound.playMusic(Paths.music('finale'), 0.7);
			menuDescs.remove("???");
			menuDescs.insert(4,"The Finale");
		}

		
		
		
		
		
		if(Highscore.getScore('All-belongs-to-us', 2) != 0){
			new FlxTimer().start(2, function(tmr:FlxTimer)          
			{	
			MusicBeatState.switchState(new UnlockState());
		    });
			FlxG.sound.playMusic(Paths.music('nothing'), 0.7);
			ClientPrefs.unlockNow = true;
			ClientPrefs.saveSettings();
			FlxG.camera.fade(FlxColor.BLACK, 0.1, false, function() {
			});
		}



		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(105, 300);
				menuItem.scrollFactor.x = 1;
				menuItem.scrollFactor.y = 0;
				menuItem.scale.x = scale;
				menuItem.scale.y = scale;
				menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.addByPrefix('press', optionShit[i] + " pressed", 24);
				menuItem.animation.play('idle');
				menuItem.setGraphicSize(Std.int(menuItem.width * 0.50));
				menuItem.ID = i;
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				menuItem.updateHitbox();
				menuItem.x= 50 + (i * 250);
				menuItem.y= 193;
				
		}

		var hola:FlxSprite = new FlxSprite().loadGraphic(Paths.image('blackAlpha'));
		hola.screenCenter();
		add(hola);
		
		menuGameDesc = new FlxText((FlxG.width / 2) - 310, (FlxG.height / 2) - 60, 600, "", 25);
		menuGameDesc.scrollFactor.set();
		menuGameDesc.borderSize = 4;
		menuGameDesc.y = 600;
		menuGameDesc.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(menuGameDesc);



		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
    {
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		menuGameDesc.text = menuDescs[curSelected];

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}

			if (controls.ACCEPT)
			{
				
				if (optionShit[curSelected] == 'weeklocked')
					{
						FlxG.sound.play(Paths.sound('locked'));
						camGame.shake(0.005, 0.2);
					}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.camera.flash(FlxColor.WHITE, 1);
					//aqui

					//if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							/*
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
							*/
							FlxTween.tween(spr, {y: 1000}, 2, {ease: FlxEase.backInOut, type: ONESHOT, onComplete: function(twn:FlxTween) {
								spr.kill();
							}});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'week1':
										MusicBeatState.switchState(new Episode1State());
									case 'week2':
										MusicBeatState.switchState(new Episode2State());
									case 'week3':
										MusicBeatState.switchState(new Episode3State());
									case 'week4':
										MusicBeatState.switchState(new Episode4State());
									case 'week5':
										MusicBeatState.switchState(new Episode5State());
								}
							});
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(Y);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

	/*	switch (curSelected)
		{
			case 0:
				cg.animation.play('idle');
			case 1:
				cg.animation.play('fix');
				cg.animation.finishCallback = function(fix)
					{
						cg.animation.play('fix2');
					}
			case 2:
				cg.animation.play('tape');
				cg.animation.finishCallback = function(tape)
					{
						cg.animation.play('tape2');
					}
			case 3:
				cg.animation.play('idle');
		}
*/
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				spr.updateHitbox();
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
				spr.updateHitbox();
			}
		});
	}

	function loadWeek1()
		{
			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			PlayState.isStoryMode = true;
			WeekData.reloadWeekFiles(true);
	
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[0]).songs;
	
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}
	
			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
	
			var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
			PlayState.storyDifficulty = diff;
	
			var diffic:String = CoolUtil.getDifficultyFilePath(diff);
			if(diffic == null) diffic = '';
			//trace('diff: $diff, diffic: $diffic');
	
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
	
			LoadingState.loadAndSwitchState(new PlayState(), true);
			FreeplayState.destroyFreeplayVocals();
		}
	function loadWeek2()
	{
		// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

		var songArray:Array<String> = [];
		var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[1]).songs;

		for (i in 0...leWeek.length) {
			songArray.push(leWeek[i][0]);
		}

		// Nevermind that's stupid lmao
		PlayState.storyPlaylist = songArray;
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
		PlayState.storyDifficulty = diff;

		var diffic:String = CoolUtil.getDifficultyFilePath(diff);
		if(diffic == null) diffic = '';
		//trace('diff: $diff, diffic: $diffic');

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
	}
	function loadWeek3()
	{
		// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

		var songArray:Array<String> = [];
		var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[2]).songs;

		for (i in 0...leWeek.length) {
			songArray.push(leWeek[i][0]);
		}

		// Nevermind that's stupid lmao
		PlayState.storyPlaylist = songArray;
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
		PlayState.storyDifficulty = diff;

		var diffic:String = CoolUtil.getDifficultyFilePath(diff);
		if(diffic == null) diffic = '';
		//trace('diff: $diff, diffic: $diffic');

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
	}
	function loadWeek4()
	{
		// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

		var songArray:Array<String> = [];
		var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[3]).songs;

		for (i in 0...leWeek.length) {
			songArray.push(leWeek[i][0]);
		}

		// Nevermind that's stupid lmao
		PlayState.storyPlaylist = songArray;
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
		PlayState.storyDifficulty = diff;

		var diffic:String = CoolUtil.getDifficultyFilePath(diff);
		if(diffic == null) diffic = '';
		//trace('diff: $diff, diffic: $diffic');

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
	}
	function loadWeek5()
	{
		// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

		var songArray:Array<String> = [];
		var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[4]).songs;

		for (i in 0...leWeek.length) {
			songArray.push(leWeek[i][0]);
		}

		// Nevermind that's stupid lmao
		PlayState.storyPlaylist = songArray;
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
		PlayState.storyDifficulty = diff;

		var diffic:String = CoolUtil.getDifficultyFilePath(diff);
		if(diffic == null) diffic = '';
		//trace('diff: $diff, diffic: $diffic');

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
	}

	override function beatHit()
	{
		super.beatHit();

		if (logoBl != null)
			logoBl.animation.play('bump', true);
	}
}