--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- moveWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Collide Function - function for move wall function, add curse to player
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	if player[1].curse == 1 then
		timer.performWithDelay(5000, function() player[1].curse = 1 end)
	end
	player[1].curse = -1
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local moveWallCollision = {
	collide = collide
}

return moveWallCollision

-- end of moveWallCollision.lua