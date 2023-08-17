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
import flixel.FlxCamera;

class CheaterState extends MusicBeatState
{
	public static var leftState:Bool = false;
	private var camGame:FlxCamera;

	var warnText:FlxText;
	override function create()
	{
		camGame = new FlxCamera();
		FlxG.sound.play(Paths.sound('locked'));
		FlxG.camera.shake(0.015, 0.3);
		
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('anticheat'));
		menuBG.screenCenter();
		add(menuBG);
		
		



		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		super.create();


		warnText = new FlxText(0, 0, FlxG.width,
			"EXPUNGED SMELLS CHEATERS!
			
			
			
			",
			32);
		warnText.setFormat("VCR OSD Mono", 52, FlxColor.RED, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		warnText = new FlxText(0, 0, FlxG.width,
			"It looks like you tried to launch the story mode while debug mode was actived. 
			To turn off debug mode, type 'deactivate debug mode' in the secret code.",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		
	}

	override function update(elapsed:Float)
	{
			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('nothing'));
						MusicBeatState.switchState(new GameState());
						FlxG.sound.music.stop();
					}
				}
			}
	