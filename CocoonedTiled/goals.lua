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
local textObject = {}
local bSet

local function drawGoals(text, rune, coins)
	bSet = {
		font = nativeSystemfont,
		fontSizeSM = 45,
		fontSizeLG = 55,
		offset = 50,
		offsetLG = 60,
		x = 250,
		y = 100,
		boxX = 10,
		boxY = 300, 
		boxW = 450,
		boxH = 70,
		boxA = 0.95
	}

	-- create new display group for goals
	goalie = display.newGroup()
	goalie.name = "goals"
		
	local boxH = bSet.boxH*#text[gNum]
	
	textBox = display.newRect(bSet.x, bSet.boxY, bSet.boxW, boxH)
	textBox:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	textBox.strokeWidth = 15
	textBox.alpha = bSet.boxA
	
	textObject = {}
	
	for i=1, #text[gNum]-1 do
		if i==1 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-60, bSet.y + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		elseif i>=2 then
			textObject[i] = display.newText(text[gNum][i], bSet.x-125, bSet.y + bSet.offsetLG*(i-1), bSet.font, bSet.fontSizeSM)
		end
		textObject[i]:setFillColor(0,0,0)
		textObject[i].align = "left"
	end
		
		
	-- insert text objects to display group
	goalie:insert(textBox)
	for i=1, #textObject do
		goalie:insert(textObject[i])
	end
	for i=1, #rune do
		goalie:insert(rune[i])
		rune[i].isSensor = true
	end
	goalie:insert(coins)
	goalie:insert(coin)
	goalie:toFront()
end

local function findGoals(mapData)
	
	local xCoord = 220
	local temp = mapData.levelNum
		
	-- Load runes
	local rune = {
		[1] = display.newImage("mapdata/Items/blueRune.png"),
		[2] = display.newImage("mapdata/Items/greenRune.png"),
		[3] = display.newImage("mapdata/Items/pinkRune.png"),
		[4] = display.newImage("mapdata/Items/purpleRune.png"),
		[5] = display.newImage("mapdata/Items/yellowRune.png")
	}
	
	local runeAMT = #rune
	
	-- Disable visibility
	for i=1, #rune do
		rune[i].isVisible = false
		rune[i].isBodyActive = true
	end
	
	-- Load Coins
	local coinSheet = graphics.newImageSheet("mapdata/art/coins.png", 
				 {width = 66, height = 56, sheetContentWidth = 267, sheetContentHeight = 56, numFrames = 4})
	
	coins = display.newSprite(coinSheet, spriteOptions.coin)
	coins.speed = 50
	coins.isVisible = false
	
	local text = {
		[1] = {
			[1] = "-Level Goals-",
			[2] = "Rune:",
			[3] = "",
			[4] = "Coins:",
			[5] = "",
			[6] = "Key:",
			[7] = -50
		}
	}
	
	-- Set amount of runes (runeAMT) per level
	if temp == "T" then
		runeAMT = 1
	elseif temp == "1" then
		runeAMT = 2
	elseif temp == "2" then
		runeAMT = 3
	elseif temp == "3" then
		runeAMT = 4
	else runeAMT = #rune
	end

	-- Position and draw
	for i=1, runeAMT do
		rune[i].x = xCoord
		rune[i].y = 220
		rune[i]:scale(0.8, 0.8)
		rune[i].isVisible = true
		rune[i].isSensor = true
		xCoord = xCoord + 50
	end
	
	coins.x = 220
	coins.y = 350
	coins.isVisible = true
	coins.isSensor = true
	coins:setSequence("move")
	coins:play()
	coin = display.newText("x" .. runeAMT*5, coins.x + 70, coins.y, nativeSystemfont, 50)
	coin:setFillColor(0,0,0)
					
	drawGoals(text, rune, coins)
end

local function refresh()
	if goalie then
		goalie:removeSelf()
		goalie = nil
		goalie = display.newGroup()
	end
end

local function destroyGoals()
	print("Destroyed goalie")
	goalBox, textBox, box, coin = nil
	textObject = nil
	rune = nil
	coins = nil
	goalie:removeSelf()
	goalie = nil
end

goals.findGoals = findGoals
goals.refresh = refresh
goals.destroyGoals = destroyGoals

return goals