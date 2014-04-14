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
local sound = require("sound")
local gameData = require("gameData")
local goals = require("goals")

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	-- Local mapData array clone
	local selectLevel = {
		levelNum = 0,
		pane = "M",
		version = 0
	}

	-- Turn off portal collision (temporarily)
	event.other.isSensor = true
	
	local function resume()
		-- Re-enable portal collision
		event.other.isSensor = false
		ball:setSequence("move");
	end
	
	local function temp()
		ball:setSequence("still")
		local timer = timer.performWithDelay(1000, resume);
	end
						
	local trans = transition.to(ball, {time=1500, x=collideObject.x, y=collideObject.y-15, onComplete = temp} )				
			
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