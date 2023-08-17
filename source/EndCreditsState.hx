package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class EndCreditsState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		FlxG.sound.play(Paths.sound('endCredits'), 0.7);



		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		var ending:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('creditsReal'));
		ending.scrollFactor.set(1280, 720);
		ending.y += 720;
		ending.updateHitbox();
		ending.antialiasing = ClientPrefs.globalAntialiasing;
		add(ending);

		FlxTween.tween(ending, {y:-1390}, 165.01);

		new FlxTimer().start(166.01, function(tmr:FlxTimer) {
		var ending2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('thanksforplaying'));
		ending2.screenCenter();
		ending2.alpha = 0;
		add(ending2);
		FlxTween.tween(ending2, {alpha: 1}, 3, {ease: FlxEase.expoInOut});
		});
	}

	override function update(elapsed:Float)
	{
		new FlxTimer().start(172, function(tmr:FlxTimer) {
			if(ClientPrefs.weekDNB){
			MusicBeatState.switchState(new MainMenuState());
		    } else {
			MusicBeatState.switchState(new UnlockState3());
			}
			ClientPrefs.EndingCredits = false;
				FlxG.sound.music.stop();
		});
		super.update(elapsed);
	}
}
