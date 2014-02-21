local gameData = require("gameData")
local sound = require("sound")
function collide(collideObject, player, event, mapData, map)


	event.contact.isEnabled = false
	player.movement ="inWater"
	player.escape = collideObject.escape
	player:changeColor("white")
	player.cursed = 1
	player.imageObject.linearDamping = 6
	if player.deathTimer == nil then
		audio.stop()
		sound.playSound(event, sound.splashSound)
		player.deathTimer = timer.performWithDelay(5000, function() gameData.gameEnd = true end)
	end
	

end

local waterCollision = {
	collide = collide
}

return waterCollision