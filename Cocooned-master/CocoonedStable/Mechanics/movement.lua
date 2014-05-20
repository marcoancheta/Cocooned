--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- movement.lua
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
local particle_lib = require("utils.particleEmitter")
-- variable for miniMap mechanic for previous tap time
local Random = math.random
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local highestSpeed = 0
local count = 0
local speed = 0

local duration = 500
local speed = 10
local density = 1
local range = 50
local thickness = 100

local snowEmitter = emitterLib:createEmitter(range, thickness, duration, 1, 0, nil, nil, nil)

--------------------------------------------------------------------------------
-- Move and Animate - function that moves player object and animates it
--------------------------------------------------------------------------------
-- Updated by: Derrick - cleaned up loops
-- Last update: Andrew added the force put on a player for use with moveable walls
--------------------------------------------------------------------------------
local function moveAndAnimate(event, currPlayer, gui) --, physics
	--print(currPlayer)
	
	local vx, vy = currPlayer.imageObject:getLinearVelocity()
	local speed = math.sqrt((vy*vy)+(vx*vx))
	
	if currPlayer.movement == "accel" then
		--print("moving")				
		local yForce = 0
		local xForce = 0
		currPlayer.xGrav = currPlayer.xGrav * (currPlayer.speedConst)
		currPlayer.yGrav = currPlayer.yGrav * (currPlayer.speedConst)
		if currPlayer.xGrav <= currPlayer.maxSpeed then
			if currPlayer.xGrav>= currPlayer.maxSpeed*-1 then
				xForce = currPlayer.xGrav/currPlayer.maxSpeed
			else
				xForce = -1
			end
		else
			xForce = 1
		end

		if currPlayer.yGrav <= currPlayer.maxSpeed then
			if currPlayer.yGrav >= currPlayer.maxSpeed*-1 then
				yForce = currPlayer.yGrav/currPlayer.maxSpeed
			else
				yForce = -1
			end
		else
			yForce = 1
		end

		if xForce * vx < 0 and vy < 30 then
			xForce = 1.5 * xForce
		end
		if yForce * vy < 0 and vx < 30 then
			yForce = 1.5 * yForce
		end
		
		currPlayer.xForce = xForce
		currPlayer.yForce = yForce
		
		if gameData.inWater == false then
			currPlayer.imageObject:applyForce(xForce, yForce,currPlayer.imageObject.x,currPlayer.imageObject.y)
		end
		
		-- snow trail particle effect
 		local velX, velY = currPlayer.imageObject:getLinearVelocity()
 
 		if velX ~= 0 and velY ~= 0 then
 			local angle = math.atan2(velX, velY)*(180/math.pi)
 			local offSet = math.random(-15, 15)
 			snowEmitter:setAngle(angle + offSet)
 			local offSet1 = math.random(-10, 10)
 			local offSet2 = math.random(-10, 10)
 			snowEmitter:emit(gui, currPlayer.imageObject.x + offSet1, currPlayer.imageObject.y + offSet2)
 		end


		if speed > 1125 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = 2.5
		elseif speed > 600 then
			--local delay = timer.performWithDelay(4000, sound.playEventSound, 0)
			--delay.params = {params1 = event, params2 = sound.rollSnowSound}
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = 2
		elseif speed > 300 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = 1.5
		elseif speed > 30 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = .5
		elseif speed > 10 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = .25
		else
			currPlayer.imageObject:pause()
		end
	else
		currPlayer.imageObject:pause()
	end
	-- if player has an aura, show aura particles else hide it
	currPlayer:updateAura()

	--rotate player based on velocity if player is moving, else rotate based on accelerometer
	if (vx > 10 or vy > 10) and currPlayer.movement == "accel" then
		currPlayer:rotate(vx, vy)
	elseif(currPlayer.xGrav ~= 0 or currPlayer.yGrav ~= 0) then
		currPlayer:rotate(currPlayer.xGrav, currPlayer.yGrav)
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local movement = {
	 moveAndAnimate = moveAndAnimate,
}

return movement
-- end of movement.lua