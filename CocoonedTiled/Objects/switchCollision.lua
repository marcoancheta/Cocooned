function collide(collideObject, player, event, mapData, map)
	print("Collided with SWITCH")
	event.contact.isEnabled = false
	--print(map.layer["tiles"][183])
	for check = 1, map.layer["tiles"].numChildren do
		--print(check, map.layer["tiles"][check].name)
		if map.layer["tiles"][check].name == "switchWall" then
			map.layer["tiles"][check]:removeSelf()
		end
	end
end

local switchCollision = {
	collide = collide
}

return switchCollision