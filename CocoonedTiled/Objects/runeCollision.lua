function collide(collideObject, player, event, mapData)
	event.contact.isEnabled = false
	mapData.version = mapData.version + 1
 	collideObject:removeSelf()
 	
end