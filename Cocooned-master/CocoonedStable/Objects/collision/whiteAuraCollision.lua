--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- whiteAuraCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local sound = require("sound")

--------------------------------------------------------------------------------
-- Collide Function - change color of player to normal
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	-- play sound
	sound.playSound(sound.soundEffects[2])

	local color = "white"	
	player:changeColor(color, gui)

end

--------------------------------------------------------------------------------
--Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local whiteAuraCollision = {
	collide = collide
}

return whiteAuraCollision

-- whiteAuraCollision.lua