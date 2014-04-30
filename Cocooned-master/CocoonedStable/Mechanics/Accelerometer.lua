--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- accelerometer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sound")
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
local function onAccelerate(event, player)
	-- Print escape path
	--print(player.escape)
		
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
		sound.pauseSound(2)
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
		sound.pauseSound(2)
	end
		
	if yGrav < highestygrav then
		highestygrav = yGrav
	end
	if xGrav < highestxgrav then
		highestxgrav = xGrav
	end
		
	-- Accelerometer Shake Event
	if event.isShake and gameData.inWater == true then	
		local ball = player.imageObject		
		accelPlayer[1] = player
		player.shook = true
		ball:applyLinearImpulse(-xGrav * 0.15, -yGrav * 0.15, ball.x, ball.y)
		--timer.performWithDelay(100, cancelDeathTimer)
	elseif gameData.inWater == false then
		-- offset the gravity to return
		physicsParam.xGrav = xGrav
		physicsParam.yGrav = yGrav
		-- ball rolling sound
		sound.resumeSound(2)
		sound.playNarration(sound.soundEffects[7])
	else
		--sound.pauseSound(2)
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