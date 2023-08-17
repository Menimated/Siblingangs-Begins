package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<FlxText>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Continue', 'Restart Song', 'Options', 'Exit'];
	var difficultyChoices = [];
	var curSelected:Int = 0;

	var pausebg:FlxSprite;
	var pausebg1:FlxSprite;
	var iconBG:FlxSprite;
	var icon:HealthIcon;
	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);
	public static var wasinsongbeforethenwenttooptions:Bool;
	//var botplayText:FlxText;

	public static var songName:String = '';

	public function new(x:Float, y:Float)
	{
		super();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!

		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
			menuItemsOG.insert(6 + num, 'Toggle No miss');
		}
		menuItems = menuItemsOG;

		if(ClientPrefs.expunged)
			{
		FlxG.sound.play(Paths.sound("pauseExpunged"));
			} else {
		FlxG.sound.play(Paths.sound("pause"));
			}

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');


		if(ClientPrefs.expunged)
		{
		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 0)));
		} else {
		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
	    }

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		if (!ClientPrefs.lowQuality)
		{
			pausebg = new FlxSprite().loadGraphic(Paths.image('pausemenubg'));
			pausebg.color = 0xFF1E1E1E;
			pausebg.scrollFactor.set();
			pausebg.updateHitbox();
			pausebg.screenCenter();
			pausebg.antialiasing = ClientPrefs.globalAntialiasing;
			add(pausebg);
			pausebg.x += 200;
			pausebg.y -= 200;
			pausebg.alpha = 0;
			FlxTween.tween(pausebg, {
				x: 0,
				y: 0,
				alpha: 1
			}, 1, {ease: FlxEase.quadOut});

			pausebg1 = new FlxSprite().loadGraphic(Paths.image('iconbackground'));
			pausebg1.color = 0xFF141414;
			pausebg1.scrollFactor.set();
			pausebg1.updateHitbox();
			pausebg1.screenCenter();
			pausebg1.antialiasing = ClientPrefs.globalAntialiasing;
			add(pausebg1);
			pausebg1.x -= 150;
			pausebg1.y += 150;
			pausebg1.alpha = 0;
			FlxTween.tween(pausebg1, {
				x: 0,
				y: 0,
				alpha: 1
			}, 0.9, {ease: FlxEase.quadOut});

			iconBG = new FlxSprite().loadGraphic(Paths.image('iconbackground'));
			iconBG.flipX = true;
			iconBG.color = FlxColor.fromRGB(PlayState.instance.dad.healthColorArray[0], PlayState.instance.dad.healthColorArray[1],
			PlayState.instance.dad.healthColorArray[2]);
			iconBG.scrollFactor.set();
			iconBG.updateHitbox();
			iconBG.screenCenter();
			iconBG.antialiasing = ClientPrefs.globalAntialiasing;
			add(iconBG);
			iconBG.x += 100;
			iconBG.y += 100;
			iconBG.alpha = 0;
			FlxTween.tween(iconBG, {
				x: 0,
				y: 0,
				alpha: 1
			}, 0.8, {ease: FlxEase.quadOut});

			icon = new HealthIcon(PlayState.instance.dad.healthIcon);
			icon.setGraphicSize(Std.int(icon.width * 1.7));
			icon.antialiasing = ClientPrefs.globalAntialiasing;
			icon.x = FlxG.width - 230;
			icon.y = FlxG.height - 180;
			icon.flipX = true;
			icon.scrollFactor.set();
			icon.updateHitbox();
			add(icon);
			icon.x += 150;
			icon.y += 150;
			icon.alpha = 0;
			FlxTween.tween(icon, {
				x: icon.x - 150,
				y: icon.y - 150,
				alpha: 1
			}, 0.8, {ease: FlxEase.quadOut});
		}

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 64, 0, "", 32);
		if(ClientPrefs.expunged)
		{
		blueballedTxt.text = "YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE 
		YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE YOU CANNOT ESCAPE ";
	    } else {
		blueballedTxt.text = "Blueballed: " + PlayState.deathCounter;
		}
		blueballedTxt.scrollFactor.set();
		if(ClientPrefs.expunged)
		{
		blueballedTxt.setFormat(Paths.font('nope'), 32);
	    } else {
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		}
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		blueballedTxt.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});

		grpMenuShit = new FlxTypedGroup<FlxText>();
		add(grpMenuShit);

		regenMenu();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	override function update(elapsed:Float)
	{
		if(ClientPrefs.expunged)
		{
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.0)
			pauseMusic.volume += 0.00 * elapsed;
	    } else {
        cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;
	    }

		super.update(elapsed);
		updateSkipTextStuff();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		var daSelected:String = menuItems[curSelected];
		switch (daSelected)
		{
			case 'Skip Time':
				if (controls.UI_LEFT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime += 1000;
					holdTime = 0;
				}

				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					holdTime += elapsed;
					if(holdTime > 0.5)
					{
						curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
					}

					if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
					else if(curTime < 0) curTime += FlxG.sound.music.length;
					updateSkipTimeText();
				}
		}

		if (accepted && (cantUnpause <= 0 || !ClientPrefs.controllerMode))
		{
			if(ClientPrefs.expunged)
			{
			FlxG.sound.play(Paths.sound('nothing'));
			} else {
			FlxG.sound.play(Paths.sound('confirmMenu'));
			}
			
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					PlayState.SONG = Song.loadFromJson(poop, name);
					PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					PlayState.changedDifficulty = true;
					PlayState.chartingMode = false;
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Continue":
					close();
				case 'Change Difficulty':
					menuItems = difficultyChoices;
					deleteSkipTimeText();
					regenMenu();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
				case "Restart Song":
					if(ClientPrefs.expunged)
						{
						PlatformUtil.sendFakeMsgBox("YOU CAN'T");
						} else {
				    restartSong();
						}
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					if(curTime < Conductor.songPosition)
					{
						PlayState.startOnTime = curTime;
						restartSong(true);
					}
					else
					{
						if (curTime != Conductor.songPosition)
						{
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case "End Song":
					close();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case 'Toggle No miss':
					PlayState.instance.noMiss = !PlayState.instance.noMiss;
					PlayState.changedDifficulty = true;
					PlayState.instance.noMiss;
				case 'Options':
					if(ClientPrefs.expunged)
					{
					PlatformUtil.sendFakeMsgBox("YOU'RE NOT GOING ANYWHERE");
					} else {
				    wasinsongbeforethenwenttooptions = true;
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					MusicBeatState.switchState(new options.OptionsState2());
					FlxG.sound.playMusic(Paths.music('optionsSong'));
					}
				case "Exit":
					if(ClientPrefs.expunged)
					{
					PlatformUtil.sendFakeMsgBox("YOU'RE NOT GOING ANYWHERE");
					} else {
				    PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;

					WeekData.loadTheFirstEnabledMod();
					if(PlayState.isStoryMode) {
						if(ClientPrefs.unlockNow) {
							MusicBeatState.switchState(new GameState());						
						} else {
							MusicBeatState.switchState(new WeekSelectState());
						}
					} else {
						MusicBeatState.switchState(new FreeplaySelectState());
					}
					PlayState.cancelMusicFadeTween();
					FlxG.sound.music.stop();
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
				}
			}
		}
	}

	function deleteSkipTimeText()
	{
		if(skipTimeText != null)
		{
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if(ClientPrefs.expunged)
		{
		FlxG.sound.play(Paths.sound('scrollMenuH'), 0.4);
		} else {
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;
		var alpha:Int = 0;

		for (item in grpMenuShit.members)
		{
			alpha = bullShit - curSelected;
			bullShit++;

			item.color = FlxColor.fromRGBFloat(0.75, 0.75, 0.75);
			if (alpha == 0)
			{
				item.color = FlxColor.WHITE;
			}
		}
	}

	function regenMenu()
	{
		while (grpMenuShit.members.length > 0)
		{
			grpMenuShit.remove(grpMenuShit.members[0], true);
		}

		for (i in 0...menuItems.length)
		{
			var songText:FlxText = new FlxText(60, 60 + (50 * i), 0, menuItems[i], 36);
			songText.setFormat(Paths.font('vcr.ttf'), 36, FlxColor.WHITE, LEFT);
			grpMenuShit.add(songText);

			if(menuItems[i] == 'Skip Time')
			{
				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}
	
	function updateSkipTextStuff()
	{
		if(skipTimeText == null || skipTimeTracker == null) return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
