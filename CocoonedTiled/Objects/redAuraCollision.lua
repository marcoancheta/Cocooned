local colorChange = false 
local player = nil

function collide(collideObject, player, event, mapData, map)
	player = player
	event.contact.isEnabled = false
	player:changeColor('red')
	local closure = function() return player:changeColor('white') end
	timer1 = timer.performWithDelay( 5000, closure, 1)
end

local redAuraCollision = {
	collide = collide
}

return redAuraCollision