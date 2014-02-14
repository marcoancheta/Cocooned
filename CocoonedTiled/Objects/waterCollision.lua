function collide(collideObject, player, event, mapData, map)
	player:water()
end

local waterCollision = {
	collide = collide
}

return waterCollision