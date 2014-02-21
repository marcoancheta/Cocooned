function collide(collideObject, player, event, mapData, map)
	if player.curse == 1 then
		timer.performWithDelay(5000, function() player.curse = 1 end)
	end
	player.curse = -1
end

local fish2Collision = {
	collide = collide
}

return fish2Collision