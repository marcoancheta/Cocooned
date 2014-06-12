--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- levelPortalCollision.lua
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
local selectLevel = {
	world = gameData.mapData.world,
	levelNum = 0,
	pane = "M",
	version = 0
}

local function temp(target)
	if gameData.inLevelSelector then
		target:setLinearVelocity(0,0)
	end
end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)			
	-- Check every portal to see if player has collided
	for i=1, 15 do
		if collideObject.name == "exitPortal" ..i.. "" then
			print("STATUS")
			-- Disable portal collision
			collideObject.isSensor = true
			selectLevel.world = gameData.mapData.world
			selectLevel.levelNum = ""..i..""
			selectLevel.pane = "M"		
			-- Run goals
			goals.onPlay(collideObject, player[1], gui, selectLevel)			
			goals.findGoals(selectLevel, gui)
			-- Transfer selectLevel values to gameData.mapData
			gameData.mapData = selectLevel
			player[1].curse = 0
			player[1].xGrav = 0
			player[1].yGrav = 0
		
			local trans = transition.to(player[1].imageObject, {time=300, alpha=0.75, x=collideObject.x, y=collideObject.y-20, onComplete = temp})
			
			-- Get out of for loop
			--break
		--[[else
			goals.hidePlay()

			if trans then
				transition.cancel(trans)
				trans = nil
			end
		]]--
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local levelPortalCollision = {
	collide = collide
}

return levelPortalCollision
-- end of levelPortalCollision.lua