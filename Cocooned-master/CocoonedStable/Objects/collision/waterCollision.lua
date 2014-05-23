--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sound")
local animation = require("Core.animation")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Clean Function - function for deleting all local variables
--------------------------------------------------------------------------------
local function clean(event)
	local params = event.source.params
	print("clean")
	if params.splashParams then
		params.splashParams:removeSelf()
		params.splashParams = nil
	end
	
	--params.playerParams.imageObject.linearDamping = 0
	--params.collideParams.isSensor = false
end

--------------------------------------------------------------------------------
-- Collide Function - function for water collision
--------------------------------------------------------------------------------
-- Updated by: Andrew moved event.contact.isenabled to precollision
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	-- If player is not on top of iceberg
	if gameData.onIceberg == false then
		collideObject.isSensor = true
		print("PLAYER NAME", player.name)

		-- play sound
		sound.stopChannel(1)
	    sound.playSound(sound.soundEffects[4])
		local splashAnim = display.newSprite(animation.sheetOptions.splashSheet, animation.spriteOptions.splash)	
		-- Start wolf off-screen
		splashAnim.x = player.imageObject.x
		splashAnim.y = player.imageObject.y
		-- Enlarge the size of the splash
		--splashAnim:scale(1, 3)
		splashAnim:setSequence("move")
		splashAnim:play()
		
		player.curse = 0
		player.xGrav = 0
		player.yGrav = 0
		
		local color = "white"	
		player:changeColor(color, gui)
		
		--player.movement ="inWater"
		gameData.inWater = true
		--player.imageObject.linearDamping = 5
		-- Create timer to remove splashAnimation
		local timer = timer.performWithDelay(600, clean)
		timer.params = {splashParams = splashAnim, playerParams = player,
						collideParams = collideObject}
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