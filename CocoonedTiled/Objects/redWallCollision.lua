function collide(collideObject, player, event, mapData, map)
	if player.color == 'red' then
		event.contact.isEnabled = false
	end
end

local redAuraCollision = {
	collide = collide
}

return redAuraCollision