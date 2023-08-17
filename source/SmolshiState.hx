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
import openfl.filters.ShaderFilter;
import flixel.FlxCamera;

class SmolshiState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public var camGame:FlxCamera;

	var warnText:FlxText;
	override function create()
	{
		
		camGame = new FlxCamera();
		FlxG.cameras.add(camGame);
		FlxG.sound.playMusic(Paths.music('smolshiPixel'), 0.7);
		new FlxTimer().start(25, function(tmr:FlxTimer)          
			{	
			FlxG.sound.music.stop();
			});

		var vcrDistortion:VCRDistortionEffect = new VCRDistortionEffect();
				camGame.setFilters([new ShaderFilter(vcrDistortion.shader)]);

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		super.create();

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('titleSmolshi'));
		menuBG.screenCenter();
		menuBG.cameras = [camGame];
		add(menuBG);

		warnText = new FlxText(0, 0, FlxG.width,
			"PRESS START",
			32);
		warnText.setFormat("nes.otf", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.cameras = [camGame];
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('pixelstart'));
				FlxG.sound.music.stop();
				FlxFlicker.flicker(warnText, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
				PlayState.SONG = Song.loadFromJson('neko-neko-hard', 'neko-neko');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 0;
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.stop();
				ClientPrefs.smolshi2 = true;
				ClientPrefs.saveSettings();
			});
			}
		}
		super.update(elapsed);
	}
}
