require("levelFinished")
local gameData = require("gameData")

function collide(collideObject, player, event, mapData, map)
	audio.play(runePickupSound)

	event.contact.isEnabled = false	
	-- Add object to player inventory
	player:addInventory(collideObject)	
	-- Remove object from display
 	collideObject:removeSelf()

	
	if collideObject.name == "blueRune" then
		gameData.blueG = true
		player:breakWalls(map)
	elseif collideObject.name == "pinkRune" then
		player:slowTime(map)		
	elseif collideObject.name == "greenRune" then
		gameData.greenG = true
	end
	
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