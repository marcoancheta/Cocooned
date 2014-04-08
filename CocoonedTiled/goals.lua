--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- goals.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")

local goals = {}

---------------------
-- Local variables
---------------------
local gNum = 1
local goalBox, textBox, box, coin
local textObject
local bSet
local goalie

-- Draw/Insert Objects
local function drawGoals(text, rune)
	-- boxSettings
	bSet = {
		font = nativeSystemfont,
		fontSizeSM = 45,
		fontSizeLG = 55,
		offset = 50,
		offsetLG = 70,
		x = 720,
		y = 50,
		boxX = 10,
		boxY = 88, 
		boxW = 1500,
		boxH = 50,
		boxA = 1
	}

	-- create new display group for goals
	goalie = display.newGroup()
	goalie.name = "goals"
		
	local boxH = bSet.boxH*#text[gNum]
	
	-- create outer text box rectangle
	textBox = display.newRect(bSet.x, bSet.boxY, bSet.boxW, boxH)
	textBox:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textBox.strokeWidth = 15
	textBox.alpha = bSet.boxA
	
	-- Draw the textObjects
	textObject = {}
	
	for i=1, #text[gNum]-1 do
		if i==1 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-250, bSet.y + 35 + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		elseif i>=2 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-100, bSet.y - 35 + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		end
		textObject[i]:setFillColor(1,0,0)
		textObject[i].anchorX = 21
	end
		
		
	-- insert objects to display group: goalie
	goalie:insert(textBox)
	for i=1, #textObject do
		goalie:insert(textObject[i])
	end
	
	for i=1, #rune do
		goalie:insert(rune[i])
		rune[i].isSensor = true
	end
	--goalie:insert(coins)
	--goalie:insert(coin)
	goalie:toFront()
end

-- findGoals: set and adjust goals via their respected level
local function findGoals(mapData)
	
	local xCoord = 720
	local temp = mapData.levelNum
		
	-- Load runes
	local rune = {
		[1] = display.newImage("mapdata/art/runes/blueRune.png"),
		[2] = display.newImage("mapdata/art/runes/greenRune.png"),
		[3] = display.newImage("mapdata/art/runes/pinkRune.png"),
		[4] = display.newImage("mapdata/art/runes/purpleRune.png"),
		[5] = display.newImage("mapdata/art/runes/yellowRune.png")
	}
	
	-- temp max Rune Amounts
	local runeAMT = #rune
	
	-- Disable rune visibility
	for i=1, #rune do
		rune[i].isVisible = false
		--rune[i].isBodyActive = true
	end
	
	-- Goal text displayer
	local text = {
		[1] = {
			[1] = "Collect",
			[2] = "runes:",
			[3] = "",
			--[4] = "Coins:",
			--[5] = "",
			--[6] = "Key:",
			--[7] = -50
		}
	}
	
	-- Set amount of runes (runeAMT) based on level (temp = levelNum)
	if temp == "1" then
		runeAMT = 1
	elseif temp == "2" then
		runeAMT = 1
	elseif temp == "3" then
		runeAMT = 3
	elseif temp == "4" then
		runeAMT = 4
	else runeAMT = 0
	end

	-- Position and draw in goal displayer
	for i=1, runeAMT do
		rune[i].x = xCoord+50
		rune[i].y = 125-35
		rune[i]:scale(0.8, 0.8)
		rune[i].isVisible = true
		rune[i].isSensor = true
		xCoord = xCoord + 50
	end
						
	-- Call function to draw and insert objects
	drawGoals(text, rune)
end

-- Refresh goal displayer: deletes old goals displayed and creates a new one
local function refresh()
	if goalie then
		goalie:removeSelf()
		goalie = nil
		goalie = display.newGroup()
	end
end

-- Destroy it all!
local function destroyGoals()
	print("Destroyed goalie")
	goalBox, textBox, box = nil
	textObject = nil
	rune = nil

	goalie:removeSelf()
	goalie = nil
end

-- Pass into globals
goals.findGoals = findGoals
goals.refresh = refresh
goals.destroyGoals = destroyGoals

return goals