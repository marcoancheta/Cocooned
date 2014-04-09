--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- orangeWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--  Dissolve - function that removes break wall object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function dissolve(event)
	local params = event.source.params
	display.remove(params.param1)
end

--------------------------------------------------------------------------------
-- Collide Function - function for break wall collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	print("got to orange wall collision")
	--event.contact.isEnabled = false
	
	if player.breakable then
		local timeIT = timer.performWithDelay(1000, dissolve)
		timeIT.params = {param1 = collideObject}
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local orangeWallCollision = {
	collide = collide
}

return orangeWallCollision

-- end of orangeWallCollision.lua