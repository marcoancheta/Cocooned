local sound = require("sound")
local gameData = require("gameData")

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	
	if collideObject.sequence == "move" and player.deathTimer == nil then
		audio.stop()
		sound.playSound(event, sound.portalOpeningSound)
		player.deathTimer = timer.performWithDelay(2000, function() gameData.gameEnd = true end)
	end
end

local exitPortalCollision = {
	collide = collide
}

return exitPortalCollision