require("levelFinished")
local gameData = require("gameData")
local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
<<<<<<< HEAD
	audio.play(runePickupSound)

=======
	sound.playSound(event, sound.runePickupSound)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
>>>>>>> a98ea78ce0f5cfdbd355c79b6c8ae747bfabcf8a
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