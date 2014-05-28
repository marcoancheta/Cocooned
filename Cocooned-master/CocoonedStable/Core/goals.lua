--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local generate = require("Objects.generateObjects")
local font = require("utils.font")

---------------------
-- Local variables
---------------------
local textObject = {}
local play, cancel
local playerTemp
local levelPortalObject

--------------------------------------------------------------------------------
-- reenablePortal() - Re-enable portal that player collided with
--------------------------------------------------------------------------------
local function reenablePortal()
	levelPortalObject.isSensor = false
end

--------------------------------------------------------------------------------
-- Button Listeners
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function onPlay(object)
	textObject[1].isVisible = true
	textObject[2].isVisible = true
	textObject[1].alpha = 0.8
	textObject[2].alpha = 1
	-- Hide play and cancel buttons & turn off physics for it
	play.isVisible = true
	play.isBodyActive = true
	cancel.isVisible = true
	cancel.isBodyActive = true
	
	levelPortalObject = object
	
	--play:addEventListener("tap", tapOnce)
	--cancel:addEventListener("tap", tapOnce)
end

local function hidePlay()
	textObject[1].isVisible = false
	textObject[2].isVisible = false
	play.isVisible = false
	play.isBodyActive = false
	--play:removeEventListener("tap", tapOnce)
	cancel.isVisible = false
	cancel.isBodyActive = false
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
			-- Destroy goals map
			--destroyGoals()
			gameData.gameStart = true
		elseif event.target.name == "cancelButton" then
			print("HIT CANCEL BUTTON!!!!")
			-- Hide play/cancel buttons and goal texts
			hidePlay()		
			local portalTimer = timer.performWithDelay(1500, reenablePortal)
			textObject[1].isVisible = false
			textObject[2].isVisible = false
			play.isVisible = false
			cancel.isVisible = false
			playerTemp.curse = 1
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
	
	-- Different than levelNames.lua
	local levelNames = {"Avalon", "Cittàgazze", "Lake Wobegon", "Waterdeep", "Rivendell", 
						"Middle Earth", "Cabot Cove", "Fish Hell", "Gormenghast", "Emerald City",	
						"Kakariko Village", "Middlemarch", "Castle Rock", "Middlemarch", "Santa Teresa"}

	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if tempData then
		print(tempData)
		textObject[2].text = levelNames[tempData] --" | Time:"
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