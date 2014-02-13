function collide(collideObject, player, event, mapData, map)
	player:totemRepel()
end

local totemRepelCollision = {
	collide = collide
}

return totemRepelCollision