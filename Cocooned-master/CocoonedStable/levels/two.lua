--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocotwod by Damaged Panda Games (http://signup.cocotwodgame.com/)
-- two.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")
-- generator for objects (generateObjects.lua)
local generate = require("Loading.generateObjects")

--------------------------------------------------------------------------------
-- Level two Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local two = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	timer = 60,
	playerCount = 1,
	playerPos = {	{["x"]=20,["y"]=10},
				},
	-- number of wisps in the level
	wispCount = 6,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 1,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 1,
		["enemy"] = 0,
		["fixedIceberg"] = 0
	},
	["D"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
	},
	["R"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
	},	
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
	}
}

-- variable that holds objects of pane for later use
local objectList
local mObjectslocal 


--------------------------------------------------------------------------------
-- load pane function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- loads objects depending on which pane player is in
-- this is where the objects locations are set in each pane
local function load(mapData, map, rune, objects, wisp, water, wall, auraWall)
	objectList = objects
		-- Check which pane
	if mapData.pane == "M" then
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(28, 6)
		
		-- Pink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(4.5, 4.5)			
		rune[4].isVisible = true
		
		wisp[1].x, wisp[1].y = generate.tilesToPixels(24, 6)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(26, 8)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(28, 9)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(30, 9)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(38, 10)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(38, 13)
		
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(38, 7)
		
		generate.gWisps(wisp, map, mapData, 1, 6)
		generate.gAuraWalls(map, mapData, "blueWall")
	elseif mapData.pane == "L" then
		--[[
		-- Pink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(21, 18)			
		rune[4].isVisible = true
		
		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(29, 12)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(25, 12)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(21, 12)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(21, 16)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(39, 10)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(39, 14)	

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 1, 6)
		]]--
	elseif mapData.pane == "U" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "R" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(two, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(two, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(two, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = two.panes
	map.front.itemGoal = 1
end

--------------------------------------------------------------------------------
-- destroy ALL objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- destroys all objects in pane
-- called when switching panes to reset memory usage
local function destroyAll() 

	-- destroy all wisps
	for i=1, #wisp do
		display.remove(wisp[i])
		wisp[i] = nil
	end
	
	for i=1, #water do
		display.remove(water[i])
		water[i] = nil
	end
	
	for i=1, #wall do
		display.remove(wall[i])
		wall[i] = nil
	end

	if gameData.debugMode then
		print("destroying objects", #mObjects)
	end
	-- destroy all moveable objects and stop moving them
	for i=1, #mObjects do
		if mObjects[i].moveable == true then

			mObjects[i]:endTransition()
			mObjects[i].object.stop = true
		else
			mObjects[i].count = 0
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
two.load = load
two.destroyAll = destroyAll

return two

-- end of two.lua