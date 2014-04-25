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
local play
local rune = {}
local textObject = {}

--------------------------------------------------------------------------------
-- destroyGoals - Destroy it all!
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function destroyGoals()
	print("Destroyed goalie")
		
	display.remove(play)
	
	for i=1, #textObject do
		display.remove(textObject[i])
	end
	
	for i=1, #rune do
		display.remove(rune[i])
	end
	
	play = nil;
	rune = nil;
	textObject = nil;
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	-- Kipcha Play button detection
	if event.target.name == play.name then	
		-- Destroy goals map
		destroyGoals()	
		gameData.gameStart = true
	end		
end

local function onPlay(bool)
	if bool then
		play.alpha = 1
		play:addEventListener("tap", tapOnce)
	else
		play.alpha = 0.2
		play:removeEventListener("tap", tapOnce)
	end
end

--------------------------------------------------------------------------------
-- drawGoals - Draw/Insert Objects
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawGoals(gui)
	-- Reinitialize arrays
	textObject = {}
	rune = {}

	-- Initial rune x-coordinate
	local xCoord = 310
	-- Load rune file locations
	local runeLoc = {
		[1] = "mapdata/art/runes/blueRune.png",
		[2] = "mapdata/art/runes/greenRune.png",
		[3] = "mapdata/art/runes/pinkRune.png",
		[4] = "mapdata/art/runes/purpleRune.png",
		[5] = "mapdata/art/runes/yellowRune.png"
	}
		
	-- Load runes
	for i=1, #runeLoc do
		rune[i] = display.newImage(runeLoc[i])
		rune[i]:scale(0.5, 0.5)
		rune[i].x = xCoord
		rune[i].y = 35
		xCoord = xCoord + 35
		
		-- Hide runes (visually)
		rune[i].isVisible = false
		-- Insert to display group
		gui.front:insert(rune[i])
	end
		
	-- create outer text box rectangle
	textObject[1] = display.newRect(240, 30, 550, 50)
	textObject[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textObject[1].strokeWidth = 15
	textObject[1].alpha = 0.5

	textObject[2] = display.newText("Collect runes: ", 300, 30, nativeSystemfont, 25)
	textObject[2]:setFillColor(0,0,0)
	textObject[2].anchorX = 21
	
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png", 0, 0, true)
	play.x, play.y = generate.tilesToPixels(1, 1.5)
	play:scale(0.8, 0.8)
	play.alpha = 0.2
	play.name = "playButton"
			
	-- insert objects to display group
	
	for i=1, #textObject do
		gui.front:insert(textObject[i])
	end

	gui.front:insert(play)
	
	return play
end

--------------------------------------------------------------------------------
-- findGoals - set and adjust goals via their respected level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function findGoals(mapData, gui)
	local runeAmount = 0
	local tempData = mapData.levelNum
		
	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if tempData == "1" then
		runeAmount = 1
	elseif tempData == "2" then
		runeAmount = 1
	elseif tempData == "3" then
		runeAmount = 3
	elseif tempData == "4" then
		runeAmount = 4
	end
		
	if rune then
		for i=1, #rune do
			rune[i].isVisible = false
		end
		for i=1, runeAmount do
			rune[i].isVisible = true
		end
	end
end

local goals = {
-- Pass into globals
	drawGoals = drawGoals,
	findGoals = findGoals,
	destroyGoals = destroyGoals,
	onPlay = onPlay
}

return goals