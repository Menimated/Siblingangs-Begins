local xx = 460;
local yy = 460;
local xx2 = 850;
local yy2 = 520;
local ofs = 25;
local ofs2 = 25;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
	-- with addLuaSprite, the farther up it is on the script is how far back it is in layers
	luaDebugMode = true

	makeLuaSprite('SunkWall', 'Milk/SunkBG', -700, -300);

	addLuaSprite('SunkWall', false)

end