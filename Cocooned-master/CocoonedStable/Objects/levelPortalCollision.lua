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
-- Updated by: Marco
--------------------------------------------------------------------------------
-- Local mapData array clone
local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0
}
--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	-- Disable portal collision
	event.other.isSensor = true
	
	local function resume()
		-- Enable portal collision
		event.other.isSensor = false
	end
	
	local function temp(target)
		if gameData.levelSelector then
			target:setLinearVelocity(0,0)
		end
	end
									
	for i=0, 5 do		
		if i ~= 0 then
			if collideObject.name == "exitPortal" ..i.. "" then
				selectLevel.levelNum = ""..i..""
				selectLevel.pane = "M"				
				goals.onPlay()			
				goals.findGoals(selectLevel, gui)
				gameData.mapData = selectLevel
				player.curse = 0
				player.xGrav = 0
				player.yGrav = 0
				local trans = transition.to(player.imageObject, {time=100, x=collideObject.x, y=collideObject.y, onComplete = temp} )
			end
		else
			goals.hidePlay()
			
			if trans then
				transition.cancel(trans)
				trans = nil
			end
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