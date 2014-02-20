local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.orbPickupSound)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
 	collideObject:removeSelf()
 	collideObject = nil
end

function removeObject(map, index, player)

end

local runeCollision = {
	collide = collide
}

return runeCollision