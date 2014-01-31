function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	player:changeColor('red')
end

local redAuraCollision = {
	collide = collide
}

return redAuraCollision