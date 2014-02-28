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
		accelPlayer.imageObject.linearDamping = 1.25 
		accelPlayer.speedConst = 10
		--accelPlayer.speedUpTimer = timer.performWithDelay(5000, function() accelPlayer.speedConst = 10 end)
		accelPlayer.deathScreen:pause()
		accelPlayer.deathScreen:removeSelf()
		accelPlayer.deathScreen = nil
	end
end

--------------------------------------------------------------------------------
-- Cancel Death Timer - function that cancels end game from being changed
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------

function moveShadows(map, x, y)

	if x > 0.1  and map.layer["bg"].y < map.layer["hWalls"].sy + 6 then
		map.layer["tiles"].y = map.layer["tiles"].y - 3
		--map.layer["hWalls"].y = map.layer["hWalls"].y + 2
		--map.layer["vWalls"].y = map.layer["vWalls"].y + 1
		map.layer["bg"].y = map.layer["bg"].y + 1
	elseif x < -0.1 and map.layer["bg"].y > map.layer["hWalls"].sy - 6 then
		map.layer["tiles"].y = map.layer["tiles"].y + 3
		--map.layer["hWalls"].y = map.layer["hWalls"].y - 2
		--map.layer["vWalls"].y = map.layer["vWalls"].y - 1
		map.layer["bg"].y = map.layer["bg"].y - 1
	end

	if y > 0.1 and map.layer["bg"].x < (map.layer["vWalls"].sx + 6) then
		map.layer["tiles"].x = map.layer["tiles"].x - 3
		--map.layer["vWalls"].x = map.layer["vWalls"].x + 2
		--map.layer["hWalls"].x = map.layer["hWalls"].x + 1
		map.layer["bg"].x = map.layer["bg"].x + 1
	elseif y < -0.1 and map.layer["bg"].x > (map.layer["vWalls"].sx - 6) then
		map.layer["tiles"].x = map.layer["tiles"].x + 3
		--map.layer["vWalls"].x = map.layer["vWalls"].x - 2
		--map.layer["hWalls"].x = map.layer["hWalls"].x - 1
		map.layer["bg"].x = map.layer["bg"].x - 1
	end
	--[[
	if x > 0  and map.layer["shadows"].y > map.layer["shadows"].sy - 30 then
		map.layer["shadows"].y = map.layer["shadows"].y - 5
	elseif x < 0 and map.layer["shadows"].y < map.layer["shadows"].sy + 30 then
		map.layer["shadows"].y = map.layer["shadows"].y + 5
	end
		
	if y > 0 and map.layer["shadows"].x > (map.layer["shadows"].sx - 30) then
		map.layer["shadows"].x = map.layer["shadows"].x - 5
	elseif y < 0 and map.layer["shadows"].x < (map.layer["shadows"].sx + 30) then
		map.layer["shadows"].x = map.layer["shadows"].x + 5
	end
	]]	
	
end
--------------------------------------------------------------------------------
-- On Accelerate - function that gathers accelerometer data
--------------------------------------------------------------------------------
-- Updated by: Andrew (changed line 76 to be player.shook)
--------------------------------------------------------------------------------

local function onAccelerate( event, player, map)
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
		player.shook = true
		timer.performWithDelay(100, cancelDeathTimer)
	end

	print("accel", event.yGravity*10, event.xGravity*10)
	moveShadows(map, event.xInstant, event.yInstant)

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
