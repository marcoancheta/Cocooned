--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- movement.lua
--------------------------------------------------------------------------------
local sound = require("sound")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local highestSpeed = 0
local count = 0

--------------------------------------------------------------------------------
-- Move and Animate - function that moves player object and animates it
--------------------------------------------------------------------------------
-- Updated by: Derrick - cleaned up loops
-- Last update: Andrew added the force put on a player for use with moveable walls
--------------------------------------------------------------------------------
local function moveAndAnimate(event, currPlayer)
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
		currPlayer.imageObject:applyForce(xForce, yForce,currPlayer.imageObject.x,currPlayer.imageObject.y)
		--if vy == 0 or vx == 0 then
		--	sound.pauseSound(event, sound.rollSnowSound)
		--end
		
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
		elseif speed > 5 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = .25
		else
			currPlayer.imageObject:pause()
		end
	else
		currPlayer.imageObject:pause()
	end

	if (vx ~= 0 or vy ~= 0) and currPlayer.movement == "accel" then
		currPlayer:rotate(vx, vy)
	elseif(currPlayer.xGrav ~= 0 or currPlayer.yGrav ~= 0) then
		currPlayer:rotate(currPlayer.xGrav, currPlayer.yGrav)
	end
	
	--change timescale of animation in relation to speed of ball
	--[[if currPlayer.movement == "accel" then
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
		elseif speed > 5 then
			currPlayer.imageObject:play()
			currPlayer.imageObject.timeScale = .25
		else
			currPlayer.imageObject:pause()
		end
		
	else
		currPlayer.imageObject:pause()
	end]]--
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