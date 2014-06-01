--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- waterCollision.lua
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sound")
local animation = require("Core.animation")
local uMath = require("utils.utilMath")
local tutorialLib = require("utils.tutorialLib")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local waterCount = 0
local waterShadow

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
			gameData.inWater = true
			local splashAnim = display.newSprite(animation.sheetOptions.splashSheet, animation.spriteOptions.splash)	
			-- Start splash at player location
			splashAnim.x = player.imageObject.x
			splashAnim.y = player.imageObject.y
			-- Enlarge the size of the splash
			splashAnim:scale(.5, .5)
			splashAnim:setSequence("move")
			splashAnim:play()
			splashAnim:addEventListener( "sprite", endAnimation )

			print("==================== began collided with water, count: " .. waterCount .. " ===================")

			if(waterCount == 0) then
				--check if player is in tutorial level and display water tip
				if gameData.mapData.levelNum == "T" then
					if tutorialLib.tutorialStatus < 3 then
						tutorialLib:showTipBox("waterTip", 2, gui, player)
					end
				end

				player:startDeathTimer(mapData, miniMap, gui)
				gameData.allowPaneSwitch = false
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
				player.sinkTrans = transition.to(player.imageObject, {time=3000, alpha=0})

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
				if player.sinkTrans ~= nil then
					transition.cancel(player.sinkTrans)
					player.sinkTrans = nil
				end
				player.imageObject.alpha = 1
				player.imageObject:setLinearVelocity(0,0)
				player.imageObject.linearDamping = 1.25
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
	if waterShadow then
		waterShadow:removeSelf()
		waterShadow = nil
	end
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