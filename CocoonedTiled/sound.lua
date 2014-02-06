
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- sound.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Require Global Variables
--------------------------------------------------------------------------------
local gameData = require("gameData")
local name

--------------------------------------------------------------------------------
-- Play Sounds
--------------------------------------------------------------------------------
function playSound(event, name)
	audio.setVolume(0.1, {channel = 4} )
	local temp = audio.play(name, {channel=4, loops=0})
	print("play sound:", name)
end

function playEventSound(event, name)
	audio.setVolume(0.4, {channel = 3} )
	local temp = audio.play(name, {channel=3, loops=0})
	print("play event sound:", name)
end

function playBGM(event, name)
	audio.setVolume(.75, {channel = 2} )
	local temp = audio.play(name, {channel=2, loops=-1})
	print("play BGM:", name)
end

--------------------------------------------------------------------------------
-- Stop Sounds
--------------------------------------------------------------------------------
function stopBGM(event)
	audio.stop()
end

--------------------------------------------------------------------------------
-- Finish up -&- Load Sounds
--------------------------------------------------------------------------------
local sound = {
	soundOptions = soundOptions,
	BGMOptions = BGMOptions,
	playSound = playSound,
	playEventSound = playEventSound,
	playBGM = playBGM,
	stopBGM = stopBGM,
	
	-- channels:
	isChannel1Active = audio.isChannelActive(1),
	isChannel2Active = audio.isChannelActive(2),
	
	-- Load Sounds here:
	clickSound = audio.loadSound("sounds/menu_tone.wav"),
	mainmenuSound = audio.loadSound("sounds/cocoonedmusic.wav"),
	--selectMapSound = audio.loadSound('sounds/selectMap.wav')
}

return sound