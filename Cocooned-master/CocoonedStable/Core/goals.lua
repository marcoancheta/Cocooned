--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local generate = require("Objects.generateObjects")
local font = require("utils.font")
local levelNames = require("utils.levelNames")
local stars = require("Core.stars")

---------------------
-- Local variables
---------------------
local textObject = {}
local play, cancel
local playerTemp
local playerTrans
local levelPortalObject
local gStars

--------------------------------------------------------------------------------
-- reenablePortal() - Re-enable portal that player collided with
--------------------------------------------------------------------------------
local function reenablePortal(obj)
	playerTrans = transition.to(playerTemp.imageObject, {time=1000, alpha=1})
	levelPortalObject.isSensor = false
	-- Reset player accelerometer values
	playerTemp.curse = 1
end

--------------------------------------------------------------------------------
-- Button Listeners
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function onPlay(object, player, gui, mapData)
	stars.goalStars(gStars, gui, mapData)

	textObject[1].isVisible = true
	textObject[2].isVisible = true
	textObject[1].alpha = 0.8
	textObject[2].alpha = 1
	-- Hide play and cancel buttons & turn off physics for it
	play.isSensor = false
	play.isVisible = true
	cancel.isVisible = true
	cancel.isSensor = false
	
	levelPortalObject = object	
	--play:addEventListener("tap", tapOnce)
	--cancel:addEventListener("tap", tapOnce)
end

local function hidePlay(playerTemp)
	for i=1, #gStars do
		gStars[i].isVisible = false
	end

	textObject[1].isVisible = false
	textObject[2].isVisible = false
	play.isSensor = true
	play.isVisible = false
	cancel.isVisible = false
	cancel.isSensor = true
	
	playerTrans = transition.to(playerTemp.imageObject, {time=300, x=738, y=522, onComplete=reenablePortal})
	--play:removeEventListener("tap", tapOnce)
	--cancel:removeEventListener("tap", tapOnce)
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	-- Check if player is in game and current scene is not in game options
	if gameData.gameOptions ~= true then
		-- Kipcha Play button detection
		if event.target.name == "playButton" then	
			-- Destroy goals gets called in gameLoop.lua under gameStart
			--destroyGoals()
			playerTrans = transition.to(playerTemp.imageObject, {time=1000, alpha=0, 
										onComplete=function() gameData.gameStart = true; end})
		elseif event.target.name == "cancelButton" then
			print("HIT CANCEL BUTTON!!!!")			
			-- Start timer to re-enable portals
			--local portalTimer = timer.performWithDelay(1500, reenablePortal)
			-- Hide all goal objects
			--textObject[1].isVisible = false
			--textObject[2].isVisible = false
			--play.isVisible = false
			--cancel.isVisible = false
			-- Hide play/cancel buttons and goal texts
			--playerTemp.imageObject.alpha = 0.05
			hidePlay(playerTemp)
			playerTrans = transition.to(playerTemp.imageObject, {time=50, alpha=0})
		end
	end
end


--------------------------------------------------------------------------------
-- destroyGoals - Destroy it all!
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function destroyGoals()
	--print("Destroyed goalie")	
	-- If text objects still exists
	if textObject ~= nil then	
		for i=1, #textObject do
			display.remove(textObject[i])
		end
		
		textObject = nil
	end
	-- If play button still exists
	if play ~= nil then
		play:removeEventListener("tap", tapOnce)
		play:removeSelf()
		play = nil		
	end
	-- If cancel button still exists
	if cancel ~= nil then
		cancel:removeEventListener("tap", tapOnce)
		cancel:removeSelf()
		cancel = nil
	end
	-- clear out playerTrans holder
	if playerTrans ~= nil then
		transition.cancel(playerTrans)
		playerTrans = nil
	end
	
	stars.clean()
end

--------------------------------------------------------------------------------
-- drawGoals - Draw/Insert Objects
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawGoals(gui, player)
	-- Reinitialize arrays
	textObject = {}
	playerTemp = player
	stars.loadScore()
	gStars = stars.initgStars()
	
	-- Goal text displayer
	local text = "Level: "
	
	-- create outer text box rectangle
	textObject[1] = display.newRect(740, 52, 1500, 125)
	textObject[1].x, textObject[1].y = generate.tilesToPixels(20, 3)
	textObject[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1].strokeWidth = 15
	textObject[1].isVisible = false

	textObject[2] = display.newText(text, display.contentCenterX, 85, font.TEACHERA, 72)
	textObject[2]:setFillColor(0,0,0)
	--textObject[2].anchorX = 1
	textObject[2].isVisible = false
	
	-- Create play button
	play = display.newImageRect("mapdata/art/buttons/play.png", 275, 275)
	play.x, play.y  = generate.tilesToPixels(36, 19)
	play.name = "playButton"
	play:addEventListener("tap", tapOnce)
	play.isVisible = false
	play.isBodyActive = false
	
	-- Create cancel button
	cancel = display.newImageRect("mapdata/art/buttons/cancel.png", 275, 275)
	cancel.x, cancel.y = generate.tilesToPixels(5, 19)
	cancel.name = "cancelButton"
	cancel:addEventListener("tap", tapOnce)
	cancel.isVisible = false
	cancel.isBodyActive = false
			
	-- insert objects to display group
	gui.front:insert(textObject[1])
	gui.front:insert(textObject[2])
	gui.front:insert(play)
	gui.front:insert(cancel)
end

--------------------------------------------------------------------------------
-- findGoals - set and adjust goals via their respected level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function findGoals(mapData, gui)
	--local runeAmount = 0
	local tempData = tonumber(mapData.levelNum)
	
	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if tempData then
		print(tempData)
		textObject[2].text = levelNames.names[tempData] --" | Time:"
	end
end

local goals = {
	-- Pass into globals
	drawGoals = drawGoals,
	findGoals = findGoals,
	destroyGoals = destroyGoals,
	onPlay = onPlay,
	hidePlay = hidePlay
}

return goals