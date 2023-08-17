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

class ExpungedState extends MusicBeatState
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
			"I HOPE YOU DON'T LIVE THROUGH THIS! MUAHAHAHAHAHAHAHA! \n 
			- Expunged",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.RED, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				ClientPrefs.expunged = true;
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('nothing'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						var content = [for (_ in 0...1) "relaunch the game... now"].join(" ");
						var path:String = 'expungeds note.txt';
						if (!sys.FileSystem.exists(path) || (sys.FileSystem.exists(path) && sys.io.File.getContent(path) == content))
							sys.io.File.saveContent(path, content);
						Sys.exit(0);
					}
				});
			}
		}
		super.update(elapsed);
	}
}
