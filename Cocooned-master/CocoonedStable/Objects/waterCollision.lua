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
local sound = require("sound")
local animation = require("Core.animation")

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
		-- play sound
		sound.stopChannel(1)
	    sound.playSound(sound.soundEffects[4])
	    local splashAnim = display.newSprite(animation.sheetOptions.splashSheet, animation.spriteOptions.splash)	
		  -- Start wolf off-screen
		  splashAnim.x = collideObject.x
		  splashAnim.y = collideObject.y + 280
		  -- Enlarge the size of the splash
		  -- splashAnim:scale(1, 3)
		  splashAnim:setSequence("move")
		  splashAnim:play()
		  if ( event.phase == "ended" ) then
		  	splashAnim:removeSelf( )
		  end
		-- reset player's aura and movement
		player:changeColor("white")
		--player.movement ="inWater"
		gameData.inWater = true
		player.imageObject.linearDamping = 8
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