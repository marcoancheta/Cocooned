function collide(collideObject, player, event, mapData)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
 	collideObject:removeSelf()
end

function removeObject(map, index, player)

end