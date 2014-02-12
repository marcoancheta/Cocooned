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
local function onAccelerate( event)
	--print("accel")
	local xGrav=1
	local yGrav=1
	-- X gravity change
	if event.yInstant > 0.05 then
		--print("POSyinstant=", event.yInstant)
		xGrav = -event.yInstant
	elseif event.yInstant < -0.05 then
		--print("NEGyinstant=", event.yInstant)
		xGrav = -event.yInstant
	elseif event.yGravity > 0.05 then
		--print("POSGRAV", event.yGravity)
		xGrav = -event.yGravity
	elseif event.yGravity < -0.05 then
		--print("NEGGRAV=", event.yGravity)
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
	if yGrav < highestygrav then
		highestygrav=yGrav
	end
	if xGrav < highestxgrav then
		highestxgrav=xGrav
	end
	print('highestygrav=', highestygrav)
	print('highestxgrav=', highestxgrav)
	
	-- print('onAccelerate called')

	-- offset the gravity to return
	physicsParam.xGrav=10*xGrav
	physicsParam.yGrav=10*yGrav

	--return physics parameters
	return physicsParam
end


local accelerometer = {
	onAccelerate = onAccelerate
}

return accelerometer
