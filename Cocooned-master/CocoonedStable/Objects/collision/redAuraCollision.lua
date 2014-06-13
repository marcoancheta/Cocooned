--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- redAuraCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local sound = require("sound")

--------------------------------------------------------------------------------
-- Collide Function - change color of player to red
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	collideObject.alpha = 0.75

	--player = player
	if event.phase == "began" and player.color ~= "blue" then
		player:changeColor('red', gui)

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
local redAuraCollision = {
	collide = collide
}

return redAuraCollision

-- end of redAuraCollision.lua