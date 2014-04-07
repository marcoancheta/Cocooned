--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- redAuraCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local colorChange = false 
local player = nil
local sound = require("sound")

--------------------------------------------------------------------------------
-- Collide Function - change color of player to red
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map)
	--audio.stop()
	--sound.playSound(event, sound.auraPickupSound)
	player = player
	event.contact.isEnabled = false
	player:changeColor('red')
	
	local closure = function() return player:changeColor('white') end
	timer1 = timer.performWithDelay( 10000, closure, 1)
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local redAuraCollision = {
	collide = collide
}

return redAuraCollision

-- end of redAuraCollision.lua