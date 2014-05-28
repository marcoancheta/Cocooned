--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
local waterCollision = {
	sinkTrans = nil
}

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
local waterShadow

--------------------------------------------------------------------------------
-- Clean Function - function for deleting all local variables
--------------------------------------------------------------------------------f
local function clean() --event)
	--local params = event.source.params
	print("clean")
	--if params.splashParams then
	--	params.splashParams:removeSelf()
	--	params.splashParams = nil
	--end
	if waterShadow then
		waterShadow:removeSelf()
		waterShadow = nil
	end
end

--------------------------------------------------------------------------------
-- reset() - function for deleting all local variables
--------------------------------------------------------------------------------
local function reset()
	if waterShadow then
		waterShadow:removeSelf()
		waterShadow = nil
	end
	waterCount = 0
end

--------------------------------------------------------------------------------
-- stopPlayer() - reset player's velocity to 0,0
--------------------------------------------------------------------------------
local function stopPlayer(event)
	local params = event.source.params
	print(">>>>>>>>>>>>> STOPPED DAT NIGGA")
	params.playerParams.imageObject:setLinearVelocity(0,0)
end

--------------------------------------------------------------------------------
-- Collide Begin Function - function for water collision
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	if (gameData.onIceberg == false) then
		if(event.phase == "began") then					
			print("====== began collided with water, count: " .. waterCount .. " =======")
			if (waterCount == 0) then
				local vx, vy
				local xf, yf
				local distance
				local moveX, moveY
				local deltaX, deltaY
				local angleX, angleY
				local stopTimer
				local jumpDirectionX, jumpDirectionY
				
				-- Clear waterShadow in clean function
				clean()
				-- Trigger booleans to reflect inWater
				player.onLand = false
				gameData.inWater = true
				gameData.allowPaneSwitch = false
				-- Start player's death timer
				player:startDeathTimer(mapData, miniMap, gui)
				-- Store player's last position
				player.lastPositionX = player.imageObject.x
				player.lastPositionY = player.imageObject.y	
				-- Check if position save exists
				if player.lastPositionX and player.lastPositionY then
					player.lastPositionSaved = true
				end
				-- Increase linearDamping to prevent player from going out further in water
				player.imageObject.linearDamping = 3
				-- Store player's x and y linear velocity
				vx, vy = player.imageObject:getLinearVelocity()
				--print("entry velocity is " .. vx .. ", " .. vy)
				xf = player.imageObject.x + vx
				yf = player.imageObject.y + vy
				-- Calculate distance between player.imageObject and new positions
				distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)
				-- Calculate ?
				moveX = 100 * math.cos(math.acos(vx/distance))
				moveY = 100 * math.sin(math.asin(vy/distance))

				xf = player.imageObject.x + moveX
				yf = player.imageObject.y + moveY

				--print("player is at " .. player.imageObject.x .. ", " .. player.imageObject.y)
				--print("move the player to this point: " .. xf .. ", " .. yf)
				
				-- Update distance
				distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)
				deltaX = xf - player.imageObject.x
				deltaY = yf - player.imageObject.y
				angleX = math.acos(deltaX/distance)
				angleY = math.asin(deltaY/distance)
				jumpDirectionX = 10 * math.cos(angleX)
				jumpDirectionY = 10 * math.sin(angleY)

				-- Reset player's linear velocity pos to 0, 0
				player.imageObject:setLinearVelocity(0,0)
				-- Apply force towards jumpDirections
				player.imageObject:applyForce(jumpDirectionX, jumpDirectionY, player.imageObject.x, player.imageObject.y)
				-- Take 5 milliseconds to reset player's velocity
				stopTimer = timer.performWithDelay(500, stopPlayer)
				stopTimer.params = {playerParams = player}
				-- Transition player's alpha to 0
				waterCollision.sinkTrans = transition.to(player.imageObject, {time=3000, alpha=0})
				-- Create new water shadow
				--waterShadow = display.newCircle(player.lastPositionX, player.lastPositionY, 38)
				--waterShadow.alpha = 0
				--waterShadow.name = "waterShadow"
				--gui.front:insert(waterShadow)
				player.lastSavePoint = {}
				player.lastSavePoint.x = player.lastPositionX
				player.lastSavePoint.y = player.lastPositionY
				player.lastSavePoint.pane = mapData.pane
			end
			
			waterCount = waterCount + 1
		end
	end
end

