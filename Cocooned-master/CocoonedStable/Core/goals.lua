--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local generate = require("Objects.generateObjects")
---------------------
-- Local variables
---------------------
local play, cancel
--local rune = {}
local textObject = {}
local playerTemp
local levelPortalObject

--------------------------------------------------------------------------------
-- destroyGoals - Destroy it all!
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function destroyGoals()
	--print("Destroyed goalie")
	
	if textObject then	
		for i=1, #textObject do
			display.remove(textObject[i])
		end
	end
		
	--[[for i=1, #rune do
		display.remove(rune[i])
	end
	]]--
	
	if play then
		play:removeSelf()
		play = nil
		
	end
	if cancel then
		cancel:removeSelf()
		cancel = nil
	end
	
	--rune = nil;
	textObject = nil
end

local function reenablePortal()
	levelPortalObject.isSensor = false
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	if gameData.gameOptions ~= true then
		-- Kipcha Play button detection
		if event.target.name == "playButton" then	
			-- Destroy goals map
			destroyGoals()	
			gameData.gameStart = true
		elseif event.target.name == "cancelButton" then
			print("HIT CANCEL BUTTON!!!!")

			textObject[1].isVisible = false
			textObject[2].isVisible = false
			play.isVisible = false
			cancel.isVisible = false
			--for i=1, #rune do
			--	rune[i].isVisible = false
			--end
			playerTemp.curse = 1
			destroyGoals()
			timer.performWithDelay(1500, reenablePortal)
		end
	end
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
	play.isVisible = true
	play:addEventListener("tap", tapOnce)
	cancel.isVisible = true
	cancel:addEventListener("tap", tapOnce)
	levelPortalObject = object
end

local function hidePlay()
	textObject[1].isVisible = false
	textObject[2].isVisible = false
	play.isVisible = false
	play:removeEventListener("tap", tapOnce)
	cancel.isVisible = false
	cancel:removeEventListener("tap", tapOnce)
end
--------------------------------------------------------------------------------
-- drawGoals - Draw/Insert Objects
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawGoals(gui, player)
	destroyGoals()
	-- Reinitialize arrays
	textObject = {}
	--rune = {}

	playerTemp = player

	-- Goal text displayer
	local text = "Level: "
	-- Load rune file locations
	--[[
	local runeLoc = {
		[1] = "mapdata/art/runes/blueRune.png",
		[2] = "mapdata/art/runes/greenRune.png",
		[3] = "mapdata/art/runes/pinkRune.png",
		[4] = "mapdata/art/runes/purpleRune.png",
		[5] = "mapdata/art/runes/yellowRune.png"
	}
	]]--
	
	-- create outer text box rectangle
	textObject[1] = display.newRect(740, 52, 1500, 125)
	textObject[1].x, textObject[1].y = generate.tilesToPixels(20, 3)
	textObject[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1].strokeWidth = 15
	textObject[1].isVisible = false

	textObject[2] = display.newText(text, display.contentCenterX, 85, nativeSystemfont, 72)
	textObject[2]:setFillColor(0,0,0)
	--textObject[2].anchorX = 1
	textObject[2].isVisible = false
	
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png")
	play.x, play.y = generate.tilesToPixels(5, 20)
	play:scale(1.5, 1.5)
	play.isVisible = false
	play.name = "playButton"

	cancel = display.newImage("mapdata/art/buttons/cancel.png")
	cancel.x, cancel.y = generate.tilesToPixels(35, 20)
	cancel:scale(1, 1)
	cancel.isVisible = false
	cancel.name = "cancelButton"
			
	-- insert objects to display group
	gui.front:insert(textObject[1])
	gui.front:insert(textObject[2])
	gui.front:insert(play)
	gui.front:insert(cancel)
	
	-- Load runes
	-- Initial rune x-coordinate
	--[[
	local xCoord = textObject[2].x + 280
	for i=1, #runeLoc do
		rune[i] = display.newImage(runeLoc[i])
		rune[i].x = xCoord + 50
		rune[i].y = 90
		xCoord = xCoord + 50
		
		-- Hide runes (visually)
		rune[i].isVisible = false
		-- Insert to display group
		gui.front:insert(rune[i])
	end
	]]--
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
	
	
	--[[
	if tempData == "1" then
		--runeAmount = 1
		textObject[2].text = "Level: " .. tempData .. ""--" | Time:"
	elseif tempData == "2" then
		--runeAmount = 3
		textObject[2].text = "Level: " .. tempData .. ""--" | Time:"
	elseif tempData == "3" then
		--runeAmount = 1
		textObject[2].text = "Level: " .. tempData .. ""--" | Time:"
	elseif tempData == "4" then
		--runeAmount = 1
		textObject[2].text = "Level: " .. tempData .. ""--" | Time:"
	end
	]]--
	--[[
	if rune then
		for i=1, #rune do
			rune[i].isVisible = false
		end
		if runeAmount then
			rune[runeAmount].isVisible = true
		end
	end
	]]--
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