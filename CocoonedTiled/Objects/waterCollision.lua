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
local gameData = require("gameData")
local sound = require("sound")
local gameOver = false

--------------------------------------------------------------------------------
-- Collide Function - function for water collision
--------------------------------------------------------------------------------
-- Updated by: Andrew moved event.contact.isenabled to precollision
--------------------------------------------------------------------------------
function collide(collideObject, player, event, mapData, map)

	
	--event.contact.isEnabled = false

	-- set players movement to inWater
	player.movement ="inWater"

	-- get direction of player escape route
	player.escape = collideObject.escape

	-- reset player's aura and movement
	player:changeColor("white")
	player.cursed = 1
	player.imageObject.linearDamping = 6

	-- if death time is nil, set it
	if player.deathTimer == nil then
		audio.stop()
		--sound.playSound(event, sound.splashSound)
		player.deathTimer = timer.performWithDelay(5000, function() gameOver = true gameData.gameEnd = true end)
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