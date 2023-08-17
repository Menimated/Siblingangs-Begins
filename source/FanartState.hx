package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class FanartState extends MusicBeatState{
    public static var freeplayCats:Array<String> = ['1', '2', '3', '4', '5'];
	var menuDescs:Array<String> = [
		"Suihyou",
		'SmashFanBro',
		'Magical_dream_22',
		"050nonko",
		'markyy_mo'
	];
    public static var curCategory:Int = 0;
	var curSelected:Int = 0;
	var BG:FlxSprite;
    var ArrowGroup:FlxGroup;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
	var categoryIcon:FlxSprite;
    var chess:FlxBackdrop;
	var backdrop:FlxBackdrop;
    var newArrows:FlxSprite;
	var menuGameDesc:FlxText;
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
        categoryIcon = new FlxSprite().loadGraphic(Paths.image('Fanarts/gallery- ' + freeplayCats[curSelected].toLowerCase()));
		categoryIcon.setGraphicSize(Std.int(categoryIcon.width * 0.20));
        categoryIcon.updateHitbox();
		categoryIcon.screenCenter();
		add(categoryIcon);
        /*grpCats = new FlxTypedGroup<Alphabet>();
		add(grpCats);
        for (i in 0...freeplayCats.length)
        {
			var catsText:Alphabet = new Alphabet(0, (70 * i) + 30, freeplayCats[i], true, false);
            catsText.targetY = i;
            catsText.isMenuItem = true;
			grpCats.add(catsText);
		}*/

        changeSelection();
        super.create();
    
		ArrowGroup = new FlxGroup();
		add(ArrowGroup);

		
        newArrows = new FlxSprite();
        newArrows.frames = Paths.getSparrowAtlas('newArrows', 'background');
        newArrows.animation.addByPrefix('idle', 'static', 24, false);
        newArrows.animation.addByPrefix('left', 'leftPress', 24, false);
        newArrows.animation.addByPrefix('right', 'rightPress', 24, false);
        newArrows.antialiasing = true;
        newArrows.screenCenter(XY);
        newArrows.offset.set(0, -45);
        newArrows.animation.play('idle');
        add(newArrows);

		var hola:FlxSprite = new FlxSprite().loadGraphic(Paths.image('blackAlpha2'));
		hola.screenCenter();
		add(hola);
		
		menuGameDesc = new FlxText((FlxG.width / 2) - 310, (FlxG.height / 2) - 60, 600, "", 25);
		menuGameDesc.scrollFactor.set();
		menuGameDesc.borderSize = 4;
		menuGameDesc.y = 630;
		//menuGameDesc.y = 600;
		menuGameDesc.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(menuGameDesc);
		
		



	}
   
    override public function update(elapsed:Float){
        
        menuGameDesc.text = menuDescs[curSelected];
		
		if(controls.UI_RIGHT_P)
            {
                newArrows.offset.set(0, 4);
                newArrows.animation.play('right', true);
                changeSelection(1);
            }
        if(controls.UI_LEFT_P)
            {
                newArrows.offset.set(33, 3);
                newArrows.animation.play('left', true);
                changeSelection(-1);
            }
		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new ExtraState());
		}

        curCategory = curSelected;

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = freeplayCats.length - 1;
		if (curSelected >= freeplayCats.length)
			curSelected = 0;

		var bullShit:Int = 0;

		/*for (item in grpCats.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}*/

		categoryIcon.loadGraphic(Paths.image('Fanarts/gallery- ' + (freeplayCats[curSelected].toLowerCase())));
        categoryIcon.setGraphicSize(Std.int(categoryIcon.width * 0.20));
		categoryIcon.scale.set(0.15 ,0.15);
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}