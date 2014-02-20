--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- Accelerometer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- accelerometer movement
--TODO: change class parameters to take in object and intensity? -negative if backwards?
--to change gravity for certain objects use object.gravityScale(int) 0= no gravity 1= full gravity

-- data for acceleromter to return
local physicsParam = {
	xGrav = 0,
	yGrav = 0
}
local highestxgrav = 0
local highestygrav = 0


-- acceleromter call
local function onAccelerate( event, player)
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

		ball:applyLinearImpulse(.25*xDirection,.25*yDirection,ball.x, ball.y )
		accelTimer = timer.performWithDelay(500, function() player.movement = "accel" player.imageObject.linearDamping = 1 player.speedConst = 5 end)
		speedTmer= timer.performWithDelay(5000, function() player.speedConst = 10 end)
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


local accelerometer = {
	onAccelerate = onAccelerate
}

return accelerometer
