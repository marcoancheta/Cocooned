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
	yGrav = 0,
	xRot=0,
	yRot=0,
	coefficient=1
}

-- acceleromter call
local function onAccelerate( event)
	print("accel")
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
	
	-- print('onAccelerate called')

	-- offset the gravity to return
	physicsParam.xGrav=10*xGrav
	physicsParam.yGrav=10*yGrav
	physicsParam.xRot=event.xGravity
	physicsParam.yRot=event.yGravity

	--return physics parameters
	return physicsParam
end


local accelerometer = {
	onAccelerate = onAccelerate
}

return accelerometer
