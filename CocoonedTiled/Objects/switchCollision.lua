function collide(collideObject, player, event, mapData, map)
	for check = 1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].name == "switchWall" then
			map.layer["tiles"][check]:removeSelf()
		end
	end
end

local switchCollision = {
	collide = collide
}

return switchCollision