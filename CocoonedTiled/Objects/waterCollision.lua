function collide(collideObject, player, event, mapData, map)
	audio.play(splashSound)
	player:water()
end

local waterCollision = {
	collide = collide
}

return waterCollision