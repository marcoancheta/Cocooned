--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- greenWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Collide Function - function for blue wall collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	if player[1].color == 'green' then
		collideObject:toFront()
		event.contact.isEnabled = false
	else
		player[1].imageObject:toFront()
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local greenWallCollision = {
	collide = collide
}

return greenWallCollision

-- end of greenWallCollision.lua