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
local levelFinished = require("Core.levelFinished")
local gameData = require("Core.gameData")
local sound = require("sound")
local animation = require("Core.animation")
local tutorialLib = require("utils.tutorialLib")

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
-- Updated by: Andrew added lines 59 and 60 gameData.greenG = true and player:moveWalls(map)
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	-- set collision to false
	--event.contact.isEnabled = false

	-- play sound
	sound.stopChannel(1)
	sound.playSound(sound.soundEffects[5])

	-- add rune to inventory
	--player:addInventory(collideObject)
	player:addRune(collideObject, map)

	-- create rune animation collection sprite and play it
	local runeCollide = display.newSprite(animation.sheetOptions.runeSheet, animation.spriteOptions.runeAnimation)
	runeCollide.x, runeCollide.y = collideObject.x - 45, collideObject.y
	runeCollide:setSequence("move")
	runeCollide:play()
	runeCollide:addEventListener( "sprite", endAnimation )


	-- Create animation for the ball shrinking 
	--local playerShrink = display.newSprite(animation.sheetOptions.shrinkSheet, spriteOptions.shrinkAnimation)
	--playerShrink.x, playerShrink.y = collideObject.x - 45, collideObject.y
	--playerShrink:setSequence("move")

	-- check which rune was collected and activate ability
	if collideObject.name == "blueRune" then
		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[9])
		player:breakWalls(map)
		player:unshrink()
		player.large = true
	elseif collideObject.name == "pinkRune" then
		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[10])
		player:slowTime(gui.front)
	elseif collideObject.name == "greenRune" then
		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[11])
		gameData.gRune = true
		player:moveWalls(gui)
	--elseif collideObject.name == "yellowRune" then
	elseif collideObject.name == "purpleRune" then
		collideObject:removeSelf()
		
		if gameData.mapData.levelNum == "T" then
			if tutorialLib.tutorialStatus == 1 then
				--set up tiltip if in tutorial level
				tutorialLib:showTipBox("swipePaneTip", 2, gui, player)
			end
		end	
		
		-- shrink the player		
		player:shrink()
		player.small = true
	end
	
	-- remove rune
 	collideObject:removeSelf()

 	if gui then
		-- check if player has reached level goal
		levelFinished.checkWin(player, gui.front, mapData)
	end
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