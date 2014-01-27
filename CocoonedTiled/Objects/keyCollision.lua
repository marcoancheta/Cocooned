function collide(collideObject, player, event, mapData)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
	mapData.version = mapData.version + 1
 	collideObject:removeSelf( )
end