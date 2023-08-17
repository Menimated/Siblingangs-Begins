package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound; 
import flixel.text.FlxText;

class CharMenu extends MusicBeatState //This is not from the D&B source code, it's completely made by me (Delta). This also means I can use this code for other mods.
{
	public var characterData:Array<Dynamic> = [
        [[["Boyfriend", 'bf'], ["Boyfriend (Meni Form)", 'bf meni form'], ["Boyfriend (D-Sides)", 'D-bf']], [1, 1, 1, 1], false],  //0
        [[["Kazashi", 'kazashi-player'], ["Kazashi (Neko)", 'kazashi nekoPLAYER'], ["Kazashi (Impostor)", 'kazashi impostorP']], [1, 1, 1, 1], false],  //1
        [[["Zuki", 'zuki-player']], [1, 1, 1, 1], false],  //2
        [[["Hinata", 'hinata-player']], [1, 1, 1, 1], false],  //3
        [[["Meni", 'menimatedP'], ["Meni (Older)", 'menimatedOlderP']], [1, 1, 1, 1], false],  //4
        [[["Haruki", 'haruki player']], [1, 1, 1, 1], false],  //5
        [[["Hiroko", 'hiroko-player']], [1, 1, 1, 1], false],  //6
        [[["Dave", 'dave-player']], [1, 1, 1, 1], false],  //7
        [[["Bambi", 'bambi-player']], [1, 1, 1, 1], false],  //8
        [[["Tristan", 'tristan-player'], ["Golden Tristan", 'tristan-golden-player']], [1, 1, 1, 1], false],  //4
        [[["Smolshi", 'smolshi-playable']], [1, 1, 1, 1], false],  //9
    ];
    var characterSprite:Boyfriend;
    var characterFile:String = 'bf';

	var nightColor:FlxColor = 0xFF878787;
    var curSelected:Int = 0;
    var curSelectedForm:Int = 0;
    var curText:FlxText;
    var controlsText:FlxText;
    var formText:FlxText;
    var entering:Bool = false;

    var otherText:FlxText;
    var yesText:FlxText;
    var noText:FlxText;
    var previewMode:Bool = false;
    var newArrows:FlxSprite;
    var shitz:FlxSprite;


    override function create() 
    {
        FlxG.mouse.visible = true;
        FlxG.mouse.enabled = true;
        FlxG.sound.music.stop();
        FlxG.sound.playMusic(Paths.music('characterselect'), 1);
        
        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('CharSelect'));
		menuBG.screenCenter();
		add(menuBG);

        shitz = new FlxSprite(-72, 471).loadGraphic(Paths.image('everyone'));
        shitz.frames = Paths.getSparrowAtlas('everyone');
        shitz.animation.addByPrefix('idle', 'yay', 24, true);
        shitz.animation.play('idle');
        shitz.scrollFactor.set();
        shitz.antialiasing = ClientPrefs.globalAntialiasing;
        add(shitz);
        
