--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")

--------------------------------------------------------------------------------
-- Collide Function - function for water collision
--------------------------------------------------------------------------------
-- Updated by: Andrew moved event.contact.isenabled to precollision
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui, txtObj)
	event.contact.isEnabled = true

	-- reset player's aura and movement
	player:changeColor("white")
	player.movement ="inWater"
	gameData.inWater = true

	if gameData.inWater then
		txtObj.text = "true"
	else
		txtObj.text = "false"
	end
	
	txtObj.x = display.contentCenterX
	txtObj.y = display.contentCenterY
	txtObj:setFillColor(0,0,1)
	txtObj:toFront()	
	-- if death time is nil, set it
	--[[
	if player.deathTimer == nil then
		--sound.playSound(event, sound.splashSound)
		--player.deathTimer = timer.performWithDelay(5000, function() gameData.gameEnd = true end)
		player.deathScreen = display.newSprite(sheetOptions.deathSheet, spriteOptions.deathAnimation)
		player.deathScreen.x, player.deathScreen.y = 720, 432
		player.deathScreen:setSequence("move")
		player.deathScreen:play()
	end
	]]--
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local waterCollision = {
	collide = collide
}

return waterCollision
-- end of waterCollision.lua