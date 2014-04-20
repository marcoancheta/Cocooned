--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
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
local function collide(collideObject, player, event, mapData, map, gui)
	event.contact.isEnabled = false

	print("collideObject.escape: ", collideObject.escape)
	
	-- set players movement to inWater
	player.movement ="inWater"
	-- get direction of player escape route
	player.escape = collideObject.escape
	player.shook = false

	-- reset player's aura and movement
	player:changeColor("white")
	player.cursed = 1
	player.imageObject.linearDamping = 6

	-- if death time is nil, set it
	if player.deathTimer == nil then
		--sound.playSound(event, sound.splashSound)
		player.deathTimer = timer.performWithDelay(5000, function() gameData.gameEnd = true end)
		player.deathScreen = display.newSprite(sheetOptions.deathSheet, spriteOptions.deathAnimation)
		player.deathScreen.x, player.deathScreen.y = 720, 432
		player.deathScreen:setSequence("move")
		player.deathScreen:play()
	end
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