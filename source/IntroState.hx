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


class IntroState extends MusicBeatState
{
  var introy:FlxSprite;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
    super.create();
    FlxG.mouse.visible = false;
    introy = new FlxSprite();
    trace('huh');
    introy.frames = Paths.getSparrowAtlas('sup');
    introy.animation.addByPrefix('nice', 'intro', 24, false);
    introy.screenCenter();
    introy.antialiasing = false;
    add(introy);
    
    trace('huh2');
    new FlxTimer().start(1.25, function(tmr:FlxTimer)
    {
      introy.animation.play('nice');
      FlxG.sound.play(Paths.sound('introSE'));
      new FlxTimer().start(6.32, function(tmr:FlxTimer)
      {
        stop();
      });
    });
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
    if (FlxG.keys.pressed.ENTER)
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
    if(ClientPrefs.expunged)
    FlxG.switchState(new HTitleState());
    else
    FlxG.switchState(new TitleState());
	}

}
