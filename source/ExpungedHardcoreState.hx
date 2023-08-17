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
import flixel.tweens.FlxEase;

class ExpungedHardcoreState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
	
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		super.create();

		FlxG.sound.playMusic(Paths.music('pauseExpunged'), 0.7);
		FlxG.sound.music.fadeIn(3, 0);

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('anticheat'));
		menuBG.screenCenter();
		add(menuBG);

		new FlxTimer().start(6, function(tmr:FlxTimer) {
		warnText = new FlxText(0, 0, FlxG.width,
			"You cannot restart the song when you're in hardcore",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.RED, CENTER);
		warnText.screenCenter(Y);
		warnText.alpha = 0;
		add(warnText);
		FlxTween.tween(warnText, {alpha: 1}, 3, {ease: FlxEase.expoInOut});
	   });

		FlxG.camera.flash(FlxColor.BLACK, 10);

		new FlxTimer().start(30, function(tmr:FlxTimer) {
		var menuBG2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('jumpscare'));
		menuBG2.screenCenter();
		add(menuBG2);
		FlxG.sound.play(Paths.sound('jumpscare'));
		FlxG.sound.music.stop();
		ClientPrefs.expunged = false;
		ClientPrefs.saveSettings();
		});

		
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			new FlxTimer().start(31.2, function(tmr:FlxTimer) {
				Sys.exit(0);
			});
		}
		super.update(elapsed);
	}
}
