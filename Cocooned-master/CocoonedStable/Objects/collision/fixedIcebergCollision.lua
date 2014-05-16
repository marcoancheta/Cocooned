local gameData = require("Core.gameData")

local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	gameData.inWater = false
	gameData.onIceberg = true
	print(gameData.onIceberg)
end

local fixedIcebergCollision = {
	collide = collide
}

return fixedIcebergCollision