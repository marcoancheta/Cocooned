function distance(o1,o2)
	return math.sqrt((o1.x-o2.x)^2+(o1.y-o2.y)^2)
end

function collide(collideObject, player, event, mapData, map)
	local goTo = collideObject
	local playerObject = player
	local objectDistance = distance(goTo, playerObject)
	print(objectDistance)
	if objectDistance > 1000 and objectDistance < 1500 then
		player:attract()
	end
end

local totemAttractCollision = {
	collide = collide
}

return totemAttractCollision