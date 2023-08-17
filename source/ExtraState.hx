package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;

class ExtraState extends MusicBeatState{
    var freeplayCats:Array<String> = ['Gallery', 'Fan arts', 'Soundtracks'];
	var grpCats:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;
	var BG:FlxSprite;
    var selectorLeft:Alphabet;
	var selectorRight:Alphabet;
	var chess:FlxBackdrop;
	var backdrop:FlxBackdrop;
    override function create(){
        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('kazashiBg'));
		menuBG.screenCenter();
		add(menuBG);
		
		backdrop = new FlxBackdrop(Paths.image('yeyu'));
		backdrop.velocity.set( -50);
		backdrop.antialiasing = ClientPrefs.globalAntialiasing;
		add(backdrop);
		
		
		chess = new FlxBackdrop(Paths.image('yay'), 0, 0, true, false);
		chess.scrollFactor.set(0, 0);
		chess.y -= 150;
		add(chess);
		
		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;

        grpCats = new FlxTypedGroup<Alphabet>();
		add(grpCats);

		if (!FlxG.sound.music.playing)
			{	
				FlxG.sound.playMusic(Paths.music('optionsSong'), 0.7);
				FlxG.sound.music.time = 0;
				Conductor.changeBPM(102);
			}

		

        for (i in 0...freeplayCats.length)
        {
			var catsText:Alphabet = new Alphabet(0, 0, freeplayCats[i], true);
            catsText.screenCenter();
            catsText.y += (100 * (i - (freeplayCats.length / 2))) + 50;
			grpCats.add(catsText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();

		super.create();
	}

    override function update(elapsed:Float) {
		super.update(elapsed);
        
		if (controls.UI_UP_P) 
			changeSelection(-1);
		if (controls.UI_DOWN_P) 
			changeSelection(1);
		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
			FlxG.sound.music.stop();
		}
        if (controls.ACCEPT){
            switch(curSelected){
                case 0:
                MusicBeatState.switchState(new GalleryState());
                case 1:
                MusicBeatState.switchState(new FanartState());
				case 2:
                MusicBeatState.switchState(new OstPlayerState());
				FlxG.sound.music.stop();
            }
        }
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = freeplayCats.length - 1;
		if (curSelected >= freeplayCats.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpCats.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}