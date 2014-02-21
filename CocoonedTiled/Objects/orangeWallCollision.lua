local gameData = require("gameData")

function dissolve(event)
	local params = event.source.params
	display.remove(params.param1)
end

function collide(collideObject, player, event, mapData, map)
	print("got to orange wall collision")
	--event.contact.isEnabled = false
	
	if player.breakable then
		local timeIT = timer.performWithDelay(1000, dissolve)
		timeIT.params = {param1 = collideObject}
	end
end

local orangeWallCollision = {
	collide = collide
}

return orangeWallCollision