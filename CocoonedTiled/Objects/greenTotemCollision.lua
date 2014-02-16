function collide(collideObject, player, event, mapData, map)
	print("collided with greenTotem")
	if player.color ~= 'green' then
		player:totemRepel()
	end
end

local greenTotemCollision = {
	collide = collide
}

return greenTotemCollision