package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;

class WelcomeState2 extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	override function create()
	{

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('kazashiBg'));
		menuBG.screenCenter();
		add(menuBG);
		


		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];


		super.create();

		warnText = new FlxText(0, 0, FlxG.width,
			"to avoid causing a seizure. You can go the options to disable Flashing lights! Nevertheless, if you don't care, you can just leave the seizure-related features on. \n
			Good luck! \n

			Press ENTER to continue",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				ClientPrefs.welcome = true;
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTween.tween(camGame, {zoom: 10}, 1.6, {ease: FlxEase.expoIn});
				FlxG.camera.fade(FlxColor.WHITE, 1.5, false, function() 
				{			
				});
				new FlxTimer().start(1.5, function (tmr:FlxTimer) 
				{
				MusicBeatState.switchState(new MainMenuState());
			    });
			}
		}
		super.update(elapsed);
	}
}
