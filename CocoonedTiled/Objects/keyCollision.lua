function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
 	collideObject:removeSelf( )
end

local keyCollision = {
	collide = collide
}

return keyCollision