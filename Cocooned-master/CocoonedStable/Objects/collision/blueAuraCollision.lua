--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- blueAuraColliaion.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
--------------------------------------------------------------------------------
-- Collide Function - change color of player to bluw
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	
	local color = "blue"	
	player:changeColor(color, gui)

	-- play sound
	sound.stopChannel(1)
	sound.playSound(sound.soundEffects[2])
	
	--local closure = function() return player:changeColor('white') end
	--timer1 = timer.performWithDelay( 10000, closure, 1)
end

--------------------------------------------------------------------------------
-- FInish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local blueAuraCollision = {
	collide = collide
}

return blueAuraCollision

-- end of blueAuraCollision.lua