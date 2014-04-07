--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- wispCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local sound = require("sound")

--------------------------------------------------------------------------------
-- Collide Function - remove wisp object if collected
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map)
	--audio.stop()
	--sound.playSound(event, sound.orbPickupSound)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
 	collideObject:removeSelf()
 	collideObject = nil
end

--------------------------------------------------------------------------------
-- FInish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local runeCollision = {
	collide = collide
}

return runeCollision

-- end of runeCollision.lua