local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.splashSound)
	player:water()
end

local waterCollision = {
	collide = collide
}

return waterCollision