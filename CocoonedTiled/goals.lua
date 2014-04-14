--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")

---------------------
-- Local variables
---------------------
local gNum = 1
local goalBox, textBox, box, play
local textObject

-- boxSettings
local bSet = {
		font = nativeSystemfont,
		fontSizeSM = 45,
		fontSizeLG = 55,
		offset = 50,
		offsetLG = 70,
		x = 740,
		y = 50,
		boxX = 10,
		boxY = 88, 
		boxW = 1500,
		boxH = 50,
		boxA = 0.5
	}

-- Load runes
local rune = {
	[1] = display.newImage("mapdata/art/runes/blueRune.png"),
	[2] = display.newImage("mapdata/art/runes/greenRune.png"),
	[3] = display.newImage("mapdata/art/runes/pinkRune.png"),
	[4] = display.newImage("mapdata/art/runes/purpleRune.png"),
	[5] = display.newImage("mapdata/art/runes/yellowRune.png")
}

-- Disable rune visibility
for i=1, #rune do
	rune[i].isVisible = false
end

--------------------------------------------------------------------------------
-- Destroy Goals - Destroy it all!
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function destroyGoals()
	print("Destroyed goalie")	
	
	play = nil;
	goalBox, textBox, box = nil
	textObject, rune = nil
end

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
		destroyGoals()
		
		gameData.gameStart = true
	end		
end

--------------------------------------------------------------------------------
-- Draw Goals - create find goal objects and images
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawGoals(gui, map)
	-- Goal text displayer
	local text = {
		[1] = {
			[1] = "Collect",
			[2] = "runes:",
			[3] = ""
		}
	}
			
	local boxH = bSet.boxH*#text[gNum]
	
	-- Draw the textObjects
	textObject = {}
	
	-- create outer text box rectangle
	textBox = display.newRect(740, 52, bSet.boxW, boxH)
	textBox.x, textBox.y = map.tilesToPixels(22, 3)
	textBox:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textBox:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textBox.strokeWidth = 15
	textBox.alpha = bSet.boxA
		
	for i=1, #text[gNum]-1 do
		if i==1 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-250, bSet.y + 35 + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		elseif i>=2 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-100, bSet.y - 35 + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		end
		textObject[i]:setFillColor(1,1,0)
		textObject[i].anchorX = 21
	end
		
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png", 0, 0, true)
	play.x, play.y = map.tilesToPixels(5, 4)
	play:scale(1.5, 1.5)
	play.name = "playButton"

	play:addEventListener("tap", tapOnce)
		
	-- insert objects to display group
	gui.front:insert(textBox)
	gui.front:insert(play)
	
	for i=1, #textObject do
		gui.front:insert(textObject[i])
	end
end

--------------------------------------------------------------------------------
-- Find Goals - set and adjust goals via their respected level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function findGoals(mapData, gui)
	local xCoord = 720
	local tempData = mapData.levelNum
	local runeAMT = 0
						
	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if tempData == "1" then
		runeAMT = 1
	elseif tempData == "2" then
		runeAMT = 1
	elseif tempData == "3" then
		runeAMT = 3
		--createLevelPlay(map)
	elseif tempData == "4" then
		runeAMT = 4
	else runeAMT = 0
	end

	-- Position and draw in goal displayer
	for i=1, runeAMT do
		rune[i].x = xCoord + 10
		rune[i].y = 90
		rune[i].isVisible = true
		xCoord = xCoord + 50
		gui.front:insert(rune[i])
	end
end

local goals = {
	-- Pass into globals
	findGoals = findGoals,
	drawGoals = drawGoals,
	destroyGoals = destroyGoals
}

return goals