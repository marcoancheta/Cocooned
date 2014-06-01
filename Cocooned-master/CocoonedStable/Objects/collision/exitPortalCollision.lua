--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- exitPortalCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
local snow = require("utils.snow")
local tutorialLib = require("utils.tutorialLib")
--local levelComplete = false
local complete = function()	gameData.levelComplete = true; end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
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
		local transPortal = transition.to(player.imageObject, {time=1000, alpha=0, x=collideObject.x, y=collideObject.y-15, onComplete = complete} )
		gameData.gRune = false 
	elseif collideObject.sequence == "still" then
		if gameData.mapData.levelNum == "T" then
			tutorialLib:showTipBox("portalTip", 2, gui)
		end
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