--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- accelerometer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sound")
local physics = require("physics")
local generate = require("Objects.generateObjects")
local uMath = require("utils.utilMath")
--NOTE: to change gravity for certain objects use object.gravityScale(int) 0= no gravity 1= full gravity

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local highestxgrav = 0
local highestygrav = 0

local physicsParam = {
	xGrav = 0,
	yGrav = 0
}

local accelPlayer = {
	[1] = nil,
	[2] = nil
}

local function emptyGroup(displayGroup)
	if displayGroup.numChildren > 0 then
		for i = displayGroup.numChildren, 1, -1 do
			displayGroup[i]:removeSelf()
		end
	end
end

--------------------------------------------------------------------------------
-- Cancel Death Timer - function that cancels end game from being changed
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
--[[
local function cancelDeathTimer() 
	for i=1, #accelPlayer do
		if accelPlayer[i].movement == "accel" and accelPlayer[i].deathTimer ~= nil then 
			timer.cancel(accelPlayer[i].deathTimer) 
			accelPlayer[i].deathTimer = nil  
			accelPlayer[i].imageObject.linearDamping = 1.25 
			accelPlayer[i].speedConst = accelPlayer[i].defaultSpeed
			--accelPlayer.speedUpTimer = timer.performWithDelay(5000, function() accelPlayer.speedConst = 10 end)
			accelPlayer[i].deathScreen:pause()
			accelPlayer[i].deathScreen:removeSelf()
			accelPlayer[i].deathScreen = nil
		end
	end
end
]]--
--------------------------------------------------------------------------------
-- On Accelerate - function that gathers accelerometer data
--------------------------------------------------------------------------------
-- Updated by: Derrick
-- Previous: Andrew 
--------------------------------------------------------------------------------
local function onAccelerate(event, player, mapData)
	-- Print escape path
	--print(player.escape)
	
	-- Accelerometer Tilt Events	
	local xGrav = 0
	local yGrav = 0

	-- Note: Accelerometer is always relative to the device in portrait orientation
	-- X gravity change
	if event.yInstant > 0.05 then
		xGrav = -event.yInstant
	elseif event.yInstant < -0.05 then
		xGrav = -event.yInstant
	elseif event.yGravity > 0.05 then
		xGrav = -event.yGravity
	elseif event.yGravity < -0.05 then
		xGrav = -event.yGravity
	else
		xGrav = 0
		--sound.pauseSound(1)
	end

	-- Y gravity change
	if event.xInstant > 0.05 then
		yGrav = -event.xInstant
	elseif event.xInstant < -0.05 then
		yGrav = -event.xInstant
	elseif event.xGravity > 0.05 then
		yGrav = -event.xGravity
	elseif event.xGravity < -0.05 then
		yGrav = -event.xGravity
	else
		yGrav = 0
		--sound.stopChannel(2)
	end

	-- Accelerometer Shake Event
	if event.isShake and gameData.inWater == true and player.shook == false then

		-- declare the players Last Save Point
		local lastPoint = player.lastSavePoint

		-- check whether to use that last save point for later calculations
		local useLastPoint = true

		-- if the last point is a movable object, dont use that last save point because its not there anymore since object is moving
		if player.lastSavePoint.moveable or (player.lastSavePoint.pane ~= mapData.pane) then
			useLastPoint = false
		end

		-- check the player surroundsing for a safe location, look for background or iceberg
		local nameCheck = {"background", "iceberg"}
		local rayCastCheck
		if useLastPoint then
			rayCastCheck = uMath.rayCastCircle(player.imageObject, player.lastSavePoint, 50, 300, nameCheck)
		else
			rayCastCheck = uMath.rayCastCircle(player.imageObject, nil, 50, 300, nameCheck)
		end

		-- find which point from rayCast data for the player to travel too
		local choosePoint = 0
		local minDist = math.huge
		for i = 1, rayCastCheck.numChildren do
			local dist
			-- if we use the last point, find the closest point from rayCast data to the last save point
			if useLastPoint then
				dist = uMath.distance(rayCastCheck[i], lastPoint)
			-- if we dont use last point, find the closest point from player to rayCast data
			else
				dist = uMath.distance(rayCastCheck[i], player.imageObject)
			end

			-- if that dist is less that previous saved distance, save which rayCast data point it is
			if dist < minDist then
				minDist = dist
				choosePoint = i
			end
		end	

		-- move chosenPoint to front and make sure it is invisible
		rayCastCheck[choosePoint]:setFillColor(0,0,0)
		rayCastCheck[choosePoint]:toFront()

		-- calculate the distance of player to chosen rayCast point and distance of player to last save point
		local pushDistance = uMath.distance(player.imageObject, rayCastCheck[choosePoint])
		local straightDistance = uMath.distance(player.imageObject, lastPoint)

		-- save which distance to use and which location to move the player too
		local chooseDistance = pushDistance
		local chooseLocation = rayCastCheck[choosePoint]

		-- if the distance from player to rayCast is greater then distance from player to save point and we should use the last save point,
		-- then use the last point at chosen point and use the distance of player to last save point
		if pushDistance > straightDistance and useLastPoint then
			chooseLocation = lastPoint
			chooseDistance = straightDistance
		end

		-- calculate the force to apply to the player to get out of water
		local jumpDirectionX, jumpDirectionY = 0, 0
		jumpDirectionX, jumpDirectionY = uMath.calcDirectionForce(player.imageObject.x, player.imageObject.y, chooseLocation.x, chooseLocation.y, chooseDistance, 20)

		-- set the player variables back to normal
		accelPlayer[1] = player
		player.shook = true
		player.imageObject.linearDamping = 1.25

		-- apply the calculated force onto the player
		player.imageObject:applyForce(jumpDirectionX, jumpDirectionY, player.imageObject.x, player.imageObject.y)

		-- set player alpha back to 1
		player.imageObject.alpha = 1
		
	elseif gameData.inWater == false or gameData.onIceberg == true then
		player.imageObject.alpha = 1
		--sound.playNarration(sound.soundEffects[7])
		-- offset the gravity to return
		physicsParam.xGrav = xGrav
		physicsParam.yGrav = yGrav
	elseif gameData.inWater == true then
		--sound.pauseSound(1)
		physicsParam.xGrav = 0
		physicsParam.yGrav = 0
	end

	--return physics parameters
	return physicsParam
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local accelerometer = {
	onAccelerate = onAccelerate
}

return accelerometer
-- end of accelerometer.lua