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

class WelcomeState extends MusicBeatState
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
			"Oh hey! \n 
			Since you're be new around here. \n
			You must complete the story mode in order to unlock Freeplay songs and Extra mode! \n
			
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
				MusicBeatState.switchState(new WelcomeState2());
			}
		}
		super.update(elapsed);
	}
}
