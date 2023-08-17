package;
import flixel.*;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

/**
 * ...
 * sorry bbpanzu
 */
class GameOverState extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	override function create() 
	{
		FlxG.sound.play(Paths.sound('gameOverConfirm'), 0.7);
		
		super.create();
		
		var bg:FlxSprite = new FlxSprite();
		
		bg.loadGraphic(Paths.image("gameover"));
		add(bg);
		
		#if mobileC
		addVirtualPad(NONE, A_B);
		#end

		FlxG.camera.flash(FlxColor.BLACK, 6.5);
			
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		
		if (controls.ACCEPT){
			FlxG.sound.play(Paths.sound('confirmMenu'));
			if(ClientPrefs.unlockNow) {
				MusicBeatState.switchState(new GameState());						
			} else {
				MusicBeatState.switchState(new WeekSelectState());
			}
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
	}
}
