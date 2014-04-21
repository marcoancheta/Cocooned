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
local sound = require("sounds.sound")
local gameData = require("Core.gameData")
local levelComplete = false

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	
	local complete = function()	gameData.levelComplete = true; end
	
	local transPortal = transition.to(player, {time=1000, x=collideObject.x, y=collideObject.y-15, onComplete = complete} )
	--[[
	if collideObject.sequence == "move" and player.deathTimer == nil then
		--audio.stop()
		--sound.playSound(event, sound.portalOpeningSound)
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