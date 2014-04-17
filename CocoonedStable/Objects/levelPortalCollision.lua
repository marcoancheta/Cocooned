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
local generate = require("Loading.generateObjects")
local play 

local levelComplete = false
local guiClone = display.newGroup()

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
		play:removeSelf();
		play = nil;
		goals.destroyGoals(guiClone)
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
	play.x, play.y = generate.tilesToPixels(5, 4)
	play:scale(1.5, 1.5)
	play.name = "playButton"
	
	play:addEventListener("tap", tapOnce)
end

--------------------------------------------------------------------------------
-- Collide Function - end game if exit portal is active
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)
	event.other.isSensor = true
	
	local function resume()
		event.other.isSensor = false
	end
	
	local function temp()
		player.imageObject.isBodyActive = false;
		player.imageObject:setSequence("still")
		local timer = timer.performWithDelay(1000, resume);
		--timer.performWithDelay(500, begin);
		player.imageObject.isBodyActive = true;
		player.imageObject:setSequence("move");
	end
						
	local trans = transition.to(player.imageObject, {time=300, x=collideObject.x, y=collideObject.y-15, onComplete = temp} )
	player.GravX = 0
	player.GravY = 0				
			
	for i=1, 4 do
		if collideObject.name == "exitPortal" ..i.. "" then
			selectLevel.levelNum = ""..i..""
			selectLevel.pane = "M"
			--goals.refresh(gui)
			guiClone = goals.findGoals(selectLevel, gui, map)
			createLevelPlay(map)
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