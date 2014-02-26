--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- objects.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- Bonus level variable (bonus.lua)
local bonus = require("levels.bonus")

-- holds the level name for loading
local levelNames = {
	["1"] = "one",
	["2"] = "two",
	["3"] = "three",
	["4"] = "four",
	["15"] = "fifteen"
}
-- local variable for that holds "level".lua
local level

-- variable that holds all objects in level for later use
local objects = {}

--------------------------------------------------------------------------------
-- Object - initialize runes and sprite sheets
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function init()
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

	-- Set properties and add physics to runes
	for i=1, #rune do
		physics.addBody(rune[i], "dynamic", {bounce=0})
		rune[i].isVisible = false
		rune[i].collectable = true
		rune[i].func = "runeCollision"
	end
	
	-- load object sprite sheets
	sheetList = {}

	sheetList.energy = graphics.newImageSheet("mapdata/art/coins.png", 
				 {width = 66, height = 56, sheetContentWidth = 267, sheetContentHeight = 56, numFrames = 4})
	sheetList["redAura"] = graphics.newImageSheet("mapdata/art/redAuraSheet.png", 
				 {width = 103, height = 103, sheetContentWidth = 2060, sheetContentHeight = 103, numFrames = 20})
	sheetList["greenAura"] = graphics.newImageSheet("mapdata/art/greenAuraSheet.png", 
				 {width = 103, height = 103, sheetContentWidth = 2060, sheetContentHeight = 103, numFrames = 20})
	sheetList["exitPortal"] = graphics.newImageSheet("mapdata/art/exitPortalSheet.png", 
				 {width = 72, height = 39, sheetContentWidth = 362, sheetContentHeight = 39, numFrames = 5})
	
	return true
end

--------------------------------------------------------------------------------
-- Object - animate animated objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function createAnimations(count, name, objectList)
	for i = 1, count do
		objectList[name .. i] = display.newSprite(sheetList[name], spriteOptions[name])
		objectList[name .. i].name = name .. i
		objectList[name .. i]:setSequence("move")
		objectList[name .. i]:play()
	end
	return true
end

--------------------------------------------------------------------------------
-- Object - initialize rest of objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function createSprites(count, name, objectList)
	for i = 1, count do
		print("creating:", count, name, i)
		objectList[name .. i] = display.newImage("mapdata/art/" .. name .. ".png")
		objectList[name .. i].name = name .. i
	end
	return true
end

--------------------------------------------------------------------------------
-- Object - function that creates all objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function createObjects(objectNumbers, pane)
	-- declare wisp and object list
	local wisp = {}
	local objects = {}

	-- create all wisps in level
	for i=1, tonumber(objectNumbers.wispCount) do
		wisp[i] = display.newImage("mapdata/art/wisp.png")
		wisp[i].isVisible = false
		wisp[i].x, wisp[i].y = 100, 100
	end	
	-- call function to animate objects
	for i = 1, 4 do
		createAnimations(objectNumbers[pane][objectNames[i]], objectNames[i], objects)
	end
	-- call function that creates sprites
	for i = 5, 11 do
		createSprites(objectNumbers[pane][objectNames[i]], objectNames[i], objects)
	end

	-- return object and wisp list
	return objects, wisp
end

--------------------------------------------------------------------------------
-- Object - Main
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function main(mapData, map, player)
	-- call initialize function to initialize all objects and sprite sheets
	init()
	-- get which level lua, player is in
	level = require("levels." .. levelNames[mapData.levelNum])
	-- get objects and wisps list and create them
	objects, wisp = createObjects(level, mapData.pane)
	-- load in which pane player is in
	level.load(mapData.pane, map, rune, objects, wisp)
end


--------------------------------------------------------------------------------
-- Object - Clean Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function destroy(mapData)
	-- remove all runes to clear memory usage
	for i=0, #rune do
		display.remove(rune[i])
		rune[i] = nil
	end
	-- destroy all objects in level pan
	level.destroyAll()
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
objects.main = main
objects.destroy = destroy


return objects

-- end of objects.lua