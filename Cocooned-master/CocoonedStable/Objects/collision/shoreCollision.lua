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

local waterShadow = nil

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
		print("HIT SHORE!!!")
		if gameData.inWater == false then
			gameData.allowPaneSwitch = true
			gameData.allowMiniMap = true
		
			waterShadow = display.newCircle(player[1].imageObject.x, player[1].imageObject.y, 1)
			waterShadow.alpha = 0
			waterShadow.name = "waterShadow"

			gui.front:insert(waterShadow)
			player[1].lastSavePoint = waterShadow
			player[1].lastSavePoint.pane = mapData.pane
		end
		player.onLand = true
	elseif event.phase == "ended" then
		print("LEAVING SHORE!!")
		player[1].onLand = false
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