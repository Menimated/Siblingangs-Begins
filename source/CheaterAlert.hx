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

class CheaterAlert extends MusicBeatState
{
	public static var leftState:Bool = false;
	private var camGame:FlxCamera;

	var warnText:FlxText;
	override function create()
	{

		camGame = new FlxCamera();
		FlxG.sound.play(Paths.sound('crashed'));
		FlxG.camera.shake(0.015, 0.3);
		
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('familyguydeathpose'));
		menuBG.screenCenter();
		add(menuBG);

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		super.create();

		warnText = new FlxText(0, 0, FlxG.width,
			" ",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		new FlxTimer().start(1, function(tmr:FlxTimer) {
			PlatformUtil.sendFakeMsgBox("You really thought you can get away with cheating? What a loser.");
			Sys.exit(0);
		});
		super.update(elapsed);
	}

	function loadWeek1()
		{
			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			PlayState.isStoryMode = true;
			WeekData.reloadWeekFiles(true);
	
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[0]).songs;
	
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}
	
			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
	
			var diff:Int = Math.floor(Math.max(0, CoolUtil.defaultDifficulties.indexOf('Hard')));
			PlayState.storyDifficulty = diff;
	
			var diffic:String = CoolUtil.getDifficultyFilePath(diff);
			if(diffic == null) diffic = '';
			//trace('diff: $diff, diffic: $diffic');
	
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
	
			LoadingState.loadAndSwitchState(new PlayState(), true);
			FreeplayState.destroyFreeplayVocals();
		}
}
