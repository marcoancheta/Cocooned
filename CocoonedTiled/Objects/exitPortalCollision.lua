local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	
	if collideObject.sequence == "move" then
		audio.stop()
		sound.playSound(event, sound.portalOpeningSound)
		timer.performWithDelay(1000, function() gameData.gameEnd = true end)
	end
end

local exitPortalCollision = {
	collide = collide
}

return exitPortalCollision