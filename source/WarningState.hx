package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
//import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class WarningState extends MusicBeatState
{   

    
	var dropText:FlxText;
	var warningMusic:FlxSound;

    override function create() 
	{  
         
        super.create();
		
		var bg:FlxSprite = new FlxSprite();
		
		bg.loadGraphic(Paths.image("warning"));
		bg.alpha = 0;
		add(bg);
		FlxTween.tween(bg, {alpha: 1}, 1.2, {ease: FlxEase.circOut});


        FlxG.sound.play(Paths.sound('welcomeSound'), 0.7);
        
        DiscordClient.changePresence("Inside The Opening Menu", null);

        dropText = new FlxText(-150, 0, Std.int(FlxG.width * 1), "", 30);
		dropText.setFormat(Paths.font("CuteEnung.otf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dropText.alpha = 0;
		add(dropText);
        //FlxTween.tween(pic, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
        FlxTween.tween(dropText, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
       
    }


    override function update(elapsed:Float)
	{
	/*	if (warningMusic.volume < 0.3)
			warningMusic.volume += 0.01 * elapsed; */
			
        dropText.text = "NEW SIBLINGANGS BEGINS UPDATE!

This new version may contains:
- New Improved Menus
- Bugs fixed
- Remastered songs
- Replaced old week 4 with a NEW official week 4
- New songs, Bonus, and Covers!

This mod is only for demo
The SGB final build still work in progress
Some things are unfinished such as Backgrounds,

(Press any key to continue)";
        dropText.visible = true;
        dropText.screenCenter();
        
        if (controls.ACCEPT){
			MusicBeatState.switchState(new TitleState());
		}
	}
}