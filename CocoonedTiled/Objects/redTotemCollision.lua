function collide(collideObject, player, event, mapData, map)
	
	if player.color ~= 'red' then
		player:totemRepel()
	end
end

local redTotemCollision = {
	collide = collide
}

return redTotemCollision