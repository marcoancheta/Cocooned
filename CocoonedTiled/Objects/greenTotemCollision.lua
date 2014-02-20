local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.totemSound)
	print("collided with greenTotem")
	if player.color ~= 'green' then
		player:totemRepel()
	end
end

local greenTotemCollision = {
	collide = collide
}

return greenTotemCollision