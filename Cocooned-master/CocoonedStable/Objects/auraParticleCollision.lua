--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- blueWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--local GA = require("plugin.gameanalytics")

--------------------------------------------------------------------------------
-- Collide Function - function for blue wall collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	if event.contact then
		event.contact.isEnabled = false
	end
	
	--GA.newEvent ( "design", {event_id = "collide:" ..collideObject.name, area = "level: "..mapData.levelNum, x=player.imageObject.x, y=player.imageObject.y } )
end

--------------------------------------------------------------------------------
-- FInish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local auraParticleCollision = {
	collide = collide
}

return auraParticleCollision

-- end of blueWallCollision.lua