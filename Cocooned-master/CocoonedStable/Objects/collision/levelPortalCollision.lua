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

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)	
	--local function resume()
		-- Enable portal collision
	--	event.other.isSensor = false
	--end

	local function temp(target)
		if gameData.inLevelSelector then
			target:setLinearVelocity(0,0)
		end
	end
			
	-- Check every portal to see if player has collided
	for i=1, 15 do
		if collideObject.name == "exitPortal" ..i.. "" then
			-- Disable portal collision
			collideObject.isSensor = true
			selectLevel.world = gameData.mapData.world
			selectLevel.levelNum = ""..i..""
			selectLevel.pane = "M"		
			-- Run goals
			goals.onPlay(collideObject)			
			goals.findGoals(selectLevel, gui)
			-- Transfer selectLevel values to gameData.mapData
			gameData.mapData = selectLevel
			player.curse = 0
			player.xGrav = 0
			player.yGrav = 0
			local trans = transition.to(player.imageObject, {time=100, x=collideObject.x, y=collideObject.y, onComplete = temp} )
			break
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