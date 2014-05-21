local gameData = require("Core.gameData")

local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	gameData.inWater = false
	gameData.onIceberg = true
	
	if gameData.debugMode then
		print("gameData.onIceberg", gameData.onIceberg)
	end
end

local fixedIcebergCollision = {
	collide = collide
}

return fixedIcebergCollision