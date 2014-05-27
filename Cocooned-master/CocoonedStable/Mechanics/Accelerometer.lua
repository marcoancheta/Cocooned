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
local rayCastCheck = display.newGroup()
local rayCastDistanceCheck = display.newGroup()

-- local lastPointCheck = display.newGroup()
-- local lastPointDistanceCheck = display.newGroup()
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

local function emptyGroup(displayGroup)
	if displayGroup.numChildren > 0 then
		for i = displayGroup.numChildren, 1, -1 do
			displayGroup[i]:removeSelf()
		end
	end
end

--------------------------------------------------------------------------------
-- On Accelerate - function that gathers accelerometer data
--------------------------------------------------------------------------------
-- Updated by: Derrick
-- Previous: Andrew 
--------------------------------------------------------------------------------
local function onAccelerate(event, player)
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
	end
			
	if gameData.inWater == false or gameData.onIceberg == true then
		-- offset the gravity to return
		physicsParam.xGrav = xGrav
		physicsParam.yGrav = yGrav
	elseif gameData.inWater == true then
		-- Freeze accelerometer gravity values
		physicsParam.xGrav = 0
		physicsParam.yGrav = 0
		
		local ball = player.imageObject		
		local degree = 0
		local distanceCheck = 50
		local shoreFound = false
		local rotation = 36
		local degreeAdd = 10
		local foreverCheck = 0
		local lastPoint = player.lastSavePoint
		local useLastPoint = true
		
		-- Accelerometer Shake Event
		if event.isShake and player.shook == false then
			print("TITS")
			emptyGroup(rayCastCheck)
			emptyGroup(rayCastDistanceCheck)
		
			if player.lastSavePoint.moveable then
				useLastPoint = false
			end
			
			while shoreFound == false do
				foreverCheck = foreverCheck + 1
				
				for i = 1, rotation do
					local x = ball.x + (distanceCheck * math.cos(degree * (math.pi/180)))
					local y = ball.y + (distanceCheck * math.sin(degree * (math.pi/180)))
					local hits = physics.rayCast(ball.x, ball.y, x, y, "sorted")
					if ( hits ) then
						-- Output all the results.
						for i,v in ipairs(hits) do
							if v.object.name == "background" or v.object.name == "iceberg" then
								local pointC = display.newCircle(v.position.x, v.position.y, 1)
								pointC.alpha = 0
								pointC.name = v.object.name
								rayCastCheck:insert(pointC)
								rayCastCheck:toFront()
							end
						end					
					end
					degree = degree + degreeAdd
				end
				
				if(distanceCheck >= 200) then
					degreeAdd = 5
					rotation = 72
				end

				degree = 0

				for i = 1, rayCastCheck.numChildren do
					if useLastPoint then
						local pointToSafety = uMath.distance(lastPoint, rayCastCheck[i])
						--print("checking distance: " .. pointToSafety)
						if math.abs(pointToSafety) < 80 then
							shoreFound = true
							break
						end
					end
				end
				
				distanceCheck = distanceCheck + 25
				
				if foreverCheck > 20 then
					--print("you just hit a forever loop, we getting out of here!!")
					break
				end
				
				if shoreFound ~= true then
					emptyGroup(rayCastDistanceCheck)
					emptyGroup(rayCastCheck)
				end
			end
			
			rayCastCheck:toFront()

			local choosePoint = 0
			local minDist = math.huge
			
			for i = 1, rayCastCheck.numChildren do
				local dist
				if useLastPoint then
					dist = uMath.distance(rayCastCheck[i], lastPoint)
					--print("Hit: " .. i .. " " .. rayCastCheck[i].name .. " at position " .. rayCastCheck[i].x .. ", " .. rayCastCheck[i].y .. " distance: " .. dist)
				else
					dist = uMath.distance(rayCastCheck[i], ball)
					--print("Hit: " .. i .. " " .. rayCastCheck[i].name .. " at position " .. rayCastCheck[i].x .. ", " .. rayCastCheck[i].y .. " distance: " .. dist)
				end
				if dist < minDist then
					minDist = dist
					choosePoint = i
				end
			end	

			--print("Go to point : " .. choosePoint .. " at " .. rayCastCheck[choosePoint].x .. ", " .. rayCastCheck[choosePoint].y .. "with distance of " .. minDist)
			rayCastCheck[choosePoint]:setFillColor(0,0,0)
			rayCastCheck[choosePoint]:toFront()

			local pushDistance = uMath.distance(ball, rayCastCheck[choosePoint])
			local straightDistance = uMath.distance(ball, lastPoint)
			local chooseDistance = pushDistance
			local chooseLocation = rayCastCheck[choosePoint]

			if pushDistance > straightDistance and useLastPoint then
				chooseLocation = lastPoint
				chooseDistance = straightDistance
			end
			
			local deltaX = chooseLocation.x - ball.x
			local deltaY = chooseLocation.y - ball.y
			local angleX = math.acos(deltaX/chooseDistance)
			local angleY = math.asin(deltaY/chooseDistance)
			local jumpDirectionX = 20 * math.cos(angleX)
			local jumpDirectionY = 20 * math.sin(angleY)

			accelPlayer[1] = player
			player.shook = true
			ball.linearDamping = 0
			ball:setLinearVelocity(deltaX*3, deltaY*3)
		end
	end
	
	--return physics parameters
	return physicsParam
end

--------------------
-- Commented code --
--------------------
--print("Player last position at : " .. player.lastPositionX .. ", " .. player.lastPositionY)
-- local lpDegree = 0
-- if useLastPoint then
-- 	for i = 1, 36 do
-- 		local x = lastPoint.x + (50 * math.cos(lpDegree * (math.pi/180)))
-- 		local y = lastPoint.y + (50 * math.sin(lpDegree * (math.pi/180)))
-- 		-- local checkCircle = display.newCircle(x, y, 5)
-- 		-- checkCircle:setFillColor(1,0,1)
-- 		-- checkCircle.name = "check"
-- 		-- lastPointDistanceCheck:insert(checkCircle)
-- 		-- lastPointDistanceCheck:toFront()
-- 		local hits = physics.rayCast(lastPoint.x, lastPoint.y, x, y, "sorted")
-- 		if ( hits ) then
-- 		    -- Output all the results.
-- 		    for i,v in ipairs(hits)
-- 		    do
-- 		    	if v.object.name == "background" or v.object.name == "iceberg" then
-- 			    	local pointC = display.newCircle(v.position.x, v.position.y, 10)
-- 			    	pointC:setFillColor(1,1,0)
-- 			    	pointC.name = v.object.name
-- 			    	lastPointCheck:insert(pointC)
-- 			    	lastPointCheck:toFront()
-- 			    end     
-- 		    end					
-- 		else
-- 		    -- There's no hit.
-- 		end
-- 		lpDegree = lpDegree + 10
-- 	end
-- end
-- lastPointCheck:toFront()


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