require("levelFinished")
local gameData = require("gameData")

function collide(collideObject, player, event, mapData, map)
<<<<<<< HEAD
	audio.play(runePickupSound)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
=======
	event.contact.isEnabled = false	
	-- Add object to player inventory
	player:addInventory(collideObject)	
	-- Remove object from display
>>>>>>> 0549e3cd618370897dbfe9f0acce10d8771a5b8f
 	collideObject:removeSelf()

	
	if collideObject.name == "blueRune" then
		gameData.blueG = true
	elseif collideObject.name == "pinkRune" then
		gameData.pinkG = true
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