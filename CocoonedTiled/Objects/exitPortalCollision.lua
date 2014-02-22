local sound = require("sound")
local gameData = require("gameData")
levelComplete = false

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	
	if collideObject.sequence == "move" and player.deathTimer == nil then
		audio.stop()
		sound.playSound(event, sound.portalOpeningSound)
		levelComplete = true 
		player.deathTimer = timer.performWithDelay(2000, function() gameData.gameEnd = true end)
	end
end

local exitPortalCollision = {
	collide = collide
}

return exitPortalCollision