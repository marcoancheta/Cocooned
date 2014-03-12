
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

audio.setVolume(0.1, {channel = 4} )
audio.setVolume(0.4, {channel = 3} )
audio.setVolume(.75, {channel = 2} )

--------------------------------------------------------------------------------
-- Play Sounds
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local function playSound(event, name)
	local isChannel4Playing = audio.isChannelPlaying( 4 )
	if isChannel4Playing then
		audio.stop( 4 )
	end
	local temp = audio.play(name, {channel = 4, 
									 loops = 0, 
								onComplete = function() audio.dispose(name)
									end })
	print("play sound:", name)
end

local function pauseSound(event, name)
	local temp = audio.pause(name, {channel=4, loops=0})
	print("pause sound:", name)
end

local function playEventSound(event, name)
	local isChannel3Playing = audio.isChannelPlaying( 3 )
	if isChannel3Playing then
		audio.stop( 3 )
		print("Stop 3")
	end
	local temp = audio.play(name, {channel = availableChannel, 
								onComplete = function() audio.dispose(name)
									end })
	print("play event sound:", name)
end

local function playBGM(event, name)
	local temp = audio.play(name, {channel=2, loops=-1})
	print("play BGM:", name)
end

--------------------------------------------------------------------------------
-- Stop Sounds
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local function stop(event, name, value)
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
	stop = stop,
		
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