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

class Episode3State extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();
		
		FlxG.sound.music.fadeOut(3, 0);

		FlxG.camera.flash(FlxColor.BLACK, 1);

		new FlxTimer().start(4, function(tmr:FlxTimer) {
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function() 
				{
				});
			});


		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"- Episode 3 -\n
			Violence never solved",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		new FlxTimer().start(6, function(tmr:FlxTimer) {
			loadWeek3();
			FlxG.sound.music.stop();
	});
		super.update(elapsed);
	}

	function loadWeek3()
		{
			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			PlayState.isStoryMode = true;
			WeekData.reloadWeekFiles(true);
	
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[2]).songs;
	
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
