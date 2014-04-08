--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- moveWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Collide Function - function for movable wall function
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function collide(collideObject, player, event, mapData, map)
	player.imageObject:applyForce(player.xForce*-15, player.yForce*-15, player.imageObject.x, player.imageObject.y)
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local switchWallCollision = {
	collide = collide
}

return switchWallCollision

-- end of moveWallCollision.lua