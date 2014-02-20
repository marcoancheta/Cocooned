local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.totemSound)
	if player.color ~= 'red' then
		player:totemRepel(collideObject)
	end
end

local redTotemCollision = {
	collide = collide
}

return redTotemCollision