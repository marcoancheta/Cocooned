--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- collisionDetection.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- collision detection lua operates the collision detection for all objects
-- when an object collides or before it collides, the objects collide function is
-- called and does their own functions upon collision
-- for example, before a red aura collides with player, its collision is turned 
-- off and the player's color is changed
--
--------------------------------------------------------------------------------
-- Collision Detection Mechanic
--------------------------------------------------------------------------------
-- Updated by: Derrick (re-factoring)
-- Previous update: Andrew (moved water collision to be spread out across, 
-- 							pre-collision, begin collision, and post collision)
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")

--------------------------------------------------------------------------------
-- Collision Detection - reset the counters for water collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function resetCollision()
	local waterCol = require("Objects.collision.waterCollision")
	local icebergCol = require("Objects.collision.fixedIcebergCollision")

	waterCol.reset()
	icebergCol.reset()
end

-- creates the collision detection for that pane
local function createCollisionDetection(imageObject, player, mapData, gui, map)
	resetCollision()
	-- function for pre collision 
	-- before the object collides, call its own collide function
	function imageObject:preCollision(event)
		-- if the object is a passThru, calls it's collide function
	    local collideObject = event.other
		if gameData.collOn then
		    if collideObject.collType == "passThru" and collideObject.name ~= "water" then
				local col = require("Objects.collision." .. collideObject.func)
				col.collide(collideObject, player, event, mapData, map, gui)
		    end
		end
	end

	--function for collision detection
	-- when an object collides, call its own collide function
	local function onLocalCollision(self, event)
		-- save the collide object
		local collideObject = event.other
		-- when collision began, do this
		if event.phase == "began" then
			-- if the object is a solid, call it's function
			if (collideObject.collType == "solid" and collideObject.name ~= "walls") or (collideObject.name == "water") then
				if gameData.collOn then	
					local col = require("Objects.collision." .. collideObject.func)
					col.collide(collideObject, player, event, mapData, gui.front, gui)	
				end
			elseif event.phase == "ended" then	
				if collideObject.collType == "solid" then
					local col = require("Objects.collision." .. collideObject.func)
					col.collide(collideObject, player, event, mapData, gui.front, gui)	
				elseif collideObject.name == "water" then
					local col = require("Objects.collision." .. collideObject.func)
					col.collide(collideObject, player, event, mapData, gui.front, gui)
				end
			end
		end
	end

	-- add event listener to collision detection and pre collision detection
	imageObject.collision = onLocalCollision
	imageObject:addEventListener("collision", imageObject)
	imageObject:addEventListener("preCollision")
end



--------------------------------------------------------------------------------
-- Collision Detection - change the collision detection
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- changes the collision detection for all objects in new pane
local function changeCollision(player, mapData, gui, map)
	if player[1] then
		-- remove old collision detection event listeners
		player[1].imageObject:removeEventListener("collision", player[1].imageObject)
		player[1].imageObject:removeEventListener("preCollision")

		-- create new collision detection event listeners
		resetCollision()
		createCollisionDetection(player[1].imageObject, player, mapData, gui, map)
	end
end

--------------------------------------------------------------------------------
-- Collision Detection - remove all collision detection event listeners
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function destroyCollision(imageObject)
	resetCollision()
	if imageObject then
		imageObject:removeEventListener("collision", imageObject)
		imageObject:removeEventListener("preCollision")
	end
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local collisionDetection = {
	createCollisionDetection = createCollisionDetection,
	changeCollision = changeCollision,
	destroyCollision = destroyCollision,
	resetCollision = resetCollision
}

return collisionDetection
-- end of collisionDetection.lua