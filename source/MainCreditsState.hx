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

using StringTools;

class MainCreditsState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	public static var firstStart:Bool = true;
	
	var optionShit:Array<String> = [
		'menimated',
		'mom',
		'omega',
		'killer',
		'champ',
		'stuby',
		'xara',
		'akani',
		'special thanks',
		'discord',
		'original'
	];

	var menuDescs:Array<String> = [
		'Director, Coder, Artist, Charter, Musician, and Voice actor',
		'Charter',
		'Icon artist and Charter',
		'Charter',
		'Zuki Voice actor',
		'Haruki Voice actor',
		'Hinata Voice actor',
		'Kazashi Voice actor',
		'To everyone, Including you!',
		'Join the official Siblingangs Begins Discord server!',
		'Psych Engine Team and all contributors'
	];

	var menuName:Array<String> = [
		'Menimated',
		'mom gaming',
		'OmegaDragon',
		'Killer Avec Rage',
		'ChampionKnightEX',
		'StubyLegs2K5',
		'Xara',
		'Akani',
		'Special Thanks',
		'Discord Server',
		'Original Credits'
	];

	var selectedText:FlxText;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	//var chess:FlxSprite;
	var discord:FlxBackdrop;
	var menuGameDesc:FlxText;
	var menuNameDesc:FlxText;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

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

		FlxG.mouse.visible = true;

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
		var backdrop:FlxBackdrop;
		backdrop = new FlxBackdrop(Paths.image('sgbChecker'));
			backdrop.velocity.set(-40, -40);
			backdrop.antialiasing = ClientPrefs.globalAntialiasing;
			add(backdrop);

	

		
		


		
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

		for(i in 0...optionShit.length) {

			var tvScreen:FlxSprite = new FlxSprite();
			tvScreen.ID = i;
			tvScreen.frames = Paths.getSparrowAtlas('menuOther/credits');
			tvScreen.animation.addByPrefix('idle', optionShit[i] + ' Button', 24, true);
			tvScreen.animation.addByPrefix('hover', optionShit[i] + ' Select', 24, true);
			tvScreen.animation.play('idle');
			tvScreen.antialiasing = true;
			//x -90
			//y -100

			switch(i) {
				case 0:
					tvScreen.setPosition(73, 177);
					tvScreen.scale.set(0.50 ,0.50);
				case 1:
					tvScreen.setPosition(301, 177);
					tvScreen.scale.set(0.50 ,0.50);
				case 2:
					tvScreen.setPosition(543, 177);
					tvScreen.scale.set(0.50 ,0.50);
				case 3:
					tvScreen.setPosition(779, 177);
					tvScreen.scale.set(0.50 ,0.50);
				case 4:
					tvScreen.setPosition(999, 177);
					tvScreen.scale.set(0.50 ,0.50);
				case 5:
					tvScreen.setPosition(301, 384);
					tvScreen.scale.set(0.50 ,0.50);
				case 6:
					tvScreen.setPosition(543, 384);
					tvScreen.scale.set(0.50 ,0.50);
				case 7:
					tvScreen.setPosition(779, 384);
					tvScreen.scale.set(0.50 ,0.50);
				case 8:
					tvScreen.setPosition(73, 23);
				case 9:
					tvScreen.setPosition(543, 23);
				case 10:
					tvScreen.setPosition(999, 23);
			}
			menuItems.add(tvScreen);
		}	

		var hola:FlxSprite = new FlxSprite().loadGraphic(Paths.image('blackAlpha'));
		hola.screenCenter();
		add(hola);
		
		menuGameDesc = new FlxText((FlxG.width / 2) - 310, (FlxG.height / 2) - 60, 600, "", 25);
		menuGameDesc.scrollFactor.set();
		menuGameDesc.borderSize = 4;
		menuGameDesc.y = 630;
		//menuGameDesc.y = 600;
		menuGameDesc.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(menuGameDesc);

		menuNameDesc = new FlxText((FlxG.width / 2) - 310, (FlxG.height / 2) - 60, 600, "", 25);
		menuNameDesc.scrollFactor.set();
		menuNameDesc.borderSize = 10;
		menuNameDesc.y = 570;
		menuNameDesc.setFormat(Paths.font("vcr.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(menuNameDesc);




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

		menuNameDesc.text = menuName[curSelected];

		menuItems.forEach(function(spr:FlxSprite)
		{
			if(usingMouse)
			{
				if(!FlxG.mouse.overlaps(spr))
					spr.animation.play('idle');
			}
	
			if (FlxG.mouse.overlaps(spr))
			{
				if(canClick)
				{
					curSelected = spr.ID;
					usingMouse = true;
					spr.animation.play('hover');
				}
					
				if(FlxG.mouse.pressed && canClick)
				{
					switch (optionShit[curSelected]) {
						case 'menimated':
							FlxG.openURL('https://twitter.com/ItsMenimated');
						case 'mom':
							FlxG.openURL('https://twitter.com/momgamingreal');
						case 'omega':
							FlxG.openURL('https://twitter.com/OmegaDragon20');
						case 'killer':
							FlxG.openURL('https://twitter.com/Neverasked14');
						case 'champ':
							FlxG.openURL('https://twitter.com/ChampionFNF');
						case 'stuby':
							FlxG.openURL('https://twitter.com/stubylegs2k5');
						case 'xara':
							FlxG.openURL('https://twitter.com/XaraFNFSS');
						case 'akani':
							FlxG.openURL('https://twitter.com/OnigiriAkani');
						case 'special thanks':
							MusicBeatState.switchState(new SpecialThanksState());
						case 'discord':
							FlxG.openURL('https://discord.gg/278bJ4DktY');
						case 'original':
							MusicBeatState.switchState(new CreditsState());
					}
				}
			}
	
			spr.updateHitbox();
		});

		
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.setPosition(103, 177);
		});
	}

	function changeItem(huh:Int = 0)
		{
			if (finishedFunnyMove)
			{
				curSelected += huh;
	
				if (curSelected >= menuItems.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = menuItems.length - 1;
			}
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
	
				if (spr.ID == curSelected && finishedFunnyMove)
				{
					spr.animation.play('hover');				
				}
	
				spr.updateHitbox();
			});
		}
}