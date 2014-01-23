
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
-- Sound Options
--------------------------------------------------------------------------------
local soundOptions = {
	channel = 1,
	loops = 0,
	duration = 30000,
	onComplete=callbackListener
}

-- Bug Testing

local function soundDone(event)
	print("Finished sound on channel", event.channel)
end

--------------------------------------------------------------------------------
-- Play Sounds
--------------------------------------------------------------------------------
function playSound(event, name)
	audio.setVolume(0.1, {channel = 1} )
	local temp = audio.play(name, soundOptions)
	print("play sound:", name)

end

--------------------------------------------------------------------------------
-- Finish up -&- Load Sounds
--------------------------------------------------------------------------------
local sound = {
	soundOptions = soundOptions,
	playSound = playSound,
	
	-- Load Sounds here:
	mainmenuSound = audio.loadSound("sounds/menu_tone.wav"),
}

return sound