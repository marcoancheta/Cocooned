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

		player.curse = 0
		player.xGrav = 0
		player.yGrav = 0
		player.imageObject:setLinearVelocity(0,0)
		snow.meltSnow()
		--print("exiting")
<<<<<<< HEAD
=======
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
>>>>>>> 195e964ecd48541425951bf9b5885b3d3b5b64cd
		local complete = function()	cutScenes.endCutScene(gui, mapData); end
		local transPortal = transition.to(player.imageObject, {time=1000, alpha=0, x=collideObject.x, y=collideObject.y-15, onComplete = complete} )
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