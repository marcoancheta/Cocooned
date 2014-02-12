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
local goalBox, textBox, box, coin, goalie
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
	goalie:insert(coins[1])
	goalie:insert(coin)
	goalie:toFront()
end

local function findGoals(mapData, rune, coins)
	
	local xCoord = 220
	local temp = mapData.levelNum
	local runeAMT = #rune
	
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
		if i == 1 then
			coins[1].x = 220
			coins[1].y = 350
			coins[1].isVisible = true
			coins[1].isSensor = true
			coins[1]:setSequence("move")
			coins[1]:play()
			coin = display.newText("x" .. runeAMT*5, coins[1].x + 70, coins[1].y, nativeSystemfont, 50)
			coin:setFillColor(0,0,0)
		end
		
		rune[i].x = xCoord
		rune[i].y = 220
		rune[i]:scale(0.8, 0.8)
		rune[i].isVisible = true
		rune[i].isSensor = false
		xCoord = xCoord + 50
	end
					
	drawGoals(text, rune, coins)
end

local function destroyGoals()
	
	if goalie then	
		goalie:removeSelf()
		goalie = display.newGroup()
	end

	if gameData.gameStart then
		print("Destroyed goalie")
		goalie:removeSelf()
		goalie = nil
		display.remove(coin)
		goalBox, textBox, box, coin = nil
		display.remove(textObject)
		textObject = nil
		display.remove(rune)
		rune = nil
		display.remove(coins)
		coins = nil
	end
end

goals.findGoals = findGoals
goals.destroyGoals = destroyGoals

return goals