package;

#if desktop
import Discord.DiscordClient;
#end
#if cpp
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.system.scaleModes.BaseScaleMode;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.StageSizeScaleMode;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
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
import flixel.math.FlxMath;
import lime.app.Application;
import openfl.Assets;

using StringTools;
typedef TitleData =
{
	
	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
	bpm:Int
}
class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var logoSpr:FlxSprite;
	var bfSpr:FlxSprite;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	#if TITLE_SCREEN_EASTER_EGG
	var easterEggKeys:Array<String> = [
		'SHADOW', 'RIVER', 'SHUBS', 'BBPANZU'
	];
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var easterEggKeysBuffer:String = '';
	#end

	var mustUpdate:Bool = false;
	public var defaultCamZoom:Float = 1;
	var titleJSON:TitleData;
	
	public static var updateVersion:String = '';

	var candance:Bool = true;

	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();
		
		//trace(path, FileSystem.exists(path));

		/*#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}
		#end*/
		
		#if CHECK_FOR_UPDATES
		if(!closedState) {
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/ShadowMario/FNF-PsychEngine/main/gitVersion.txt");
			
			http.onData = function (data:String)
			{
				updateVersion = data.split('\n')[0].trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if(updateVersion != curVersion) {
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}
			
			http.onError = function (error) {
				trace('error: $error');
			}
			
			http.request();
		}
		#end

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');
		
		ClientPrefs.loadPrefs();
		
		Highscore.load();

		// IGNORE THIS!!!
		titleJSON = Json.parse(Paths.getTextFromFile('images/gfDanceTitle.json'));
		
		#if TITLE_SCREEN_EASTER_EGG
		if (FlxG.save.data.psychDevsEasterEgg == null) FlxG.save.data.psychDevsEasterEgg = ''; //Crash prevention
		switch(FlxG.save.data.psychDevsEasterEgg.toUpperCase())
		{
			case 'SHADOW':
				titleJSON.gfx += 210;
				titleJSON.gfy += 40;
			case 'RIVER':
				titleJSON.gfx += 100;
				titleJSON.gfy += 20;
			case 'SHUBS':
				titleJSON.gfx += 160;
				titleJSON.gfy -= 10;
			case 'BBPANZU':
				titleJSON.gfx += 45;
				titleJSON.gfy += 100;
		}
		#end

		if(!initialized && FlxG.save.data != null && FlxG.save.data.fullscreen)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
			//trace('LOADED FULLSCREEN SETTING!!');
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(ClientPrefs.expunged) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new HTitleState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized)
			{
				DiscordClient.initialize();
				Application.current.onExit.add (function (exitCode) {
					DiscordClient.shutdown();
				});
			}
			#end

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				startIntro();
			});
		}
		#end
		if (!candance)
			candance = true;
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var backdrop:FlxBackdrop;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

	function startIntro()
	{
		if (!initialized)
		{
			/*var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
				
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;*/

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('openingsong'));
			// FlxG.sound.list.add(music);
			// music.play();

			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('openingsong'), 0.8);

				//FlxG.sound.music.fadeIn(1, 0, 0.8);
			}
		}

		//Conductor.changeBPM(titleJSON.bpm);
		Conductor.changeBPM(148);
		persistentUpdate = true;
		var bg:FlxSprite = new FlxSprite();
		
		if (titleJSON.backgroundSprite != null && titleJSON.backgroundSprite.length > 0 && titleJSON.backgroundSprite != "none")
		{
			bg.loadGraphic(Paths.image(titleJSON.backgroundSprite));
			add(bg);
		}
		else
		{
			// bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			
			var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('kazashiBg'));
		menuBG.screenCenter();
		add(menuBG);
			
			backdrop = new FlxBackdrop(Paths.image('yeyu'));
			backdrop.velocity.set(-40, -40);
			backdrop.antialiasing = ClientPrefs.globalAntialiasing;
			add(backdrop);

			
		}

		logoBl = new FlxSprite(titleJSON.titlex, titleJSON.titley);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
	
        #if (desktop && MODS_ALLOWED)
		var path = "mods/" + Paths.currentModDirectory + "/images/logoBumpin.png";
		// trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path))
		{
			path = "mods/images/logoBumpin.png";
		}
		// trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path))
		{
			path = "assets/images/logoBumpin.png";
		}
		// trace(path, FileSystem.exists(path));
		logoBl.frames = FlxAtlasFrames.fromSparrow(BitmapData.fromFile(path), File.getContent(StringTools.replace(path, ".png", ".xml")));
		#else
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		#end
		
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.setGraphicSize(Std.int(logoBl.width * 0.9));
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logoBl.alpha = 0;
		logoBl.angle = 0;
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		FlxTween.tween(logoBl, {
			y: logoBl.y + -120,
			x: logoBl.x + 0,
			angle: 0,
			alpha: 1
		}, 1.4, {ease: FlxEase.expoInOut});
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		swagShader = new ColorSwap();
		gfDance = new FlxSprite(titleJSON.gfx, titleJSON.gfy);

		#if (desktop && MODS_ALLOWED)
		var path = "mods/" + Paths.currentModDirectory + "/images/GF_assets.png";
		// trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path))
		{
			path = "mods/images/GF_assets.png";
			// trace(path, FileSystem.exists(path));
		}
		if (!FileSystem.exists(path))
		{
			path = "assets/images/GF_assets.png";
			// trace(path, FileSystem.exists(path));
		}
		gfDance.frames = FlxAtlasFrames.fromSparrow(BitmapData.fromFile(path), File.getContent(StringTools.replace(path, ".png", ".xml")));
		#else
		gfDance.frames = Paths.getSparrowAtlas('GF_assets');
		#end
		gfDance.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.animation.addByPrefix('Hey', 'GF Cheer', 24, false);
		gfDance.antialiasing = ClientPrefs.globalAntialiasing;
		add(gfDance);
		gfDance.shader = swagShader.shader;
		add(logoBl);
		// logoBl.shader = swagShader.shader;

		var eBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('hei'));
		    eBG.screenCenter();
		    add(eBG);

		titleText = new FlxSprite(titleJSON.startx, titleJSON.starty);
		#if (desktop && MODS_ALLOWED)
		var path = "mods/" + Paths.currentModDirectory + "/images/titleEnter.png";
		//trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path)){
			path = "mods/images/titleEnter.png";
		}
		//trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path)){
			path = "assets/images/titleEnter.png";
		}
		//trace(path, FileSystem.exists(path));
		titleText.frames = FlxAtlasFrames.fromSparrow(BitmapData.fromFile(path),File.getContent(StringTools.replace(path,".png",".xml")));
		#else
		
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		#end
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.32).loadGraphic(Paths.image('team'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.3));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = ClientPrefs.globalAntialiasing;

		bfSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(bfSpr);
		bfSpr.visible = false;
		bfSpr.setGraphicSize(Std.int(bfSpr.width * 0.8));
		bfSpr.updateHitbox();
		bfSpr.screenCenter(X);
		bfSpr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText2'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		// EASTER EGG

		if (!transitioning && skippedIntro)
		{
			if (pressedEnter)
			{
				if (titleText != null)
					titleText.animation.play('press');

				FlxG.camera.flash(FlxColor.WHITE, 1);
				FlxG.sound.play(Paths.sound('startTitle'), 0.7);
				FlxTween.tween(logoBl, {y: -1500, angle: 10, alpha: 0}, 2, {ease: FlxEase.elasticInOut});
				FlxTween.tween(gfDance, {x: 1500}, 2.0, {ease: FlxEase.backInOut});
				FlxTween.tween(titleText, {y: 1500}, 3.7, {ease: FlxEase.expoInOut});

				transitioning = true;
				FlxG.sound.music == null;  

				gfDance.animation.play('Hey');
				candance = false;
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					if (FlxG.save.data.welcome) {
					MusicBeatState.switchState(new ContinueState());
					}else{
					MusicBeatState.switchState(new MessageState());
					FlxG.sound.music.fadeOut(0.5, 0);
                    }
					closedState = true;
				});
				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
			#if TITLE_SCREEN_EASTER_EGG
			else if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
			{
				var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
				var keyName:String = Std.string(keyPressed);
				if(allowedKeys.contains(keyName)) {
					easterEggKeysBuffer += keyName;
					if(easterEggKeysBuffer.length >= 32) easterEggKeysBuffer = easterEggKeysBuffer.substring(1);
					//trace('Test! Allowed Key pressed!!! Buffer: ' + easterEggKeysBuffer);

					for (wordRaw in easterEggKeys)
					{
						var word:String = wordRaw.toUpperCase(); //just for being sure you're doing it right
						if (easterEggKeysBuffer.contains(word))
						{
							//trace('YOOO! ' + word);
							if (FlxG.save.data.psychDevsEasterEgg == word)
								FlxG.save.data.psychDevsEasterEgg = '';
							else
								FlxG.save.data.psychDevsEasterEgg = word;
							FlxG.save.flush();

							FlxG.sound.play(Paths.sound('ToggleJingle'));

							var black:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
							black.alpha = 0;
							add(black);

							FlxTween.tween(black, {alpha: 1}, 1, {onComplete:
								function(twn:FlxTween) {
									FlxTransitionableState.skipNextTransIn = true;
									FlxTransitionableState.skipNextTransOut = true;
									MusicBeatState.switchState(new TitleState());
								}
							});
							FlxG.sound.music.fadeOut();
							closedState = true;
							transitioning = true;
							playJingle = true;
							easterEggKeysBuffer = '';
							break;
						}
					}
				}
			}
			#end
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
		{
			for (i in 0...textArray.length)
			{
				var money:FlxText = new FlxText(0, 0, FlxG.width, textArray[i], 48);
				money.setFormat("MochiyPopOne-Regular.ttf", 48, FlxColor.WHITE, CENTER);
				money.screenCenter(X);
				money.y += (i * 60) + 200 + offset;
				credGroup.add(money);
				textGroup.add(money);
			}
		}
	
		function addMoreText(text:String, ?offset:Float = 0)
		{
			var coolText:FlxText = new FlxText(0, 0, FlxG.width, text, 48);
			coolText.setFormat("MochiyPopOne-Regular.ttf", 48, FlxColor.WHITE, CENTER);
			coolText.screenCenter(X);
			coolText.y += (textGroup.length * 60) + 200 + offset;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(logoBl != null) 
			logoBl.animation.play('bump', true);

		if (candance)
			{
				if (gfDance != null)
				{
					danceLeft = !danceLeft;
	
					if (danceLeft)
						gfDance.animation.play('danceRight');
					else
						gfDance.animation.play('danceLeft');
				}
			}

		if(!closedState) {
			//sickBeats++;
			switch (curBeat)
			{
					case 0:
						createCoolText(['So'], 15);
					case 1:
						deleteCoolText();
						createCoolText(['Looks like'], 15);
					case 2:
						addMoreText('The Cutest Update', 15);
					case 3:
						addMoreText('is HERE', 15);
					case 4:
						addMoreText('LETS GOOOOO', 15);
					case 5:
						deleteCoolText();
						addMoreText('Special Thanks to', 15);
					case 6:
						addMoreText('Everyone', 15);
					case 7:
						addMoreText('Including you', 15);
					case 8:
						deleteCoolText();
						createCoolText(['From the creators of'], 15);
					case 9:
						addMoreText('Mr. Driller Funkin', 15);
					case 10:
						addMoreText('VS Menimated (Pre-alpha)', 15);
					case 11:
						addMoreText('Siblingangs Begins', 15);
					case 12:
						deleteCoolText();
						createCoolText(['This'], -90);
					case 13:
						deleteCoolText();
						createCoolText(['This mod'], -90);
					case 14:
						deleteCoolText();
						createCoolText(['This mod was created'], -90);
					case 15:
						addMoreText('by', -90);
						addMoreText('This man who keep his mask on', -90);
						ngSpr.visible = true;
					case 16:
						deleteCoolText();
						ngSpr.visible = false;
						createCoolText(['Made with'], 15);
					case 17:
						addMoreText('Siblingangs Engine', 15);
					case 18:
						addMoreText('(Modified Psych Engine)', 15);
					case 19:
						deleteCoolText();
						createCoolText(['This brought you by'], 15);	
					case 20:
						addMoreText('Menimated', 15);	
						addMoreText('ChampionKnightEX', 15);
						addMoreText('StubyLegs2k5,', 15);
						addMoreText('Xara,', 15);
					case 21:
						deleteCoolText();
						createCoolText(['This brought you by'], 15);	
						addMoreText('Akani', 15);
						addMoreText('KillerAvecRage', 15);
					case 22:
						deleteCoolText();
						createCoolText(['This brought you by'], 15);	
					    addMoreText('mom gaming', 15);
						addMoreText('KillerAvecRage', 15);
						addMoreText('OmegaDragon', 15);
					case 23:
						deleteCoolText();
						createCoolText(['Siblingangs Team'], 15);
						addMoreText('Presents', 15);
						
					case 24:
						addMoreText('UwU', 15);
						
					case 25:
						deleteCoolText();
						bfSpr.visible = false;
						addMoreText(curWacky[0]);
						
					case 26:
						addMoreText(curWacky[1]);
					case 27:
						deleteCoolText();
						createCoolText(['Friday'], 15);
						
					case 28:
						deleteCoolText();
						createCoolText(['Friday Night'], 15);
						
					case 29:
						FlxG.camera.zoom+=0.05;
					    deleteCoolText();
						createCoolText(["Friday Night Funkin'"], 15);
						
					case 30:
						FlxG.camera.zoom+=0.10;
					    addMoreText('Siblingangs Begins', 15);
					case 31:
						FlxG.camera.zoom+=0.20;
						addMoreText('+ VS Menimated', 15);
						
						
					case 32:
							deleteCoolText();
                            
							skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			Conductor.changeBPM(148);
			remove(logoSpr);
			gfDance.x += 900;
			FlxTween.tween(gfDance, {x: gfDance.x - 900}, 2.5, {
				ease: FlxEase.circInOut});

			logoBl.x -= 900;
			FlxTween.tween(logoBl, {x: logoBl.x+ 900}, 1.0, {
				ease: FlxEase.backOut});

			
			FlxG.camera.flash(FlxColor.WHITE, 1);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
