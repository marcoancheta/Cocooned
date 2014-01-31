function collide(collideObject, player, event, mapData, map)
	if player.color == 'blue' then
		event.contact.isEnabled = false
	end
end

local blueWallCollision = {
	collide = collide
}

return blueWallCollision