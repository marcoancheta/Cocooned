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
local gameData = require("gameData")
levelComplete = false

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	
	if collideObject.sequence == "move" and player.deathTimer == nil then
		audio.stop()
		sound.playSound(event, sound.portalOpeningSound)
		levelComplete = true 
		player.deathTimer = timer.performWithDelay(2000, function() gameData.gameEnd = true end)
	end
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