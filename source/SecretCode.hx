package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import haxe.Exception;
using StringTools;
import flixel.util.FlxTimer;
import flixel.addons.ui.FlxInputText;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxSubState;
import flixel.util.FlxSave;
import openfl.Assets;

class SecretCode extends MusicBeatState
{
	public var codeInput:FlxInputText;
	var badSymbol:FlxText;
	var talk:FlxText;
	public var camCode:FlxCamera;
	var chromeOffset:Float = ((2 - ((0.5 / 0.5))));
	var cando = true;
	var expunged:FlxSprite;
	
	override function create()
	{

		super.create();
		
		camCode = new FlxCamera();
		FlxG.cameras.add(camCode);
		
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('computer'));
		menuBG.screenCenter();
		add(menuBG);

		FlxG.mouse.visible = true;

		if (!FlxG.sound.music.playing)
		{	
			FlxG.sound.playMusic(Paths.music('computer'), 0.7);
			FlxG.sound.music.fadeIn(1, 0, 1);
        	FlxG.sound.music.time = 0;
			Conductor.changeBPM(102);
		}
		
		
		codeInput = new FlxInputText(0, 0, FlxG.width, 32);
		codeInput.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLACK, FlxTextAlign.CENTER);
		codeInput.screenCenter(Y);
		codeInput.cameras = [camCode];
		codeInput.hasFocus = true;
		add(codeInput);
		codeInput.callback = function(text, action){
			if (action == 'enter')
			{
				if(controls.ACCEPT && cando) {
					FlxG.sound.play(Paths.sound('keyENTER'));
					cando = false;
					switch(text.toLowerCase())
					{
						case 'zongko':
							PlayState.SONG = Song.loadFromJson('what-hard', 'what');
							PlayState.isStoryMode = false;
			                PlayState.storyDifficulty = 0;
			                LoadingState.loadAndSwitchState(new PlayState());
							FlxG.sound.music.stop();
							ClientPrefs.smolshi = true;
			                ClientPrefs.saveSettings();
							ClientPrefs.zongko = true;
			                ClientPrefs.saveSettings();
						case 'smolshi':
							PlayState.SONG = Song.loadFromJson('kawa-nyaa-hard', 'kawa-nyaa');
							PlayState.isStoryMode = false;
			                PlayState.storyDifficulty = 0;
			                LoadingState.loadAndSwitchState(new PlayState());
							FlxG.sound.music.stop();
							ClientPrefs.smolshi = true;
			                ClientPrefs.saveSettings();
						case 'expunged.exe':
							speak();
						    talk = new FlxText(0, 0, 0, "Searching...", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.music.fadeOut(3, 0);
						    new FlxTimer().start(5, function(tmr:FlxTimer) {
								MusicBeatState.switchState(new IntroStateH());
								FlxG.sound.music.stop();
							});
							new FlxTimer().start(4, function(tmr:FlxTimer) {
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
							});
						case 'vine boom':
							FlxG.sound.play(Paths.sound('vineboom'));
						
						
						case 'cheats.dll':						    						    
						    					    
						    
							if(ClientPrefs.cheatersneverwin)
							{
							FlxG.sound.play(Paths.soundRandom('badnoise', 1, 3));
		                    FlxG.camera.shake(0.015, 0.3);
						    } else {
							speak();
						    talk = new FlxText(0, 0, 0, "Loading...", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							new FlxTimer().start(5, function(tmr:FlxTimer) {
						    FlxG.camera.shake(0.015, 3, function() 
							{
							});
							FlxG.camera.fade(FlxColor.WHITE, 2, false, function() 
								{
								});
							FlxG.sound.music.stop();
							FlxG.sound.play(Paths.sound('cheating'));
							FlxG.cameras.remove(camCode);
							new FlxTimer().start(2, function(tmr:FlxTimer)          
				            {								
								FlxG.camera.fade(FlxColor.BLACK, 0.1, false, function() {
								});
								new FlxTimer().start(3, function(tmr:FlxTimer)          
								{
								PlayState.SONG = Song.loadFromJson('Cheaters-never-win-hard', 'Cheaters-never-win');
			                    PlayState.isStoryMode = false;
			                    PlayState.storyDifficulty = 0;
			                    LoadingState.loadAndSwitchState(new PlayState());								
							    });
								ClientPrefs.cheatersneverwin = true;
				                ClientPrefs.saveSettings();
				            });
							});	
							}
						
						case 'you know who else made dave and bambi fan mod?':
							FlxG.sound.play(Paths.sound('mymom'));
						case 'calling dave':
							FlxG.sound.play(Paths.sound('messageDave'));
						case 'calling xara':
							FlxG.sound.play(Paths.sound('xara'));
						case 'calling himari':
							FlxG.sound.play(Paths.sound('messageHimari'));
						case 'calling zuki':
							FlxG.sound.play(Paths.sound('messageZuki'));
						case 'calling meni':
							FlxG.sound.play(Paths.sound('messageMeni'));
						case 'calling kazashi':
							FlxG.sound.play(Paths.sound('messageKazashi'));
						case 'calling haruki':
							FlxG.sound.play(Paths.sound('messageHaruki'));
						case 'calling hinata':
							FlxG.sound.play(Paths.sound('messageHinata'));
						case 'calling bambi':
							if(ClientPrefs.prankcaller)
							{
						    FlxG.sound.play(Paths.sound('messageBambi'));
						    } else {
							FlxG.sound.play(Paths.sound('prankcall'));
							new FlxTimer().start(16, function(tmr:FlxTimer)          
									{
							PlayState.SONG = Song.loadFromJson('prank-caller-hard', 'prank-caller');
			                PlayState.isStoryMode = false;
			                PlayState.storyDifficulty = 0;
			                LoadingState.loadAndSwitchState(new PlayState());
							FlxG.sound.music.stop();
							ClientPrefs.prankcaller = true;
				                ClientPrefs.saveSettings();
						    });
						}
						case 'can you speak chinese':
							FlxG.sound.play(Paths.sound('chinese'));
						case 'bruh':
							FlxG.sound.play(Paths.sound('bruh'));
						case 'joke songs':
							speak();
						    talk = new FlxText(0, 0, 0, "TRIGGER WARNING:
							EARRAPE!!!", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.RED);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							new FlxTimer().start(5, function(tmr:FlxTimer) {
								MusicBeatState.switchState(new FreeplayJokeState());
								FlxG.sound.music.stop();
							});
						case 'friday night funkin':
							if(ClientPrefs.debug)
							{
						    MusicBeatState.switchState(new TitleStateOriginal());
							FlxG.sound.music.stop();
							} else {
							speak();
						    talk = new FlxText(0, 0, 0, "Please turn on debug mode before entering.", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							}
						case 'asmr':
							PlayState.SONG = Song.loadFromJson('asmr-hard', 'asmr');
			                PlayState.isStoryMode = false;
			                PlayState.storyDifficulty = 0;
			                LoadingState.loadAndSwitchState(new PlayState());
							FlxG.sound.music.stop();
						case 'neko neko':
							FlxG.sound.play(Paths.sound('pixelstart'));
							FlxG.cameras.remove(camCode);
						    FlxG.sound.music.stop();
						    FlxG.camera.fade(FlxColor.BLACK, 0.1, false, function() {
							});
						    new FlxTimer().start(2, function(tmr:FlxTimer)          
							{	
								FlxG.switchState(new SmolshiState());
						});
						case 'can you work on my fnf mod?':
							speak();
						    talk = new FlxText(0, 0, 0, "No", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'kys':
							speak();
						    talk = new FlxText(0, 0, 0, "Ratio", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'you suck':
							speak();
						    talk = new FlxText(0, 0, 0, "How rude >:(", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'you ugly':
							speak();
						    talk = new FlxText(0, 0, 0, "cry about it", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'zuki plays among us':
							speak();
						    talk = new FlxText(0, 0, 0, "Damn, Zuki kinda zuz", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.ORANGE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.play(Paths.sound('amogus'));
						case 'activate debug mode':
							speak();
						    talk = new FlxText(0, 0, 0, "Debug mode activated!", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.LIME);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.play(Paths.sound('confirmMenu'));
							ClientPrefs.debug = true;
				            ClientPrefs.saveSettings();
						case 'deactivate debug mode':
							speak();
						    talk = new FlxText(0, 0, 0, "Debug mode deactivated", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.RED);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.play(Paths.sound('cancelMenu'));
							ClientPrefs.debug = false;
							ClientPrefs.saveSettings();
							ClientPrefs.gameplaySettings = [
								'scrollspeed' => 1.0,
								'scrolltype' => 'multiplicative', 
								'songspeed' => 1.0,
								'healthgain' => 1.0,
								'healthloss' => 1.0,
								'instakill' => false,
								'practice' => false,
								'botplay' => false,
								'opponentplay' => false,
								'noMiss' => false
							];
							ClientPrefs.saveSettings();
						case 'a mimir':
							speak();
						    talk = new FlxText(0, 0, 0, "Bro you look tired. But okay?", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							CoolUtil.browserLoad('https://www.youtube.com/watch?v=jDgMkHB1pEI');
						case 'can you do chapter 4?':
							speak();
						    talk = new FlxText(0, 0, 0, "Nah, I'm good", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'yo is that saster':
							speak();
						    talk = new FlxText(0, 0, 0, "Hi guys. I'm Saster", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'lmao':
							speak();
						    talk = new FlxText(0, 0, 0, "Shut up.", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
						case 'metal gear':
							speak();
						    talk = new FlxText(0, 0, 0, "Metal Gear Rising: Revengance - it's not a word in a dictionary. It's also one of my favourite games.", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.play(Paths.sound('metalgear'));
						case 'breaking table':
							speak();
						    talk = new FlxText(0, 0, 0, "Why would you do that!?", 32);
    	                    talk.setFormat("VCR OSD Mono", 36, FlxColor.WHITE);
    	                    talk.screenCenter();
    	                    talk.y += 100;
							FlxG.sound.play(Paths.sound('brick'));
						default:
							badcode();
					}
					new FlxTimer().start(0.1, function(tmr:FlxTimer) {
						cando = true;
					});
				}
			}
		}
		
    	badSymbol = new FlxText(0, 0, 0, "The code you entered is incorrect.", 32);
    	badSymbol.setFormat("VCR OSD Mono", 36, FlxColor.RED);
    	badSymbol.screenCenter();
    	badSymbol.y += 100;
	}
	
	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.sound.play(Paths.soundRandom('key_', 1, 4));
		}
		else if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new FreeplaySelectState());
			FlxG.sound.music.stop();
		}
		if (FlxG.keys.justPressed.ANY)
		{
			FlxG.sound.play(Paths.soundRandom('key_', 1, 4));
		}
	}
	
	function badcode() {
		new FlxTimer().start(0.1, function(tmr:FlxTimer) {
			add(badSymbol);
			new FlxTimer().start(5, function(tmr:FlxTimer) {
				remove(badSymbol);
			});
		});
	}

	function speak() {
		new FlxTimer().start(0.1, function(tmr:FlxTimer) {
			add(talk);
			new FlxTimer().start(5, function(tmr:FlxTimer) {
				remove(talk);
			});
		});
	}

}