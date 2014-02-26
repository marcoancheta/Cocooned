--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- chestCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Collide Function - remove chest if player contains key in inventory table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function collide(collideObject, player, event, mapData, map)
	if #player.inventory.items > 0 then
		if player.inventory.items[1].name == "key" then
			collideObject:removeSelf()
			mapData.version = mapData.version + 1
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local chestCollision = {
	collide = collide
}

return chestCollision

-- end of chestCollision.lua