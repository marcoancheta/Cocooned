--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- Accelerometer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--NOTE: to change gravity for certain objects use object.gravityScale(int) 0= no gravity 1= full gravity

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local physicsParam = {
	xGrav = 0,
	yGrav = 0
}
local highestxgrav = 0
local highestygrav = 0
local accelPlayer=nil

--------------------------------------------------------------------------------
-- Cancel Death Timer - function that cancels end game from being changed
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function cancelDeathTimer() 
	if accelPlayer.movement == "accel" and accelPlayer.deathTimer ~= nil then 
		print("TIMERCANCELED")
		timer.cancel(accelPlayer.deathTimer) 
		accelPlayer.deathTimer=nil  
		accelPlayer.imageObject.linearDamping = 1 
		accelPlayer.speedConst = 10
		--accelPlayer.speedUpTimer = timer.performWithDelay(5000, function() accelPlayer.speedConst = 10 end)
		accelPlayer.deathScreen:pause()
		accelPlayer.deathScreen:removeSelf()
		accelPlayer.deathScreen = nil
	end
end
--------------------------------------------------------------------------------
-- On Accelerate - function that gathers accelerometer data
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function onAccelerate( event, player)
	accelPlayer = player
	local ball = player.imageObject
	print(player.escape)
	if event.isShake and player.movement == "inWater" then
		local xDirection = 0
		local yDirection = 0
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

		ball:applyLinearImpulse(.15*xDirection,.15*yDirection,ball.x, ball.y )
		player.movement = "accel"
		timer.performWithDelay(100, cancelDeathTimer)
	end

	--print("accel")
	local xGrav=1
	local yGrav=1
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
		highestygrav=yGrav
	end
	if xGrav < highestxgrav then
		highestxgrav=xGrav
	end
	-- offset the gravity to return
	physicsParam.xGrav=xGrav
	physicsParam.yGrav=yGrav
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
