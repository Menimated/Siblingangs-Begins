# Friday Night Funkin' - Siblingangs Begins! + VS Menimated
Siblingangs Engine (a modified version of Psych Engine) has made lots of new improvements, including
- Character Selecter
- Delete Save data
- Psych UI and Kade UI
- Continue menu when you load your save data

# So how can you unlock debug mode?
It's simple! Simply enter "activate debug mode" in the Secret code field while in Freeplay mode.
Oh wait, Freeplay mode has been locked and you can't access it. Instead, YOU MUST COMPLETE THE STORY MODE!

## Installation:
You must have [the most up-to-date version of Haxe](https://haxe.org/download/), seriously, stop using 4.1.5, it misses some stuff.

Follow a Friday Night Funkin' source code compilation tutorial, after this you will need to install LuaJIT.

To install LuaJIT do this: `haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit` on a Command prompt/PowerShell

...Or if you don't want your mod to be able to run .lua scripts, delete the "LUA_ALLOWED" line on Project.xml


If you get an error about StatePointer when using Lua, run `haxelib remove linc_luajit` into Command Prompt/PowerShell, then re-install linc_luajit.

If you want video support on your mod, simply do `haxelib install hxCodec` on a Command prompt/PowerShell

otherwise, you can delete the "VIDEOS_ALLOWED" Line on Project.xml

## Credits:
* Menimated - Main Programmer, Artist, Composer, Charter
* ChampionKnightEX - Zuki voice actor
* OmegaDragon3552 - Icon artist and Charter
* Killer Avec Rage - Charter
* StubyLegs2k5 - Haruki Voice actor
* Akani - Kazashi Voice actor
* Xara - Hinata Voice actor
* mom gaming - Charter

### Special Thanks
* MoldyGH - Creator of VS Dave and Bambi
* Shadow Mario - Psych Engine
