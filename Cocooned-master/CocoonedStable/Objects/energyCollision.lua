--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- energyCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
local plusTime

--------------------------------------------------------------------------------
-- removeObj(target) - Auto deletes plusTime text object when it reaches its destination
--------------------------------------------------------------------------------
local function removeObj(target)
	target:removeSelf()
	target = nil
end

--------------------------------------------------------------------------------
-- Collide Function - remove wisp object if collected
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	-- Disable wisp object collision to allow player to pass thru
	event.contact.isEnabled = false
	-- Play wisp sound effect
	sound.stopChannel(1)
	sound.playSound(sound.soundEffects[8])	
	-- Created text object for wisp collision
	plusTime = display.newText("+:01", collideObject.x, collideObject.y, native.systemFontBold, 55)
	plusTime:setFillColor(0,0,0)
	plusTime:toFront()
	-- Initialize and run transition for plusTime text object
	local wordTrans = transition.to(plusTime, {time=1000, y=collideObject.y-50, onComplete=removeObj})
	-- Add 1 second to global gameTimer
	if gameData.defaultTime > gameData.gameTime then
		gameData.gameTime = gameData.gameTime + 1
	end
	-- Add wisp into player's inventory
	player:addInventory(collideObject)
	-- Delete wisp
 	collideObject:removeSelf()
 	collideObject = nil
end

--------------------------------------------------------------------------------
-- FInish Up
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local energyCollision = {
	collide = collide
}

return energyCollision
-- end of wispCollision.lua