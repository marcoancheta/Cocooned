local colorChange = false 
local player = nil
local sound = require("sound")

function collide(collideObject, player, event, mapData, map)
	sound.playSound(event, sound.auraPickupSound)
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