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
	local fixedIcebergCol = require("Objects.collision.fixedIcebergCollision")

	waterCol.reset()
	fixedIcebergCol.reset()
end

-- creates the collision detection for that pane
local function createCollisionDetection(imageObject, player, mapData, gui, map)
	
	resetCollision()

	-- function for pre collision 
	-- before the object collides, call its own collide function
	function imageObject:preCollision(event)
		-- if the object is a passThru, calls it's collide function
	    local collideObject = event.other
			
		--[[
		if event.contact then
			--let the ball go through water
			if collideObject.name == "water" then
				if gameData.inWater == false  and player.lastPositionSaved == false then
					print("saving last position")
					player.lastPositionX = imageObject.x
					player.lastPositionY = imageObject.y
					player.lastPositionSaved = true
				end
				-- disabled collision
				event.contact.isEnabled = false
				gameData.inWater = true
			end
		end
		]]--
		
	    if collideObject.collType == "passThru" and collideObject.name ~= "water" then
			local col = require("Objects.collision." .. collideObject.func)
			col.collide(collideObject, player, event, mapData, map, gui)
	    end
	    --[[
	    -- if the object is a solid, call it's collide function
	    if collideObject.collType == "solid" or collideObject.collectable == true or collideObject.name == "wind" then
			local col = require("Objects.collision." .. collideObject.func)
			col.collide(collideObject, player, event, mapData, map, gui)
	    end
	    ]]
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
				local col = require("Objects.collision." .. collideObject.func)
				col.collide(collideObject, player, event, mapData, map, gui)	
			end
		  
			-- create particle effect
			--if collideObject.collType == "wall" then
				--timer.performWithDelay(100, emitParticles(collideObject, targetObject, gui, physics))
			--end
			
		elseif event.phase == "ended" then				  
			--if the player shook, and the collision with water ended
			if collideObject.name ~= "water" and collideObject.name ~= "wall" and string.sub(collideObject.name,1,12) ~= "fixedIceberg" then
				-- set players movement to inWater
				player.imageObject.linearDamping = 1.25
			elseif collideObject.collType == "solid" then
				local col = require("Objects.collision." .. collideObject.func)
				col.collide(collideObject, player, event, mapData, map, gui)	
			elseif collideObject.name == "water" then
				local col = require("Objects.collision." .. collideObject.func)
				col.collide(collideObject, player, event, mapData, map, gui)
			end
		else
			if collideObject.name == "water" then
				--print("still colliding with water")
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
	-- remove old collision detection event listeners
	player.imageObject:removeEventListener("collision", player.imageObject)
	player.imageObject:removeEventListener("preCollision")

	-- create new collision detection event listeners
	resetCollision()
	createCollisionDetection(player.imageObject, player, mapData, gui, map)
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