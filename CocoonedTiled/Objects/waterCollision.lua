function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	--player:water()
end

local waterCollision = {
	collide = collide
}

return waterCollision