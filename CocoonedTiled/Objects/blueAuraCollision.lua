function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	player:changeColor('blue')
end

local blueAuraCollision = {
	collide = collide
}

return blueAuraCollision