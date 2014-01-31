function collide(collideObject, player, event, mapData, map)
	if player.color == 'green' then
		event.contact.isEnabled = false
	end
end

local greenWallCollision = {
	collide = collide
}

return greenWallCollision