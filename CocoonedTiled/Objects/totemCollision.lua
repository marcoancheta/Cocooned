function collide(collideObject, player, event, mapData, map)
	player:repel()
end

local totemCollision = {
	collide = collide
}

return totemCollision