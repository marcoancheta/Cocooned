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
local function collide(collideObject, player, event, mapData, map, gui)
	player[1].imageObject:applyForce(player[1].xForce*-15, player[1].yForce*-15, player[1].imageObject.x, player[1].imageObject.y)
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