function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	player:changeColor('green')
end

local greenAuraCollision = {
	collide = collide
}

return greenAuraCollision