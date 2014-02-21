require("levelFinished")
local gameData = require("gameData")
local sound = require("sound")

function dissolve(event)
	local params = event.source.params
	display.remove(params.param1)
end

function collide(collideObject, player, event, mapData, map)

	sound.playSound(event, sound.runePickupSound)
	event.contact.isEnabled = false	
	-- Add object to player inventory
	player:addInventory(collideObject)	
	-- Remove object from display
 	local timeIT = timer.performWithDelay(10, dissolve)
	timeIT.params = {param1 = collideObject}

	
	if collideObject.name == "blueRune" then
		gameData.blueG = true
		player:breakWalls(map)
	elseif collideObject.name == "pinkRune" then
		player:slowTime(map)		
	elseif collideObject.name == "greenRune" then
		gameData.greenG = true
	elseif collideObject.name == "yellowRune" then
		player:shrink()
	end
	
 	checkWin(player, map, mapData)

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