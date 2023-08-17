package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxSave;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Achievements;
import editors.MasterEditorMenu;
import Controls;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

using StringTools;

class FreeplaySelectState extends MusicBeatState
{
	/*var options:Array<String> = [
			#if MODS_ALLOWED 'Mods',
			#end
			#if ACHIEVEMENTS_ALLOWED
			'Awards',
			#end
			#if !switch 'Donate',
			#end
		]; */ // todo, fix somethings with this menus
	var options:Array<String> = ['Story', 'Extra'];

	// gui, you dont need to made a var with the versions again, use the MainMenuState.hx ones
	private var grpOptions:FlxTypedGroup<Alphabet>;

	private static var curSelected:Int = 0;

	private var camAchievement:FlxCamera;

	public static var menuBG:FlxSprite;
	private var camGame:FlxCamera;

	var debugKeys:Array<FlxKey>;
	var char:FlxSprite;
	var initX:Float;
    var initY:Float;
	var personajes:FlxSprite;
	var chess:FlxBackdrop;
	var overlay:FlxSprite;

	function openSelectedSubstate(label:String)
	{
		switch (label)
		{
			case 'Story':
				MusicBeatState.switchState(new FreeplayState());
				FlxG.sound.music.stop();
			case 'Extra':
				MusicBeatState.switchState(new FreeplayExtraState());
				FlxG.sound.music.stop();
			case 'Covers':
				MusicBeatState.switchState(new FreeplayCoverState());
				FlxG.sound.music.stop();
			case 'Secret Codes':
				if(ClientPrefs.secretcode)
					{
					FlxG.sound.music.stop();
					MusicBeatState.switchState(new SecretCode());
					} else {
					FlxG.sound.music.stop();
					MusicBeatState.switchState(new SecretCodeStart());
					}
				FlxG.sound.music.stop();
		}
	}

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Freeplay Selector", null);
		#end

		if(ClientPrefs.weekDNB){
			options.insert(2,"Covers");
			options.insert(3,"Secret Codes");
		}

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;
		
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay/nothing'));
		menuBG.screenCenter();
		add(menuBG);

		if (!FlxG.sound.music.playing)
			{	
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
				FlxG.sound.music.time = 0;
				Conductor.changeBPM(102);
			}


		personajes = new FlxSprite(0,0);
		personajes.loadGraphic(Paths.image('freeplay/' + options[curSelected]));
		personajes.scrollFactor.set(0, 0);
		personajes.setGraphicSize(Std.int(personajes.width * 1));
		personajes.antialiasing = ClientPrefs.globalAntialiasing;
		add(personajes);

		chess = new FlxBackdrop(Paths.image('yay'), 0, 0, true, false);
		chess.scrollFactor.set(0, 0);
		chess.y -= 150;
		add(chess);
		
		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;

		overlay = new FlxSprite(0).loadGraphic(Paths.image('mmovS'));
		overlay.scrollFactor.set(0, 0);
		overlay.x -= 3900;
		overlay.updateHitbox();
		overlay.antialiasing = ClientPrefs.globalAntialiasing;
		add(overlay);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.x= 150;
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		changeSelection();

		super.create();
	}

	override function closeSubState()
	{
		super.closeSubState();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		Conductor.songPosition = FlxG.sound.music.time;

	if (!selectedSomethin)
	{
		if (controls.UI_DOWN_P || controls.UI_UP_P){

			FlxTween.tween(personajes,{x: 600, alpha : 0},0.2,{ease:FlxEase.cubeIn,onComplete: function(twn:FlxTween)
				{
					personajes.loadGraphic(Paths.image('freeplay/' + options[curSelected]));
					FlxTween.tween(personajes,{x: 0, alpha : 1},0.2,{ease:FlxEase.cubeOut});
				}
			});
		}
		
		if (controls.UI_UP_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(1);
		}

		if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}

		if (controls.ACCEPT)
		{
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(camGame, {zoom: 10}, 1.6, {ease: FlxEase.expoIn});
			FlxTween.tween(overlay, {x:-4580}, 1.4, {ease: FlxEase.expoInOut});
			FlxG.sound.music.fadeOut(1, 0);
			grpOptions.forEach(function(grpOptions:Alphabet)
			{
				FlxFlicker.flicker(grpOptions, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					openSelectedSubstate(options[curSelected]);
				});
			});
		}
	}
    }

	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;
		FlxG.cameras.add(camAchievement);
		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement
		function giveAchievement()
		{
			add(new AchievementObject('friday_night_play', camAchievement));
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			trace('Giving achievement "friday_night_play"');
		}
		#end
		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
			{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end
		
	}
}
