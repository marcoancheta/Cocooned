function collide(collideObject, player, event, mapData, map)
	player:repel()
end

local totemRepelCollision = {
	collide = collide
}

return totemRepelCollision