--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- worldPortalCollision.lua
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
-- Local mapData array clone
local selectWorld = {
	world = gameData.mapData.world,
	levelNum = 0,
	pane = "M",
	version = 0
}
-- Local world array
local world = {"A", "B", "C"}

--------------------------------------------------------------------------------
-- Transition listener function
--------------------------------------------------------------------------------
local function temp(target)
	if gameData.inWorldSelector then
		target:setLinearVelocity(0,0)
		gameData.selectLevel = true
		gameData.inWorldSelector = 0
	end
end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)									
	for i=1, 3 do		
		if collideObject.name == "exitPortal" ..i.. "" then
			-- Stop BGM channel
			sound.stopChannel(3)
			-- Delete all old sound files
			sound.soundClean()	
			-- Load game sound files
			sound.loadGameSounds()
			-- Play BGM according to world choice
			sound.playBGM(sound.backgroundMusic[i])
			-- Disable portal collision
			event.other.isSensor = true
			selectWorld.world = world[i]				
			gameData.mapData.world = selectWorld.world
			player[1].curse = 0
			player[1].xGrav = 0
			player[1].yGrav = 0
			local trans = transition.to(player[1].imageObject, {time=500, alpha=0, x=collideObject.x, y=collideObject.y-20, onComplete = temp} )
		
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local worldPortalCollision = {
	collide = collide
}

return worldPortalCollision
-- end of worldPortalCollision.lua