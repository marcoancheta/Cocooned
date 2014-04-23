local gameData = require("Core.gameData")
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false
	gameData.onIceberg = true
end

local fixedIcebergCollision = {
	collide = collide
}

return fixedIcebergCollision