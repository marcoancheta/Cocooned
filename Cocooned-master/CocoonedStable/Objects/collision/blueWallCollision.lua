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
	if player[1].color == 'blue' then
		collideObject:toFront()
		event.contact.isEnabled = false
	else
		player[1].imageObject:toFront()
	end
	
	--GA.newEvent ( "design", {event_id = "collide:" ..collideObject.name, area = "level: "..mapData.levelNum, x=player.imageObject.x, y=player.imageObject.y } )
end

--------------------------------------------------------------------------------
-- FInish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local blueWallCollision = {
	collide = collide
}

return blueWallCollision

-- end of blueWallCollision.lua