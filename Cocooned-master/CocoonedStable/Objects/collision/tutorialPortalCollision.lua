--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- tutorialPortalCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local sound = require("sound")
local gameData = require("Core.gameData")
local goals = require("Core.goals")
local tutorialLib = require("utils.tutorialLib")

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Local mapData array clone
local selectLevel = {
	world = gameData.mapData.world,
	levelNum = 0,
	pane = "M",
	version = 0
}

local function temp(target)
	if gameData.inWorldSelector then
		gameData.inWorldSelector = 0
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
	
	print("You hit a tutorial level")
	-- Disable portal collision
	collideObject.isSensor = true
	selectLevel.world = gameData.mapData.world
	selectLevel.levelNum = "T"
	selectLevel.pane = "M"		
	-- Run goals
	goals.onPlay(collideObject, player, gui, selectLevel)			
	goals.findGoals(selectLevel, gui)
	-- Transfer selectLevel values to gameData.mapData
	gameData.mapData = selectLevel
	player.curse = 0
	player.xGrav = 0
	player.yGrav = 0

	local trans = transition.to(player.imageObject, {time=300, alpha=0.75, x=collideObject.x, y=collideObject.y-20, onComplete = temp})
	
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