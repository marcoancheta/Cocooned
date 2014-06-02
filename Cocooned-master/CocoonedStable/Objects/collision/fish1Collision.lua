--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- fish1Collision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Collide Function - function for fish1 collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	--if player.curse == 1 then
		--timer.performWithDelay(5000, function() player.curse = 1 end)
	--end
	--player.curse = -1
end

--------------------------------------------------------------------------------
-- Finish UP
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local fish1Collision = {
	collide = collide
}

return fish1Collision

-- end of fish1Collision.lua