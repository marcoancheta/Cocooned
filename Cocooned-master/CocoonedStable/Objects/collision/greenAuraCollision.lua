--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- greenAuraCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local colorChange = false 
local player = nil
local sound = require("sound")

--------------------------------------------------------------------------------
-- Collide Function - change color of player to green
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	collideObject.alpha = 0.75

	--player = player
	if event.phase == "began" and player.color ~= "green" then
		player:changeColor('green', gui)

		-- play sound
		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[2])
	elseif event.phase == "ended" then
		collideObject.alpha = 1
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local greenAuraCollision = {
	collide = collide
}

return greenAuraCollision

-- end of greenAuraCollision.lua