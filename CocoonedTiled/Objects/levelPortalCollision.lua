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

levelComplete = false

-- Local mapData array clone
local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0
}

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	-- Kipcha Play button detection
	-- If player1 taps silhouette kipcha, start game
	if event.target.name == play.name then	
		------------------------------------------------------------
		-- remove all objects
		------------------------------------------------------------
		-- Destroy goals map
		play:removeEventListener("tap", tapOnce)
		goals.destroyGoals()
		--transition.cancel()
		
		gameData.gameStart = true
	end		
end

--------------------------------------------------------------------------------
-- Create play button and level details
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createLevelPlay(map)
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png", 0, 0, true)
	play.x, play.y = map.tilesToPixels(5, 4)
	play:scale(1.5, 1.5)
	play.name = "playButton"
	
	play:addEventListener("tap", tapOnce)
end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map)
	event.other.isSensor = true
	
	local function resume()
		ball.isBodyActive = true;
		ball:setSequence("move");
	end
	
	local function temp()
		ball.isBodyActive = false;
		ball:setSequence("still")
		local timer = timer.performWithDelay(100, resume); 
		--timer.performWithDelay(500, begin);
	end
						
	local trans = transition.to(ball, {time=1500, x=collideObject.x, y=collideObject.y-15, onComplete = temp} )				
			
	for i=1, 4 do
		if collideObject.name == "exitPortal" ..i.. "" then
			selectLevel.levelNum = ""..i..""
			goals.refresh()
			goals.findGoals(selectLevel)
			createLevelPlay(map)
			gameData.mapData = selectLevel
		end
	end
		
	-- Level unlocked? Then create play button, else do nothing.
	-- Unlock play button for level (i == levelNum+1)
	--if i == 1 or i == 2 or i == 4 then
	--	play.isVisible = true
	--	play:toFront()
	--else
	--	play.isVisible = false
	--end
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