--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- runeCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
require("levelFinished")
local gameData = require("gameData")
local sound = require("sound")

--------------------------------------------------------------------------------
-- End Animation -- function that ends animation for collecting rune
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function endAnimation( event )
  if ( event.phase == "ended" ) then
    local thisSprite = event.target  --"event.target" references the sprite
    thisSprite:removeSelf()  --play the new sequence; it won't play automatically!
  end
end

--------------------------------------------------------------------------------
-- Collide Function - function for rune collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function collide(collideObject, player, event, mapData, map, physics)

	-- stop audio and play audio sound
	audio.stop()
	sound.playSound(event, sound.runePickupSound)

	-- set collision to false
	event.contact.isEnabled = false

	-- add rune to inventory
	player:addInventory(collideObject)
	player:addRune(collideObject)

	-- create rune animation collection sprite and play it
	local runeCollide = display.newSprite(sheetOptions.runeSheet, spriteOptions.runeAnimation)
	runeCollide.x, runeCollide.y = collideObject.x - 45, collideObject.y
	runeCollide:setSequence("move")
	runeCollide:play()

	-- Create animation for the ball shrinking 
	--local playerShrink = display.newSprite(sheetOptions.shrinkSheet, spriteOptions.shrinkAnimation)
	--playerShrink.x, playerShrink.y = collideObject.x - 45, collideObject.y
	--playerShrink:setSequence("move")

	-- check which rune was collected and activate ability
	if collideObject.name == "blueRune" then
		player:breakWalls(map)
	elseif collideObject.name == "pinkRune" then
		player:slowTime(map)		
	elseif collideObject.name == "greenRune" then
		gameData.greenG = true
	elseif collideObject.name == "yellowRune" then
		--player:moveWalls(map)
	elseif collideObject.name == "purpleRune" then
		collideObject:removeSelf()
		-- Create animation for the ball shrinking 
		local playerShrink = display.newSprite(sheetOptions.shrinkSheet, spriteOptions.shrinkAnimation)
		playerShrink.x, playerShrink.y = collideObject.x, collideObject.y
		playerShrink:setSequence("move")
		playerShrink:play()
		playerShrink:removeSelf( )
		player:shrink()
	end
	
	-- remove rune
 	collideObject:removeSelf()


 	-- check if player has reached level goal
 	checkWin(player, map, mapData)
end

--------------------------------------------------------------------------------
--Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local runeCollision = {
	collide = collide
}

return runeCollision

-- end of runeCollision.lua