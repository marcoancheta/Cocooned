local highestSpeed = 0
local function moveAndAnimate(player)
	
	local vx, vy = player.imageObject:getLinearVelocity()
	-- check if ball is going the direction of tilt, if so add or subtract a constant to represent acceleration
	--constant = 1/15 = 4/60 = 4 units of speed per second since this is called 60 times per second
	if vx > 0 and player.xGrav > 0 then
		player.sOffsetX = (player.sOffsetX+((1/12)))
	elseif vx < 0 and player.xGrav< 0 then
		player.sOffsetX = (player.sOffsetX+(-1/12))
	else
		player.sOffsetX = 0	
	end

	if vy > 0 and player.yGrav > 0 then
		player.sOffsetY = (player.sOffsetY+(1/20))
	elseif vy < 0 and player.yGrav < 0 then
		player.sOffsetY = (player.sOffsetY+(-1/20))
	else
		player.sOffsetY = 0	
	end
	
	--make sure the phone isn't flat, is it isn't rotate and move it towards the tilt
	if(player.xGrav ~= 0 or player.yGrav ~= 0) then
		player:rotate(player.xGrav, player.yGrav)
		player.imageObject:applyForce(player.xGrav +player.sOffsetX, player.yGrav +player.sOffsetY, player.imageObject.x, player.imageObject.y)
	end
	
	--change timescale of animation in relation to speed of ball
	local speed = math.sqrt((vy*vy)+(vx*vx))
	if speed > highestSpeed then
		highestSpeed=speed
		--print('highestSPEED=', speed)
	end
	if speed > 1125 then
		player.imageObject:play()
		player.imageObject.timeScale = 2.5
	elseif speed > 750 then
		player.imageObject:play()
		player.imageObject.timeScale = 2
	elseif speed >375 then
		player.imageObject:play()
		player.imageObject.timeScale = 1
	elseif speed > 20 then
		player.imageObject:play()
		player.imageObject.timeScale = .5
	else
		player.imageObject:pause()
	end
end


local movement = {
	 moveAndAnimate = moveAndAnimate
}

return movement