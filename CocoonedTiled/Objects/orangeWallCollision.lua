function collide(collideObject, player, event, mapData, map)
	print("got to orange wall collision")
	if player.color == 'red' then
		event.contact.isEnabled = false
	end
end

local orangeWallCollision = {
	collide = collide
}

return orangeWallCollision