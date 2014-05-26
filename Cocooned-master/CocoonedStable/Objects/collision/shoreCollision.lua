--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- shoreCollision.lua
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
	if event.contact then
		event.contact.isEnabled = false
	end

	if event.phase == "began" then
		player.onLand = true
	--elseif event.phase == "ended" then
	--	player.onLand = false
	end

	--collideObject.isSensor = true
	--[[
	if player.lastPositionSaved then
		gameData.inWater = false
		gameData.allowPaneSwitch = true
	else
		gameData.allowPaneSwitch = false
	end
	]]
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local shoreCollision = {
	collide = collide
}

return shoreCollision
-- end of shoreCollision.lua