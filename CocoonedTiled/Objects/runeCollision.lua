require("levelFinished")
local gameData = require("gameData")

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false	
	-- Add object to player inventory
	player:addInventory(collideObject)
	gameData.blueG = true
	-- Remove object from display
 	collideObject:removeSelf()

 	checkWin(player, map)

 	if map.tutorial == true then
 		require("tutorial")
 		printTutorial()
 	end
	
end

function removeObject(map, index, player)

end

local runeCollision = {
	collide = collide
}

return runeCollision