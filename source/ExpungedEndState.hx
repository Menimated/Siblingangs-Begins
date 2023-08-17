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

class ExpungedEndState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"HOW IS THIS REALLY POSSIBLE? PROBABLY IMPRESSIVE. I'LL SEE YOU AGAIN SOON!
			BUT MAYBE, I GUESS YOU'RE FREE TO GO.
			- Expunged",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.RED, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		Application.current.window.title = "Friday Night Funkin': Siblingangs Begins";

		
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				ClientPrefs.expunged = false;
				ClientPrefs.saveSettings();
				ClientPrefs.unsurvivable = true;
			    ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('nothing'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new FreeplaySelectState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
