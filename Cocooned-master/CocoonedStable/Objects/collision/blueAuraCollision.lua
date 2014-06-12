--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- blueAuraColliaion.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
--------------------------------------------------------------------------------
-- Collide Function - change color of player to bluw
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	collideObject.alpha = 0.75
	
	--player = player
	if event.phase == "began" and player.color ~= "blue" then
		player[1]:changeColor('blue', gui)

		-- play sound
		sound.stopChannel(1)
		sound.playSound(sound.soundEffects[2])
	elseif event.phase == "ended" then
		collideObject.alpha = 1
	end
	
	
	--local closure = function() return player:changeColor('white') end
	--timer1 = timer.performWithDelay( 10000, closure, 1)
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local blueAuraCollision = {
	collide = collide
}

return blueAuraCollision
-- end of blueAuraCollision.lua