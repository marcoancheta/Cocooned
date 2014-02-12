local highestSpeed = 0
local function moveAndAnimate(player)
	
	local vx, vy = player.imageObject:getLinearVelocity()
	--[[
	local inX = false -- same direction as last frame?
	local inY = false 
	local linearOffset = 0
	-- check if ball is going the direction of tilt, if so add or subtract a constant to represent acceleration
	--constant = 1/10 = 3/30 = 3 units of speed per second since this is called 30 times per second
	if vx > 0 and player.xGrav > 0 then
		player.sOffsetX = (player.sOffsetX+((1/10)))
		inX = true
	elseif vx < 0 and player.xGrav< 0 then
		player.sOffsetX = (player.sOffsetX+(-1/10))
		inX = true
	else
		player.sOffsetX = 0	
		inX = false
	end

	if vy > 0 and player.yGrav > 0 then
		player.sOffsetY = (player.sOffsetY+(1/10))
		inY = true
	elseif vy < 0 and player.yGrav < 0 then
		player.sOffsetY = (player.sOffsetY+(-1/10))
		inY = true
	else
		player.sOffsetY = 0	
		inY = false
	end

	if player.xGrav > 0 or player.yGrav > 0 then
		linearOffset = (math.sqrt((player.yGrav*player.yGrav)+(physicsParam.yGrav*physicsParam.yGrav)))
		if linearOffset > 1.8 then
			linearOffset = 1.8
		end
		--player.imageObject.linearDamping=4-linearOffset
		if inY == false and inX == false then
			--player.imageObject.linearDamping=4
		end
	else
		--player.imageObject.linearDamping=4
	end
	
	--make sure the phone isn't flat, is it isn't rotate and move it towards the tilt   +player.sOffsetX +player.sOffsetY
	if(player.xGrav ~= 0 or player.yGrav ~= 0) then
		
		
		player.imageObject:applyForce(4*player.xGrav, 4*player.yGrav, player.imageObject.x, player.imageObject.y)
	end
	--]]
	local yForce = 0
	local xForce = 0
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

	if xForce*vx < 0 then
		xForce = 2* xForce
	end
	if yForce*vy <0 then
		yForce= 2*yForce
	end
	

	if(player.xGrav ~= 0 or player.yGrav ~= 0) then
		if (vx > 10 or vy >10) then
			--player:rotate(vx, vy)
		else
			--player:rotate(player.xGrav, player.yGrav)
		end
		player.imageObject:applyForce(xForce, yForce,player.imageObject.x,player.imageObject.y)
	end
	--change timescale of animation in relation to speed of ball
	local speed = math.sqrt((vy*vy)+(vx*vx))
	--[[
	if speed > 1200 then
		player.imageObject:play()
		player.imageObject.timeScale = 3
	elseif speed > 900 then
		player.imageObject:play()
		player.imageObject.timeScale = 2.5
	elseif speed >600 then
		player.imageObject:play()
		player.imageObject.timeScale = 2
	elseif speed > 300 then
		player.imageObject:play()
		player.imageObject.timeScale = 1.5
	elseif speed > 50 then
		player.imageObject:play()
		player.imageObject.timeScale = .5
	else
		player.imageObject:pause()
	end
	]]
end


local movement = {
	 moveAndAnimate = moveAndAnimate
}

return movement