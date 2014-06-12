--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- BacktoWorldPortalCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
local goals = require("Core.goals")

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
-- Local world array
--local world = {"A", "B", "C"}

--------------------------------------------------------------------------------
-- Transition listener function
--------------------------------------------------------------------------------
local function temp(target)
	if gameData.inWorldSelector then
		goals.destroyGoals()
		sound.stopChannel(3)
		sound.soundClean()
		sound.loadMenuSounds()
		sound.playSound(sound.backgroundMusic[1])
		gameData.selectWorld = true
	end
end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)									
	if collideObject.name == "worldPortal1" then
		-- Disable portal collision
		event.other.isSensor = true
		local trans = transition.to(player[1].imageObject, {time=500, alpha=0, x=collideObject.x, y=collideObject.y, onComplete = temp} )
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local BacktoWorldPortalCollision = {
	collide = collide
}

return BacktoWorldPortalCollision
-- end of BacktoWorldPortalCollision.lua