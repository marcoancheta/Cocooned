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
local function collide(collideObject, player, event, mapData, map, gui)
	--event.contact.isEnabled = true

	-- play sound
	--sound.playSound(sound.soundEffects[4])	
	
	if gameData.onIceberg == false then
		-- reset player's aura and movement
		player:changeColor("white")
		player.imageObject:setLinearVelocity(0, 0)
		--player.movement ="inWater"
		gameData.inWater = true
		--player.imageObject.linearDamping = 8
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