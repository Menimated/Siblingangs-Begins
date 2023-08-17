package;
#if sys
import sys.io.File;
import sys.io.Process;
import flash.system.System;
#end
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import openfl.Assets;
import flixel.addons.transition.FlxTransitionableState;


class IntroStateH extends MusicBeatState
{
  var introy:FlxSprite;

	public function new()
	{
		super();
	}

	override public function create():Void
	{

    FlxTransitionableState.skipNextTransIn = true;
    FlxTransitionableState.skipNextTransOut = true;

    super.create();
    FlxG.mouse.visible = false;
    introy = new FlxSprite();
    trace('huh');
    introy.frames = Paths.getSparrowAtlas('expunged');
    introy.animation.addByPrefix('nice', 'glitch', 24, false);
    introy.screenCenter();
    introy.antialiasing = false;
    add(introy);
    
    trace('huh2');
      introy.animation.play('nice');
      FlxG.sound.play(Paths.sound('expunged'));
      new FlxTimer().start(6, function(tmr:FlxTimer)
      {
        stop();
      });
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
    if (FlxG.keys.pressed.ONE)
		{
			stop();
		}
    
    // if(introy.animation.curAnim.finished)
    // {
    //   introy.destroy();
    //   new FlxTimer().start(0.25, function(tmr:FlxTimer)
    //   {
    //     stop();
    //   });
    // }


	}

	public function stop()
	{
		PlatformUtil.sendFakeMsgBox("I HOPE YOU DON'T LIVE THROUGH THIS! MUAHAHAHAHAHAHAHA!");
    ClientPrefs.expunged = true;
				ClientPrefs.saveSettings();
        var content = [for (_ in 0...1) "relaunch the game... now"].join(" ");
						var path:String = 'expungeds note.txt';
						if (!sys.FileSystem.exists(path) || (sys.FileSystem.exists(path) && sys.io.File.getContent(path) == content))
							sys.io.File.saveContent(path, content);
        Sys.exit(0);
    // FlxG.switchState(new YouCheatedOrWhatever());
	}

}