--------------------------------------------------------------------------------
-- Collide End Function - function for water collision
--------------------------------------------------------------------------------
local function collideEnd(collideObject, player, event, mapData, map, gui)
	if (gameData.onIceberg == false) then
		if event.phase == "ended"  then
			if(waterCount > 0) then
				waterCount = waterCount - 1
				player.shook = false
				print("==================== ended collided with water, count: " .. waterCount .. " ===================")
			elseif ( waterCount == 0 ) and player.onLand then
				-- Cancel transitions
				if waterCollision.sinkTrans then
					transition.cancel(waterCollision.sinkTrans)
				end
				-- Turn off deathTimer
				player:stopDeathTimer()
				-- Reset player booleans
				player.shook = false
				player.lastPositionSaved = false
				player.imageObject:setLinearVelocity(0,0)
				player.imageObject.linearDamping = 1.25
				player.imageObject.alpha = 1
				-- Reset gameData booleans
				gameData.allowPaneSwitch = true
				gameData.inWater = false
				print("==================== OUT ended collided with water, count: " .. waterCount .. " ===================")
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
waterCollision.collide = collide
waterCollision.collideEnd = collideEnd
waterCollision.reset = reset
waterCollision.waterCount = waterCount

return waterCollision
-- end of waterCollision.lua


--------------------------------------------------------------------------------
-- OLD CODE
--------------------------------------------------------------------------------
--[[
local function collide(collideObject, player, event, mapData, map, gui)
	if (gameData.onIceberg == false) then
		if(event.phase == "began") then		
			print("==================== began collided with water, count: " .. waterCount .. " ==================="
			if(waterCount == 0) then
				gameData.inWater = true
				gameData.allowPaneSwitch = false
				
				player:startDeathTimer(mapData, miniMap, gui)
				
				player.lastPositionX = player.imageObject.x
				player.lastPositionY = player.imageObject.y	

				player.lastPositionSaved = true
				player.imageObject.linearDamping = 3

				local vx, vy = player.imageObject:getLinearVelocity()
				--print("entry velocity is " .. vx .. ", " .. vy)

				local xf = player.imageObject.x + vx
				local yf = player.imageObject.y + vy

				local distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)

				local moveX = 100 * math.cos(math.acos(vx/distance))
				local moveY = 100 * math.sin(math.asin(vy/distance))

				xf = player.imageObject.x + moveX
				yf = player.imageObject.y + moveY

				--print("player is at " .. player.imageObject.x .. ", " .. player.imageObject.y)
				--print("move the player to this point: " .. xf .. ", " .. yf)

				distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)

				local deltaX, deltaY = 0,0
				deltaX = xf - player.imageObject.x
				deltaY = yf - player.imageObject.y

				local angleX = math.acos(deltaX/distance)
				local angleY = math.asin(deltaY/distance)

				local jumpDirectionX, jumpDirectionY = 0,0
				jumpDirectionX = 10 * math.cos(angleX)
				jumpDirectionY = 10 * math.sin(angleY)

				player.imageObject:setLinearVelocity(0,0)
				player.imageObject:applyForce(jumpDirectionX, jumpDirectionY, player.imageObject.x, player.imageObject.y)

				local function stopPlayer()
					print(">>>>>>>>>>>>> STOPPED DAT NIGGA")
					player.imageObject:setLinearVelocity(0,0)
				end

				timer.performWithDelay(500, stopPlayer)
				
				sinkTrans = transition.to(player.imageObject, {time=3000, alpha=0})

				--transition.to(player.imageObject, {time = 200, x = xf, y = yf})
				--player.imageObject:setLinearVelocity(0,0)
				if waterShadow then
					waterShadow:removeSelf()
					waterShadow = nil
				end
				waterShadow = display.newCircle(player.lastPositionX, player.lastPositionY, 38)
				waterShadow.alpha = 0
				waterShadow.name = "waterShadow"
				gui.front:insert(waterShadow)
				player.lastSavePoint = waterShadow
				player.lastSavePoint.pane = mapData.pane
			end
			waterCount = waterCount + 1
		elseif event.phase == "ended"  then
			if(waterCount > 0) then
				waterCount = waterCount - 1
				player.shook = false
				print("==================== ended collided with water, count: " .. waterCount .. " ===================")
			end
			if ( waterCount == 0 ) and player.onLand then
				print("==================== OUT ended collided with water, count: " .. waterCount .. " ===================")
				player.shook = false
				player:stopDeathTimer()
				gameData.inWater = false
				player.lastPositionSaved = false
				
				if sinkTrans then
					transition.cancel(sinkTrans)
				end
				
				player.imageObject.alpha = 1
				player.imageObject:setLinearVelocity(0,0)
				player.imageObject.linearDamping = 1.25
				gameData.allowPaneSwitch = true
			end
		end
	end
end
]]--
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