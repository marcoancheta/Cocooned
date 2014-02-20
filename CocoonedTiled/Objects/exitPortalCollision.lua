local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.portalOpeningSound)
	if collideObject.sequence == "move" then
		gameData.gameEnd = true
	end
end

local exitPortalCollision = {
	collide = collide
}

return exitPortalCollision