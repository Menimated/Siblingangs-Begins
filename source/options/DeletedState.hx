package options;

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

class DeletedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
	
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		new FlxTimer().start(7, function(tmr:FlxTimer) {
		warnText = new FlxText(0, 0, FlxG.width,
			"Save data has been deleted.
			The game will closed",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.RED, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	    });

		FlxG.sound.play(Paths.sound('boom'));
		FlxG.camera.fade(FlxColor.RED, 7, true, function() 
		{
		});

		
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			new FlxTimer().start(7, function(tmr:FlxTimer) {
			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('nothing'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						Sys.exit(0);
					}
				});
			}
		});
		}
		super.update(elapsed);
	}
}
