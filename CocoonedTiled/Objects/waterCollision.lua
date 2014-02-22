local gameData = require("gameData")
local sound = require("sound")
gameOver = false


function collide(collideObject, player, event, mapData, map)


	event.contact.isEnabled = false
	player.movement ="inWater"
	player.escape = collideObject.escape
	player:changeColor("white")
	player.cursed = 1
	player.imageObject.linearDamping = 6
	if player.deathTimer == nil then
		audio.stop()
		sound.playSound(event, sound.splashSound)
		player.deathTimer = timer.performWithDelay(5000, function() gameOver = true gameData.gameEnd = true end)
		player.deathScreen = display.newSprite(sheetOptions.deathSheet, spriteOptions.deathAnimation)
		player.deathScreen.x, player.deathScreen.y = 720, 432
		player.deathScreen:setSequence("move")
		player.deathScreen:play()
	end
	

end

local waterCollision = {
	collide = collide
}

return waterCollision