package;
import flixel.*;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

/**
 * ...
 * sorry bbpanzu
 */
class MessageState2 extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	override function create() 
	{
		new FlxTimer().start(1.6, function(tmr:FlxTimer)
		{
		FlxG.sound.play(Paths.sound('warning'), 0.7);
		FlxG.sound.music.stop();
	    });
		
		super.create();
		
		var bg:FlxSprite = new FlxSprite();
		
		bg.loadGraphic(Paths.image("kazashiNote"));
		add(bg);
		
		#if mobileC
		addVirtualPad(NONE, A_B);
		#end

		FlxG.camera.flash(FlxColor.BLACK, 1.5);

        new FlxTimer().start(21, function(tmr:FlxTimer)
		{
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, FlxG.width - 24, "Press ENTER to continue", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("CuteEnung.otf", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
	    });
			
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		new FlxTimer().start(20, function(tmr:FlxTimer)
		{
		if (controls.ACCEPT){
			MusicBeatState.switchState(new ContinueState());
		}
	    });
	}
}
