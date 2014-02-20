local highestSpeed = 0
local function moveAndAnimate(player)

	local vx, vy = player.imageObject:getLinearVelocity()
	if player.movement == "accel" then
		--new accelerometer code
		local yForce = 0
		local xForce = 0
		player.xGrav = player.xGrav * player.speedConst
		print(player.speedConst)
		print(player.imageObject.linearDamping)
		player.yGrav = player.yGrav * player.speedConst
		if player.xGrav <= 6 then
			if player.xGrav>= -6 then
				xForce = player.xGrav/6
			else
				xForce = -1
			end
		else
			xForce = 1
		end

		if player.yGrav <= 6 then
			if player.yGrav>= -6 then
				yForce = player.yGrav/6
			else
				yForce = -1
			end
		else
			yForce = 1
		end

		if xForce*vx < 0 and vy <30 then
			xForce = 1.5* xForce
		end
		if yForce*vy <0 and vx <30 then
			yForce= 1.5*yForce
		end
		player.imageObject:applyForce(xForce, yForce,player.imageObject.x,player.imageObject.y)
	end

	if (vx > 0 or vy > 0) and player.movement == "accel" then
		player:rotate(vx, vy)
	else
		if(player.xGrav ~= 0 or player.yGrav ~= 0) then
			player:rotate(player.xGrav, player.yGrav)
		end
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

local movement = {
	 moveAndAnimate = moveAndAnimate,
}

return movement