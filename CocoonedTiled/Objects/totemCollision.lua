function collide(collideObject, player, event, mapData, map)
	
	if player.color ~= 'green' then
		player:repel()
	end
end

local totemCollision = {
	collide = collide
}

return totemCollision