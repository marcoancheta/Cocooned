
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- sound.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Require Global Variables
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local gameData = require("gameData")
local name

--------------------------------------------------------------------------------
-- Play Sounds
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local function playSound(event, name)
	audio.setVolume(0.1, {channel = 4} )
	local temp = audio.play(name, {channel=4, loops=0})
	print("play sound:", name)
end

local function pauseSound(event, name)
	audio.setVolume(0.1, {channel = 4} )
	local temp = audio.pause(name, {channel=4, loops=0})
	print("pause sound:", name)
end

local function playEventSound(event, name)
	audio.setVolume(0.4, {channel = 3} )
	local temp = audio.play(name, {channel=3, loops=0})
	print("play event sound:", name)
end

local function playBGM(event, name)
	audio.setVolume(.75, {channel = 2} )
	local temp = audio.play(name, {channel=2, loops=-1})
	print("play BGM:", name)
end

--------------------------------------------------------------------------------
-- Stop Sounds
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local function stopBGM(event, name)
	audio.dispose(name)
	audio.stop()
end

--------------------------------------------------------------------------------
-- Finish up -&- Load Sounds
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local sound = {
	soundOptions = soundOptions,
	BGMOptions = BGMOptions,
	playSound = playSound,
	pauseSound = pauseSound,
	playEventSound = playEventSound,
	playBGM = playBGM,
	stopBGM = stopBGM,
	
	-- channels:
	isChannel1Active = audio.isChannelActive(1),
	isChannel2Active = audio.isChannelActive(2),
	isChannel3Active = audio.isChannelActive(3),
	
	-- Load Sounds here:
	clickSound = audio.loadSound("sounds/menu_tone.wav"),
	mainmenuSound = audio.loadSound("sounds/cocoonedmusic.wav"),
	auraPickupSound = audio.loadSound("sounds/auraPickup.wav"), 
	gameSound = audio.loadSound("sounds/music.wav"), 
	orbPickupSound = audio.loadSound("sounds/orbPickup.wav"),
	portalOpeningSound = audio.loadSound("sounds/portalOpening.wav"),
	rollSnowSound = audio.loadSound("sounds/rollSnow.wav"),
	runePickupSound = audio.loadSound("sounds/runePickup.wav"),
	wallHitSound = audio.loadSound("sounds/wallHit.wav"),
	splashSound = audio.loadSound("sounds/splash.wav"),
	--totemSound = audio.loadSound("sounds/totem.wav")
	--selectMapSound = audio.loadSound('sounds/selectMap.wav')
}

return sound

-- end of sound.lua