require("levelFinished")
local ghosts = require("ghosts")

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	
	-- Add object to player inventory
	player:addInventory(collideObject)
	
	-- Release ghosts
	ghosts.release(collideObject, map, player)
	
	-- Remove object from display
	collideObject.isVisible = false
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