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

-- holds the level name for loading
local levelNames = {
	["1"] = "one",
	["2"] = "two",
	["3"] = "three",
	["4"] = "four",
	["15"] = "fifteen",
	["LS"] = "LS"
}
-- local variable for that holds "level".lua
local level

-- variable that holds all objects in level for later use
local objects = {}
local rune = {}
local sheetList = {}
--------------------------------------------------------------------------------
-- Object - initialize runes and sprite sheets
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function init()
	
	-- Load runes
	rune[1] = display.newImage("mapdata/art/runes/blueRune.png")
	rune[2] = display.newImage("mapdata/art/runes/greenRune.png")
	rune[3] = display.newImage("mapdata/art/runes/pinkRune.png")
	rune[4] = display.newImage("mapdata/art/runes/purpleRune.png")
	rune[5] = display.newImage("mapdata/art/runes/yellowRune.png")
	
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
	sheetList["redAura"] = graphics.newImageSheet("mapdata/art/animation/redAuraSheet.png", 
				 {width = 103, height = 103, sheetContentWidth = 2060, sheetContentHeight = 103, numFrames = 20})
	sheetList["greenAura"] = graphics.newImageSheet("mapdata/art/animation/greenAuraSheet.png", 
				 {width = 103, height = 103, sheetContentWidth = 2060, sheetContentHeight = 103, numFrames = 20})	
	sheetList["blueAura"] = graphics.newImageSheet("mapdata/art/animation/blueAuraSheet.png", 
				 {width = 103, height = 103, sheetContentWidth = 2060, sheetContentHeight = 103, numFrames = 20})				 
	sheetList["exitPortal"] = graphics.newImageSheet("mapdata/art/animation/exitPortalSheet.png", 
				 {width = 72, height = 39, sheetContentWidth = 362, sheetContentHeight = 39, numFrames = 5})
	sheetList["wolf"] = graphics.newImageSheet("mapdata/art/animation/wolfSheet.png", 
				 {width = 144, height = 72, sheetContentWidth = 1152, sheetContentHeight = 72, numFrames = 8})
	
	return true
end

--------------------------------------------------------------------------------
-- Object - animate animated objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function createAnimations(count, name, objectList)
	for i = 1, count do
		--print(name)
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
local function createSprites(count, name, objectList)
	for i = 1, count do
		--print("creating:", count, name, i)
		objectList[name .. i] = display.newImage("mapdata/art/objects/" .. name .. ".png")
		objectList[name .. i].name = name .. i
	end
	return true
end

--------------------------------------------------------------------------------
-- Object - function that creates all objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function createObjects(objectNumbers, mapData)
	-- declare wisp and object list
	local wisp = {}
	local objects = {}
	local water = {}
	local wall = {}
	local auraWall = {}
	
	-- Load walls based on level
	if mapData.levelNum == "LS" then
		if mapData.pane == "LS" then
			-- Main Walls
			wall[1] = display.newImage("mapdata/art/background/LS/LS-BB/LS.png", true)
		end
	elseif mapData.levelNum == "1" then

		if mapData.pane == "M" then
			print("creating lvl 1 walls")
			-- Main walls
			wall[1] = display.newImage("mapdata/art/background/1/1-1BB/1-1_BB.png", true)
			-- Aura walls
			auraWall[1] = display.newImage("mapdata/art/auraWalls/blueAuraWall.png", true)
		end
	elseif mapData.levelNum == "2" then
		--[[
		if mapData.pane == "M" then
			-- Level 2: Pane 'M'
			wall[1] = display.newImage("mapdata/art/background/2/2-1BB/2-1-WALL4.png", true)
			water[1] = display.newImage("mapdata/art/background/2/2-1BB/2-1-WATER2.png", true)
		elseif mapData.pane == "L" then
			-- Level 2: Pane 'L'
			wall[1] = display.newImage("mapdata/art/background/2/2-2BB/2-2-WALL4.png", true)
			water[1] = display.newImage("mapdata/art/background/2/2-2BB/2-2-WATER2.png", true)
		end		
		]]
	elseif mapData.levelNum == "4" then
		if mapData.pane == "M" then
			-- Level 4: Pane 'M'
			wall[1] = display.newImage("mapdata/art/background/4/4-1BB/4-1WALL.png", true)
			water[1] = display.newImage("mapdata/art/background/4/4-1BB/4-1WATER1.png", true)
			water[2] = display.newImage("mapdata/art/background/4/4-1BB/4-1WATER2.png", true)
		elseif mapData.pane == "R" then
			-- Level 4: Pane 'M'
			wall[1] = display.newImage("mapdata/art/background/4/4-2BB/4-2WALL.png", true)
			water[1] = display.newImage("mapdata/art/background/4/4-2BB/4-2WATER1.png", true)
			water[2] = display.newImage("mapdata/art/background/4/4-2BB/4-2WATER2.png", true)
		end
	end
	
		-- create all waters in level
	for i=1, tonumber(objectNumbers.waterCount) do
		water[i].isVisible = false
	end
	
	print("wall number", mapData.levelNum, objectNumbers.wallCount)
	-- create all walls in level
	for i=1, tonumber(objectNumbers.wallCount) do
		wall[i].isVisible = false
	end
	

	-- create all walls in level
	for i=1, tonumber(objectNumbers.auraWallCount) do
		auraWall[i].isVisible = false
	end
	
	-- create all wisps in level
	for i=1, tonumber(objectNumbers.wispCount) do
		wisp[i] = display.newImage("mapdata/art/wisp/wisp2.png")
		wisp[i].isVisible = false
		wisp[i].x, wisp[i].y = 100, 100
	end	
	
	-- call function to animate objects
	for i = 1, 5 do
		createAnimations(objectNumbers[mapData.pane][objectNames[i]], objectNames[i], objects)
	end
	-- call function that creates sprites
	for i = 6, 12 do
		createSprites(objectNumbers[mapData.pane][objectNames[i]], objectNames[i], objects)
	end

	-- return object and wisp list
	return objects, wisp, water, wall, auraWall
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
	objects, wisp, water, wall, auraWall = createObjects(level, mapData)
	-- load in which pane player is in
	print("map:", map)
	level.load(mapData, map, rune, objects, wisp, water, wall, auraWall)
	
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

	for i=0, #wall do
		display.remove(wall[i])
		wall[i] = nil
	end
	
	for i=0, #auraWall do
		display.remove(auraWall[i])
		auraWall[i] = nil
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