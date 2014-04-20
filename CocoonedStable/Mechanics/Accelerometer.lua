--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- accelerometer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Cancel Death Timer - function that cancels end game from being changed
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
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

--[[
local function cancelDeathTimer2() 
	if accelPlayer2.movement == "accel" and accelPlayer2.deathTimer ~= nil then 
		timer.cancel(accelPlayer2.deathTimer) 
		accelPlayer2.deathTimer=nil  
		accelPlayer2.imageObject.linearDamping = 1.25 
		accelPlayer2.speedConst = accelPlayer2.defaultSpeed
		--accelPlayer.speedUpTimer = timer.performWithDelay(5000, function() accelPlayer.speedConst = 10 end)
		accelPlayer2.deathScreen:pause()
		accelPlayer2.deathScreen:removeSelf()
		accelPlayer2.deathScreen = nil
	end
end
]]--

--------------------------------------------------------------------------------
-- On Accelerate - function that gathers accelerometer data
--------------------------------------------------------------------------------
-- Updated by: Andrew 
--------------------------------------------------------------------------------
local function onAccelerate(event, player)
	-- Print escape path
	print(player.escape)
		
	-- Accelerometer Shake Event
	if event.isShake and player.movement == "inWater" then
		local ball = player.imageObject
		local xDirection = 0
		local yDirection = 0
		
		accelPlayer[1] = player
		player.shook = true
		
		--[[
		if player.escape == "up" then
			yDirection = -1
		elseif player.escape == "upLeft" then
			yDirection = -1
			xDirection = -1
		elseif player.escape == "upRight" then
			yDirection = -1
			xDirection = 1
		elseif player.escape == "left" then
			xDirection = -1
		elseif player.escape == "right" then
			xDirection = 1
		elseif player.escape == "downRight" then
			xDirection = 1
			yDirection = 1
		elseif player.escape == "down" then
			yDirection = 1
		elseif player.escape == "downLeft" then
			yDirection = 1
			xDirection = -1
		end
		print(.15*xDirection)
		print(.15*yDirection)
		]]--
		
		-- Accelerometer Tilt Events	
		local xGrav = 0
		local yGrav = 0
		
		-- Note: Accelerometer is always relative to the device in portrait orientation
		-- X gravity change
		if event.yInstant > 0.1 then
			xGrav = -event.yInstant
		elseif event.yInstant < -0.1 then
			xGrav = -event.yInstant
		elseif event.yGravity > 0.1 then
			xGrav = -event.yGravity
		elseif event.yGravity < -0.1 then
			xGrav = -event.yGravity
		else
			xGrav = 0
		end

		-- Y gravity change
		if event.xInstant > 0.1 then
			yGrav = -event.xInstant
		elseif event.xInstant < -0.1 then
			yGrav = -event.xInstant
		elseif event.xGravity > 0.1 then
			yGrav = -event.xGravity
		elseif event.xGravity < -0.1 then
			yGrav = -event.xGravity
		else
			yGrav = 0
		end
		
		if yGrav < highestygrav then
			highestygrav = yGrav
		end
		if xGrav < highestxgrav then
			highestxgrav = xGrav
		end
		
		ball:applyLinearImpulse(xGrav, yGrav, ball.x, ball.y)
		timer.performWithDelay(200, cancelDeathTimer)
		
	elseif event.isShake ~= true then
		-- Accelerometer Tilt Events	
		local xGrav = 0
		local yGrav = 0
		
		-- Note: Accelerometer is always relative to the device in portrait orientation
		-- X gravity change
		if event.yInstant > 0.1 then
			xGrav = -event.yInstant
		elseif event.yInstant < -0.1 then
			xGrav = -event.yInstant
		elseif event.yGravity > 0.1 then
			xGrav = -event.yGravity
		elseif event.yGravity < -0.1 then
			xGrav = -event.yGravity
		else
			xGrav = 0
		end

		-- Y gravity change
		if event.xInstant > 0.1 then
			yGrav = -event.xInstant
		elseif event.xInstant < -0.1 then
			yGrav = -event.xInstant
		elseif event.xGravity > 0.1 then
			yGrav = -event.xGravity
		elseif event.xGravity < -0.1 then
			yGrav = -event.xGravity
		else
			yGrav = 0
		end
		
		if yGrav < highestygrav then
			highestygrav = yGrav
		end
		if xGrav < highestxgrav then
			highestxgrav = xGrav
		end
		
		-- offset the gravity to return
		physicsParam.xGrav = xGrav
		physicsParam.yGrav = yGrav
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