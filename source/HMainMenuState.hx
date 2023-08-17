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
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class HMainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '6.6.6'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	public static var firstStart:Bool = true;
	
	var optionShit:Array<String> = [
		'ohno',
		'ohno2',
		'ohno3',
		'ohno4',
		'ohno5'
	];

	var overlay:FlxSprite;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	//var chess:FlxSprite;
	var chess:FlxBackdrop;
	var backdrop:FlxBackdrop;

	var logoBl:FlxSprite;

	public static var finishedFunnyMove:Bool = false;
	
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("YOU'RE IN BIG TROUBLE RIGHT NOW PLAYER", null);
		#end
		WeekData.loadTheFirstEnabledMod();
        FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

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
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		
		backdrop = new FlxBackdrop(Paths.image('yeyuHinataxml'), 0, 0);
		backdrop.velocity.set( -50);
		backdrop.antialiasing = ClientPrefs.globalAntialiasing;
		add(backdrop);
		
		
		chess = new FlxBackdrop(Paths.image('yayHinataxml'), 0, 0, true, false);
		chess.scrollFactor.set(0, 0);
		chess.y -= 150;
		add(chess);
		
		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;

		
		
		overlay = new FlxSprite(0).loadGraphic(Paths.image('menubox'));
		overlay.scrollFactor.set(0, 0);
		overlay.y += 400;
		overlay.updateHitbox();
		overlay.antialiasing = ClientPrefs.globalAntialiasing;
		add(overlay);

		//vem
		FlxTween.tween(overlay, {y:0}, 1.2, {ease: FlxEase.expoInOut});
		
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
		
		for (i in 0...optionShit.length)
		{
			var offset:Float = 100 - (Math.max(optionShit.length, 4) - 4) * 50;
				var menuItem:FlxSprite = new FlxSprite(105, 300);
				menuItem.scrollFactor.x = 1;
				menuItem.scrollFactor.y = -20;
				menuItem.scale.x = scale;
				menuItem.scale.y = scale;
				menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.addByPrefix('press', optionShit[i] + " pressed", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				menuItem.setGraphicSize(Std.int(menuItem.width * 0.90));
				menuItem.screenCenter(X);
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				menuItem.updateHitbox();
				menuItem.x= 408 + (i * 450);
				menuItem.y= 193;
				
			logoBl = new FlxSprite(-170, -170);

			logoBl.frames = Paths.getSparrowAtlas('logoBumpin2');
			logoBl.scrollFactor.set();
			logoBl.antialiasing = ClientPrefs.globalAntialiasing;
			logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
			logoBl.setGraphicSize(Std.int(logoBl.width * 0.3));
			logoBl.animation.play('bump');
			logoBl.alpha = 0;
			logoBl.angle = -4;
			logoBl.updateHitbox();
			add(logoBl);
			FlxTween.tween(logoBl, {
				y: logoBl.y + 170,
				x: logoBl.x + 150,
				angle: -4,
				alpha: 1
			}, 1.4, {ease: FlxEase.expoInOut});
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		camGame.zoom = 3;
		FlxTween.tween(camGame, {zoom: 1}, 1.1, {ease: FlxEase.expoInOut});

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Expunged Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font("bruh"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "THERE IS NO ESCAPE FOR YOU!", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font("bruh"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

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
		FlxG.sound.play(Paths.sound('achievement'), 0.7);
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

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenuH'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenuH'));
				changeItem(1);
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'freeplaylocked')
				{
					FlxG.sound.play(Paths.sound('locked'));
					camGame.shake(0.005, 0.2);
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenuH'));
					FlxG.camera.flash(FlxColor.WHITE, 1);
					//aqui

					//if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
							
							FlxTween.tween(camGame, {zoom: 10}, 1.6, {ease: FlxEase.expoIn});
							
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
									case 'ohno':
										MusicBeatState.switchState(new HGameState());
									case 'ohno2':
										MusicBeatState.switchState(new HMainMenuState());
									case 'ohno3':
									    MusicBeatState.switchState(new HMainMenuState());
									case 'ohno4':
										MusicBeatState.switchState(new HMainMenuState());
									case 'ohno5':
										MusicBeatState.switchState(new HMainMenuState());
									}
								});
							}
						});
					}
				}
				#if desktop
				else if (FlxG.keys.justPressed.SEVEN)
				{
					var funnyText = new FlxText(12, FlxG.height - 24, 0, "You can't.");
					funnyText.scrollFactor.set();
					funnyText.screenCenter();
					funnyText.x = FlxG.width/2 - 250;
					funnyText.y = FlxG.height/2 - 64;
					funnyText.setFormat("VCR OSD Mono", 64, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
					add(funnyText);
					FlxG.sound.play(Paths.sound('locked'));
					camGame.shake(0.005, 0.2);
					FlxTween.tween(funnyText, {alpha: 0}, 0.6, {
						onComplete: function(tween:FlxTween)
						{
							funnyText.destroy();
						}
					});
				}
				#end
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

	override function beatHit()
	{
		super.beatHit();

		if (logoBl != null)
			logoBl.animation.play('bump', true);
	}
}