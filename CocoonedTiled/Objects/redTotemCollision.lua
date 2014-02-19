function collide(collideObject, player, event, mapData, map)
	if player.color ~= 'red' then
		player:totemRepel(collideObject)
	end
end

local redTotemCollision = {
	collide = collide
}

return redTotemCollision