--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- levelPortalCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local sound = require("sounds.sound")
local gameData = require("Core.gameData")
local goals = require("Core.goals")

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
	
	local function temp()		
		local timer = timer.performWithDelay(1000, resume);
	end
							
	local trans = transition.to(player.imageObject, {time=1500, x=collideObject.x, y=collideObject.y-15, onComplete = temp} )		
			
	for i=1, 4 do
		if collideObject.name == "exitPortal" ..i.. "" then
			selectLevel.levelNum = ""..i..""
			selectLevel.pane = "M"
			goals.findGoals(selectLevel, gui)
			gameData.mapData = selectLevel
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