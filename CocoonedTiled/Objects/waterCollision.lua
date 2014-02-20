
local sound = require("sound")
function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.splashSound)
	event.contact.isEnabled = false
	player.movement ="inWater"
	player.escape = collideObject.escape
	player:changeColor("white")
	player.cursed = 1
	player.imageObject.linearDamping = 6
	--deathTimer= timer.performWithDelay(5000, function() gameData.endGame = true end)
	--[[
	player.imageObject.linearDamping = 0
	if player.movement=="inWater" then
		
		--player.imageObject.linearDamping = 0
		accelTimer = timer.performWithDelay(800, function() player.movement = "accel" playe r.imageObject.linearDamping = 1 player.speedConst = 5 end)
		speedTmer= timer.performWithDelay(5000, function() player.speedConst = 10 end)
	else
		player.movement="inWater"
		player.speedConst = 1
		local vx, vy =  player.imageObject:getLinearVelocity()
		if vx >300 or vy > 300 then
			player.imageObject:setLinearVelocity(vx/30, vy/30)
		end
		--timer.performWithDelay(1, function() player.imageObject.linearDamping = 0 end)
	end
	--when out of water do 
		--accelTimer = timer.performWithDelay(100, function() player.movement = "accel" player.imageObject.linearDamping = 1 player.speedConst = 5 end)
		--speedTmer= timer.performWithDelay(5000, function() player.speedConst = 10 end)
		]]


end

local waterCollision = {
	collide = collide
}

return waterCollision