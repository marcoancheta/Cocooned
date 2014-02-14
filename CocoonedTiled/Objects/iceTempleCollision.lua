local gameData = require("gameData")

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	print("To the Ice TEMPLE!")
	gameData.bonusLevel = true
 	collideObject:removeSelf()
 	collideObject = nil
end

local iceTempleCollision = {
	collide = collide
}

return iceTempleCollision