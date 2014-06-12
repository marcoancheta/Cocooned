--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- exitPortalCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
local snow = require("utils.snow")
local cutScenes = require("Loading.cutSceneSystem")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local tempData
local tempGui

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	tempGui = gui
	tempData = mapData
	
	if collideObject.sequence == "move" then
		if gameData.gameTime > 0 then
			print("Win gameData.gameTime", gameData.gameTime)
		end
	
		event.contact.isEnabled = false
		event.other.isSensor = true	

		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[12])

		player[1].curse = 0
		player[1].xGrav = 0
		player[1].yGrav = 0
		player[1].imageObject:setLinearVelocity(0,0)
		snow.meltSnow()
		--print("exiting")
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		local complete = function()	cutScenes.endCutScene(gui, mapData); end
		local transPortal = transition.to(player[1].imageObject, {time=1000, alpha=0, x=collideObject.x, y=collideObject.y-15, onComplete = complete} )
		gameData.gRune = false 
	end
	
	--[[
	if collideObject.sequence == "move" and player.deathTimer == nil then
		levelComplete = true 
		player.deathTimer = timer.performWithDelay(2000, function() gameData.gameEnd = true end)
	end
	]]--
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local exitPortalCollision = {
	collide = collide
}

return exitPortalCollision

-- end of exitPortalCollision.lua