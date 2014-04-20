--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- wallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")

--------------------------------------------------------------------------------
-- Collide Function - function for water collision
--------------------------------------------------------------------------------
-- Updated by: Andrew moved event.contact.isenabled to precollision
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	event.isSensor = true
	gameData.inWater = false
	
	print("hope")
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local wallCollision = {
	collide = collide
}

return wallCollision
-- end of wallCollision.lua