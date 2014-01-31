function collide(collideObject, player, event, mapData, map)
	if player.color == 'white' then
		event.contact.isEnabled = false
	end
end

local whiteWallCollision = {
	collide = collide
}

return whiteWallCollision