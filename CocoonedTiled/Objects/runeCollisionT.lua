function collide(collideObject, player, event, mapData)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
 	collideObject:removeSelf()

 	require("tutorial")
 	--printTutorial()
end