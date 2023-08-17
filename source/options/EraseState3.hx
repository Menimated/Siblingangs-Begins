package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import flixel.addons.display.FlxBackdrop;
import flash.system.System;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class EraseState3 extends MusicBeatState
{
	var options:Array<String> = ['Dude, I am sure.', 'I cannot do that'];
	private var grpOptions:FlxTypedGroup<FlxText>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
    public static var menuText:FlxText;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Dude, I am sure.':
                MusicBeatState.switchState(new options.EraseState4());
				FlxG.sound.music.stop();
			case 'I cannot do that':
                FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new ContinueState());
				FlxG.sound.music.stop();
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Erase Save data", null);
		#end

		if (!FlxG.sound.music.playing)
			{	
				FlxG.sound.playMusic(Paths.music('alarm2'), 0.7);
				FlxG.sound.music.time = 0;
				Conductor.changeBPM(102);
			}

        menuText = new FlxText(0, 0, FlxG.width, "Save Data that has been deleted cannot be recovered! 
		You think you're going to delete it?", 20);
        menuText.setFormat("MochiyPopOne-Regular.ttf", 20, FlxColor.WHITE, CENTER);
		menuText.screenCenter();
        menuText.y -= 150;
		menuText.alpha = 1;
        add(menuText);

		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:FlxText = new FlxText(0, 0, FlxG.width, options[i], 20);
			optionText.setFormat("MochiyPopOne-Regular.ttf", 20, FlxColor.WHITE, CENTER);
			optionText.screenCenter();
			optionText.y += (50 * (i - (options.length / 2))) + 50;
			optionText.size = 20;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, ' ', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, ' ', true);
		add(selectorRight);

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		changeSelection();

		super.create();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new ContinueState());
			FlxG.sound.music.stop();
		}

		if (controls.ACCEPT) {
			openSelectedSubstate(options[curSelected]);
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;
		var alpha:Int = 0;

		for (item in grpOptions.members)
		{
			alpha = bullShit - curSelected;
			bullShit++;

			item.color = FlxColor.fromRGBFloat(0.75, 0.75, 0.75);
			if (alpha == 0)
			{
				item.color = FlxColor.WHITE;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}