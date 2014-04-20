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
-- creates the collision detection for that pane
local function createCollisionDetection(imageObject, player, mapData, gui, map)
	
	function imageObject:preCollision(event)
		--[[
		if collideObject.collType == "solid" or	collideObject.collectable == true or 
		   collideObject.name == "wind" or  collideObject.collType == "passThru" then
			local col = require("Objects." .. collideObject.func)
			col.collide(collideObject, player, event, mapData, map, gui)				
		--elseif collideObject.collType == "wall" then
			-- Create particle effect.
			--timer.performWithDelay(100, emitParticles(collideObject, targetObject, gui, physics))
		end
		]]--
	end

	--function for collision detection
	-- when an object collides, call its own collide function
	local function onLocalCollision(self, event)
		-- save the collide object
		local collideObject = event.other
				if collideObject.collType == "solid" or	collideObject.collectable == true or 
				   collideObject.name == "wind" or  collideObject.collType == "passThru" then
					local col = require("Objects." .. collideObject.func)
					col.collide(collideObject, player, event, mapData, map, gui)				
				--elseif collideObject.collType == "wall" then
					-- Create particle effect.
					--timer.performWithDelay(100, emitParticles(collideObject, targetObject, gui, physics))
				end
		-- when collision began, do this
		--if event.phase == "began" then		
			-- if the object is a solid, call it's function		
			local textObject = display.newText("", 600, 400, native.systemFont, 72)
		
			--if the player shook, and the collision with water ended
			if collideObject.name == "water" then
				local col = require("Objects." .. collideObject.func)
				col.collide(collideObject, player, event, mapData, map, gui)	
			
				textObject.text = "WATER!"
				textObject.x = display.contentCenterX
				textObject.y = display.contentCenterY
				textObject:setFillColor(0,0,1)
				textObject:toFront()
			
				if player.shook == true then
					--player.movement = "accel"
					textObject:toBack()
					gameData.inWater = false
					event.contact.isEnabled = false
					player.shook = false
				end
			end
		--end
	end

	-- add event listener to collision detection and pre collision detection
	imageObject.collision = onLocalCollision
	imageObject:addEventListener("collision", imageObject)
	imageObject:addEventListener( "preCollision")
end

--------------------------------------------------------------------------------
-- Collision Detection - change the collision detection
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- changes the collision detection for all objects in new pane
local function changeCollision(player, mapData, map) 
	-- remove old collision detection event listeners
	player.imageObject:removeEventListener("collision", player.imageObject)
	player.imageObject:removeEventListener("preCollision")

	-- create new collision detection event listeners
	createCollisionDetection(player.imageObject, player, mapData, map, gui)
end

--------------------------------------------------------------------------------
-- Collision Detection - remove all collision detection event listeners
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function destroyCollision(imageObject)
	imageObject:removeEventListener("collision", imageObject)
	imageObject:removeEventListener("preCollision")
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local collisionDetection = {
	createCollisionDetection = createCollisionDetection,
	changeCollision = changeCollision,
	destroyCollision = destroyCollision
}

return collisionDetection
-- end of collisionDetection.lua