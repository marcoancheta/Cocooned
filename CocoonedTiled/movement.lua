--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- movement.lua
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local sound = require("sound")
local highestSpeed = 0
local count = 0


--------------------------------------------------------------------------------
-- Move and Animate - function that moves player object and animates it
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function moveAndAnimate(player)
	local vx, vy = player.imageObject:getLinearVelocity()
	if count == 0 then
		sound.playSound(event, sound.rollSnowSound)
		count = count + 1
	end
	if player.movement == "accel" then
		print("moving")
		local yForce = 0
		local xForce = 0
		player.xGrav = player.xGrav * (player.speedConst)
		player.yGrav = player.yGrav * (player.speedConst)
		if player.xGrav <= player.maxSpeed then
			if player.xGrav>= player.maxSpeed*-1 then
				xForce = player.xGrav/player.maxSpeed
			else
				xForce = -1
			end
		else
			xForce = 1
		end

		if player.yGrav <= player.maxSpeed then
			if player.yGrav >= player.maxSpeed*-1 then
				yForce = player.yGrav/player.maxSpeed
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
		player.imageObject:applyForce(xForce, yForce,player.imageObject.x,player.imageObject.y)
		--if vy == 0 or vx == 0 then
		--	sound.pauseSound(event, sound.rollSnowSound)
		--end
	end

	if (vx ~= 0 or vy ~= 0) and player.movement == "accel" then
		player:rotate(vx, vy)
	elseif(player.xGrav ~= 0 or player.yGrav ~= 0) then
		player:rotate(player.xGrav, player.yGrav)
	end
	
	--change timescale of animation in relation to speed of ball
	local speed = math.sqrt((vy*vy)+(vx*vx))
	if player.movement == "accel" then
		if speed > 1125 then
			player.imageObject:play()
			player.imageObject.timeScale = 2.5
		elseif speed >600 then
			player.imageObject:play()
			player.imageObject.timeScale = 2
		elseif speed > 300 then
			player.imageObject:play()
			player.imageObject.timeScale = 1.5
		elseif speed >30 then
			player.imageObject:play()
			player.imageObject.timeScale = .5
		elseif speed > 5 then
			player.imageObject:play()
			player.imageObject.timeScale = .25
		else
			player.imageObject:pause()
		end
	else
		player.imageObject:pause()
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