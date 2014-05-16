--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local generate = require("Loading.generateObjects")
---------------------
-- Local variables
---------------------
local play, cancel
--local rune = {}
local textObject = {}
local playerTemp
--------------------------------------------------------------------------------
-- destroyGoals - Destroy it all!
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function destroyGoals()
	--print("Destroyed goalie")
			
	for i=1, #textObject do
		display.remove(textObject[i])
	end
	
	--[[for i=1, #rune do
		display.remove(rune[i])
	end
	]]--
	
	play:removeSelf()
	play = nil;
	
	--rune = nil;
	textObject = nil;
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	-- Kipcha Play button detection
	if event.target.name == "playButton" then	
		-- Destroy goals map
		destroyGoals()	
		gameData.gameStart = true
	elseif event.target.name == "cancelButton" then
		--
		textObject[1].alpha = 0
		textObject[2].alpha  = 0
		play.alpha = 0
		cancel.alpha = 0
		--for i=1, #rune do
		--	rune[i].isVisible = false
		--end
		playerTemp.curse = 1
	end		
end

local function onPlay()
	textObject[1].alpha = 0.8
	textObject[2].alpha  = 1
	play.alpha = 1
	play:addEventListener("tap", tapOnce)
	cancel.alpha = 1
	cancel:addEventListener("tap", tapOnce)
end

local function hidePlay()
	play.alpha = 0
	play:removeEventListener("tap", tapOnce)
	cancel.alpha = 0
	cancel:addEventListener("tap", tapOnce)
end

--------------------------------------------------------------------------------
-- drawGoals - Draw/Insert Objects
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawGoals(gui, player)
	-- Reinitialize arrays
	textObject = {}
	--rune = {}

	print(player.name)
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
	textObject[1].alpha = 0

	textObject[2] = display.newText(text, display.contentCenterX, 85, nativeSystemfont, 72)
	textObject[2]:setFillColor(0,0,0)
	--textObject[2].anchorX = 1
	textObject[2].alpha = 0
	
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png")
	play.x, play.y = generate.tilesToPixels(5, 20)
	play:scale(1.5, 1.5)
	play.alpha = 0
	play.name = "playButton"

	cancel = display.newImage("mapdata/art/buttons/cancel.png")
	cancel.x, cancel.y = generate.tilesToPixels(35, 20)
	cancel:scale(1, 1)
	cancel.alpha = 0
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
	
	local levelNames = {"Lake Wobegon", "Atlantis", "Skull Island",
						"Jurassic Park", "Rivendell", "Middle Earth",
						"Zion", "Fish Hell", "Astropolis", "Emerald City",
						"South Park", "Bedrock", "Castle Rock", "King's Landing",
						"Kakariko Village", "Avalon", "Waterdeep", "Cittàgazze",
						"Middlemarch", "Cabot Cove", "Avonlea", "Gormenghast", 
						"Temple of Doom", "Santa Teresa", "R'lyeh"}
	
	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if tempData then
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