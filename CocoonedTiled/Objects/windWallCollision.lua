function collide(collideObject, player, event, mapData, map)
	player:windRepel()
end

local windWallCollision = {
	collide = collide
}

return windWallCollision