package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	var transGradient:FlxSprite;
	var awesomeTrans:FlxSprite;

	public function new(duration:Float, isTransIn:Bool) {
		super();

		this.isTransIn = isTransIn;
		var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);

		awesomeTrans = new FlxSprite();
		awesomeTrans.frames = Paths.getSparrowAtlas('transition');
		awesomeTrans.animation.addByPrefix('intro','intro',24,false);
		awesomeTrans.animation.addByPrefix('end','end',24,false);
		awesomeTrans.screenCenter();
		awesomeTrans.scrollFactor.set(0, 0);
		awesomeTrans.updateHitbox();
		awesomeTrans.antialiasing = ClientPrefs.globalAntialiasing;
		add(awesomeTrans);
		
		
		if (!isTransIn) 
			{
				awesomeTrans.animation.play('intro');
				awesomeTrans.animation.finishCallback = function(name:String){finishCallback();};
			}
		else 
			{
				awesomeTrans.animation.play('end');
				awesomeTrans.animation.finishCallback = function(name:String){close();};
			}

		if(nextCamera != null) {
			awesomeTrans.cameras = [nextCamera];
		}

		
		nextCamera = null;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}