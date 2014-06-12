--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sound")
local animation = require("Core.animation")
local uMath = require("utils.utilMath")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local waterCount = 0

--------------------------------------------------------------------------------
-- Clean Function - function for deleting all local variables
--------------------------------------------------------------------------------
local function clean(event)
	local params = event.source.params
	print("clean")
	if params.splashParams then
		params.splashParams:removeSelf()
		params.splashParams = nil
	end
end

--------------------------------------------------------------------------------
-- End Animation -- function that ends animation for water splash 
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function endAnimation( event )
	if ( event.phase == "ended" ) then
		local thisSprite = event.target  --"event.target" references the sprite
		thisSprite:removeSelf()  --play the new sequence; it won't play automatically!
	end
end

--------------------------------------------------------------------------------
-- Collide Function - function for water collision
--------------------------------------------------------------------------------
-- Updated by: Robert James Ford XIII
-- print("##############  I just collided with water ###############")
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	if (gameData.onIceberg == false) then
		if(event.phase == "began") then

			-- set the player inWater variable
			gameData.inWater = true

			-- player the splash animation
			local splashAnim = display.newSprite(animation.sheetOptions.splashSheet, animation.spriteOptions.splash)	
			-- Start splash at player location
			splashAnim.x = player[1].imageObject.x
			splashAnim.y = player[1].imageObject.y
			-- Enlarge the size of the splash
			splashAnim:scale(.5, .5)
			splashAnim:setSequence("move")
			splashAnim:play()
			splashAnim:addEventListener( "sprite", endAnimation )

			-- print("==================== began collided with water, count: " .. waterCount .. " ===================")

			-- if water count is 0, then the player just entered water and now we have to start the death timer
			if(waterCount == 0) then
				-- start the death timer
				player[1]:startDeathTimer(mapData, gui)
				gameData.allowPaneSwitch = false

				-- set player variables
				player[1].lastPositionSaved = true
				player[1].imageObject.linearDamping = 3

				-- if the player is small, further increase the linear damping
				if player[1].small then
					player[1].imageObject.linearDamping = 10
				end

				-- calculate the players next location when entering the water
				local xf, yf = uMath.calcNextPoint(player[1], 80)

				-- calculate the distance of travel for later calculation
				distance = uMath.distanceXY(player[1].imageObject.x, player[1].imageObject.y, xf, yf)

				-- calculate how much force to apply to the player so they are fully in water
				local jumpDirectionX, jumpDirectionY = 0,0
				jumpDirectionX, jumpDirectionY = uMath.calcDirectionForce(player[1].imageObject.x, player[1].imageObject.y, xf, yf, distance, 10)

				-- if the player is small, decrease the push velocity into water
				if player.small then
					jumpDirectionX = jumpDirectionX / 2
					jumpDirectionY = jumpDirectionY / 2
				end

				-- apply that force to make sure the aplyer is fully in water
				player[1].imageObject:setLinearVelocity(0,0)
				player[1].imageObject:applyForce(jumpDirectionX, jumpDirectionY, player[1].imageObject.x, player[1].imageObject.y)

				-- stop the player after a certain time so they stay in the water
				local function stopPlayer()
					player[1].imageObject:setLinearVelocity(0,0)
				end

				-- start the stop player function after 0.5 seconds
				timer.performWithDelay(500, stopPlayer)

				-- play alpha animation of player
				player[1].sinkTrans = transition.to(player[1].imageObject, {time=3000, alpha=0})
			end

			-- increment the water count to keep track of how many water bodies the player is in
			waterCount = waterCount + 1

		elseif event.phase == "ended"  then
			-- increment the water collision count to keep track is player is stil in water bodies
			if(waterCount > 0) then
				waterCount = waterCount - 1
				player[1].shook = false
				--print("==================== ended collided with water, count: " .. waterCount .. " ===================")
			end
			-- if the water count is at 0, the player is out of water and now set everything back to safe status
			if ( waterCount == 0 ) and player[1].onLand then
				--print("==================== OUT ended collided with water, count: " .. waterCount .. " ===================")

				-- reset the player booleans
				player[1].shook = false
				gameData.inWater = false
				player[1].lastPositionSaved = false

				-- stop the death timer
				player[1]:stopDeathTimer()
				
				-- stop the alpha transition
				if player[1].sinkTrans ~= nil then
					print("stop trans")
					transition.cancel(player[1].sinkTrans)
					player[1].sinkTrans = nil
				end

				-- reset the player physics data
				player[1].imageObject.alpha = 1
				player[1].imageObject:setLinearVelocity(0,0)
				player[1].imageObject.linearDamping = 1.25
				gameData.allowPaneSwitch = true
			end
		end
	end


	--if gameData.onIceberg then
		--print(" @@@@@@@@@@@@@@@ still on an iceberg")
	--else
		--print(" $$$$$$$$$$$$$$$ not on an iceberg")
	--end
	-- If player is not on top of iceberg
	--[[if gameData.onIceberg == false then
		gameData.allowPaneSwitch = false
		-- play sound
		sound.stopChannel(1)
	    sound.playSound(sound.soundEffects[4])
		local splashAnim = display.newSprite(animation.sheetOptions.splashSheet, animation.spriteOptions.splash)	
		-- Start wolf off-screen
		splashAnim.x = player.imageObject.x
		splashAnim.y = player.imageObject.y
		-- Enlarge the size of the splash
		--splashAnim:scale(1, 3)
		splashAnim:setSequence("move")
		splashAnim:play()
		player.curse = 0
		player.xGrav = 0
		player.yGrav = 0

		-- reset player's aura and movement
		player:changeColor("white")
		--player.movement ="inWater"
		gameData.inWater = true
		player.imageObject.linearDamping = 8
		-- Create timer to remove splashAnimation
		local timer = timer.performWithDelay(600, clean)
		timer.params = {splashParams = splashAnim}
	end
	]]
end

local function reset()
	waterCount = 0
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local waterCollision = {
	collide = collide,
	reset = reset,
	waterCount = waterCount
}

return waterCollision
-- end of waterCollision.lua