        var menuBG2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('CharSelectDARK'));
        menuBG2.screenCenter();
        add(menuBG2);

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

        if(PlayState.SONG.player1 != "bf")
            {
                otherText = new FlxText(10, 150, 0, 'This song does not use BF as the player\nor has a different variant of BF.\nDo you want to continue without \nchanging character?\n', 20);
                otherText.setFormat(Paths.font("MochiyPopOne-Regular.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                otherText.size = 45;
                otherText.screenCenter(X);
                add(otherText);
                yesText = new FlxText(FlxG.width / 4, 550, 0, 'Yes', 20);
                yesText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                yesText.size = 45;
                add(yesText);
                noText = new FlxText(FlxG.width / 1.5, 550, 0, 'No', 20);
                noText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                noText.size = 45;
                add(noText);
            }
        else {
            spawnSelection();
        }

        super.create();
    }

    var selectionStart:Bool = false;

    function spawnSelection()
        {
            selectionStart = true;
            characterSprite = new Boyfriend(0, 12, "bf");
            add(characterSprite);
            characterSprite.dance();
            characterSprite.screenCenter(XY);
            characterSprite.y += 120;
            curText = new FlxText(0, 20, 0, characterData[curSelected][0][0][0], 20);
            curText.setFormat(Paths.font("MochiyPopOne-Regular.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            curText.size = 50;
            
            controlsText = new FlxText(10, 50, 0, 'Press P to enter preview mode.\n', 20);
            controlsText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            controlsText.size = 20;
    
    
            add(curText);
            add(formText);
            add(controlsText);
    
            curText.screenCenter(X);
        }

    function checkPreview()
        {
            if(previewMode)
                {
                    controlsText.text = "PREVIEW MODE\nPress I to play idle animation.\nPress your controls to play an animation.\n";
                }
            else {
                controlsText.text = "Press P to enter preview mode.\n";
                if(characterSprite.animOffsets.exists('idle'))
                    {
                        characterSprite.playAnim('idle');
                    }
            }
        }
    override function update(elapsed)
    {
        if(FlxG.keys.justPressed.P && selectionStart)
            {
                previewMode = !previewMode;
                checkPreview();
            }
        if(selectionStart && !previewMode)
            {
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
                if(controls.UI_DOWN_P)
                    {
                        changeForm(1);
                    }
                if(controls.UI_UP_P)
                    {
                        changeForm(-1);
                    }
                if(controls.ACCEPT)
                    {
                        acceptCharacter();
                    }
                    if (controls.BACK)
                        {
                            FlxG.sound.play(Paths.sound('cancelMenu'));
                            FlxG.sound.music.stop();
                            MusicBeatState.switchState(new FreeplaySelectState());
                        }
            }
            else if (!previewMode)
            {
                if(controls.UI_RIGHT_P)
                    {
                        curSelected += 1;
                    }
                if(controls.UI_LEFT_P)
                    {
                        curSelected =- 1;
                    }
                if (curSelected < 0)
                    {
                        curSelected = 0;
                    }
                    if (curSelected >= 2)
                    {
                        curSelected = 0;
                    }
                switch(curSelected)
                {
                    case 0:
                        yesText.alpha = 1;
                        noText.alpha = 0.5;
                    case 1:
                        noText.alpha = 1;
                        yesText.alpha = 0.5;
                }
                if(controls.ACCEPT)
                    {
                        switch(curSelected)
                        {
                            case 0:
                                FlxG.sound.music.stop();
                                LoadingState.loadAndSwitchState(new PlayState());
                            case 1:
                                noText.alpha = 0;
                                yesText.alpha = 0;
                                otherText.alpha = 0;
                                curSelected = 0;
                                spawnSelection();
                                
                        }
                    }
            }
            else
                {
                    if(controls.NOTE_LEFT_P)
                        {
                            if(characterSprite.animOffsets.exists('singLEFT'))
                                {
                                    characterSprite.playAnim('singLEFT');
                                }
                        }
                    if(controls.NOTE_DOWN_P)
                        {
                            if(characterSprite.animOffsets.exists('singDOWN'))
                                {
                                    characterSprite.playAnim('singDOWN');
                                }
                        }
                    if(controls.NOTE_UP_P)
                        {
                            if(characterSprite.animOffsets.exists('singUP'))
                                {
                                    characterSprite.playAnim('singUP');
                                }
                        }
                    if(controls.NOTE_RIGHT_P)
                        {
                            if(characterSprite.animOffsets.exists('singRIGHT'))
                                {
                                    characterSprite.playAnim('singRIGHT');
                                }
                        }
                    if(FlxG.keys.justPressed.I)
                        {
                            if(characterSprite.animOffsets.exists('idle'))
                                {
                                    characterSprite.playAnim('idle');
                                }
                        }
                }
        super.update(elapsed);
    }


    function changeSelection(change:Int) 
    {
        FlxG.sound.play(Paths.sound('scrollMenu'));
        curSelectedForm = 0;
        curSelected += change;

        if (curSelected < 0)
        {
			curSelected = characterData.length - 1;
        }
		if (curSelected >= characterData.length)
        {
			curSelected = 0;
        }
        curText.text = characterData[curSelected][0][0][0];
        characterFile = characterData[curSelected][0][0][1];
        reloadCharacter();

        curText.screenCenter(X);
    }

    function changeForm(change:Int) 
        {
            if(characterData[curSelected][0].length >= 2)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                curSelectedForm += change;
    
                if (curSelectedForm < 0)
                {
                    curSelectedForm = characterData[curSelected][0].length;
                    curSelectedForm = curSelectedForm - 1;
                }
                if (curSelectedForm >= characterData[curSelected][0].length)
                {
                    curSelectedForm = 0;
                }
                curText.text = characterData[curSelected][0][curSelectedForm][0];
                characterFile = characterData[curSelected][0][curSelectedForm][1];

                reloadCharacter();
        
                curText.screenCenter(X);
            }
        }

    function reloadCharacter()
        {
            characterSprite.destroy();
            characterSprite = new Boyfriend(0, 12, characterFile);
            add(characterSprite);
            characterSprite.dance();
            characterSprite.screenCenter(XY);
            characterSprite.y += 120;

            switch(characterFile)
            {
                case 'bf' | 'bf meni form' | 'D-bf':
                    characterSprite.screenCenter(XY);
                    characterSprite.y += 120;
                case 'kazashi-player' | 'kazashi nekoPLAYER' | 'kazashi impostorP':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -260;
                case 'zuki-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -260;
                case 'hinata-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -300;
                case 'menimatedP' | 'menimatedOlderP':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -230;
                case 'haruki player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -270;
                case 'hiroko-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -260;
                case 'dave-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -260;
                case 'bambi-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y += -280;
                    characterSprite.x += -100;
                case 'tristan-player' | 'tristan-golden-player':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -330;
                case 'smolshi-playable':
                    characterSprite.screenCenter(XY);
                    characterSprite.y -= -260;
            }
        }
    
    function acceptCharacter() 
    {
        if(!entering)
        {
        entering = true;
        if(characterSprite.animOffsets.exists('hey'))
            {
                characterSprite.playAnim('hey');
            }
        else if(characterSprite.animOffsets.exists('singUP'))
            {
                characterSprite.playAnim('singUP');
            }
        FlxG.sound.playMusic(Paths.music('characterselectConfirm'), 1);
        new FlxTimer().start(4, function(tmr:FlxTimer)
			{
                FlxG.sound.music.stop();
                PlayState.SONG.player1 = characterFile;
                LoadingState.loadAndSwitchState(new PlayState());
			});
        }
    }
}