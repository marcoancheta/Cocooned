function collide(collideObject, player, event, mapData, map)
	print("got to blue wall collision")
	if player.color == 'blue' then
		event.contact.isEnabled = false
	end
end

local blueWallCollision = {
	collide = collide
}

return blueWallCollision