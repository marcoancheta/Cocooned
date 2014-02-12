--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- objects.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
local fifteen = require("levels.fifteen")

local objects = { }

local function onLocalCollision(self, event)
	if(event.phase == "began") then
		-- Collision with runes
		for i=1, #rune do
			if(self.name == rune[i].name) then
				-- Collision with runes
				self.isVisible = false
				self.isBodyActive = false
				self:removeEventListener("collision", self)
				display.remove(self)
			end
		end
		
		-- Collision with coins
		for i=1, #coins do
			if(self.name == coins[i].name) then
				-- Collision with runes
				self.isVisible = false
				self.isBodyActive = false
				self:removeEventListener("collision", self)
				display.remove(self)
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Object - Load all objects
--------------------------------------------------------------------------------
function objects:init()
	physics.setGravity(0,0)
	
	-- Load runes
	rune = {
		[1] = display.newImage("mapdata/Items/blueRune.png"),
		[2] = display.newImage("mapdata/Items/greenRune.png"),
		[3] = display.newImage("mapdata/Items/pinkRune.png"),
		[4] = display.newImage("mapdata/Items/purpleRune.png"),
		[5] = display.newImage("mapdata/Items/yellowRune.png")
	}
	
	-- Assign object name
	rune[1].name = "blueRune"
	rune[2].name = "greenRune"
	rune[3].name = "pinkRune"
	rune[4].name = "purpleRune"
	rune[5].name = "yellowRune"
	
	-- Load Coins
	coinSheet = graphics.newImageSheet("mapdata/art/coins.png", 
				 {width = 66, height = 56, sheetContentWidth = 267, sheetContentHeight = 56, numFrames = 4})
	
	coins = { }
			
	for i=1, 10 do	
	   coins[i] = display.newSprite(coinSheet, spriteOptions.coin)
	   coins[i].speed = 50
	   coins[i].collision = onLocalCollision
	   coins[i].isVisible = false
	   coins[i].isBodyActive = true
	end
	
	coins[1].name = "coin1"
	coins[2].name = "coin2"
	coins[3].name = "coin3"
	coins[4].name = "coin4"
	coins[5].name = "coin5"
	coins[6].name = "coin6"
	coins[7].name = "coin7"
	coins[8].name = "coin8"
	coins[9].name = "coin9"

	
	-- Attach collision event to object
	-- Disable visibility
	for i=1, #rune do
		rune[i].collision = onLocalCollision
		rune[i].isVisible = false
		rune[i].isBodyActive = true
	end

	
	-- Call other object functions
	objects.physics()
	objects.events()
	
	return true
end
--------------------------------------------------------------------------------
-- Object - Physics
-- 		Add physics to objects
--------------------------------------------------------------------------------
function objects:physics()
	for i=1, #rune do
		physics.addBody(rune[i], "dynamic", {bounce=0})
	end
	
	for j=1, #coins do
		physics.addBody(coins[j], "dynamic", {bounce=0})
	end
	
	return true
end

--------------------------------------------------------------------------------
-- Object - Events
-- 		Add event listeners to objects
--------------------------------------------------------------------------------
function objects:events()
	for i=1, #rune do
		rune[i]:addEventListener("collision", rune[i])
	end
	
	for i=1, #coins do
		coins[i]:addEventListener("collision", coins[i])
	end
	return true
end

--------------------------------------------------------------------------------
-- Object Main
--------------------------------------------------------------------------------
local function main(mapData, map)
	objects.init()
	
	-- Check levelNum then redirect
	if mapData.levelNum == "15" then
		fifteen.load(mapData.pane, map, rune, coins)
	else
		print("OBJECTS FOR LVL:", mapData.levelNum, "NOT MADE")
	end
end

--------------------------------------------------------------------------------
-- Object Clean Up
--------------------------------------------------------------------------------
local function destroy()
	if gameData.gameEnd then
		for i=0, #rune do
			display.remove(rune[i])
			rune[i] = nil
		end
		
		for i=0, #coins do
			display.remove(coins[i])
			coins[i] = nil
		end
	end
end

objects.main = main
objects.destroy = destroy

return objects