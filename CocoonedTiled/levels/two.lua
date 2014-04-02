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
local gameData = require("gameData")
-- generator for objects (generateObjects.lua)
local generate = require("generateObjects")

--------------------------------------------------------------------------------
-- Level two Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local two = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,true},
	-- number of wisps in the level
	wispCount = 6,
	waterCount = 1,
	wallCount = 2,
	auraWallCount = 0,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
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
		["exitPortal"] = 1,
		["enemy"] = 0,
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
		-- Portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(38, 7)
				
		-- Wisps
		--[[
		wisp[1].x, wisp[1].y = map.tilesToPixels(5, 9)
		wisp[2].x, wisp[2].y = map.tilesToPixels(5, 11)
		wisp[3].x, wisp[3].y = map.tilesToPixels(5, 13)
		wisp[4].x, wisp[4].y = map.tilesToPixels(5, 15)
		]]--
						
		-- Water			
		water[1].x, water[1].y = map.tilesToPixels(18.2, 15.5)
		
		-- Walls
		wall[1].x, wall[1].y = map.tilesToPixels(21, 12)
		wall[2].x, wall[2].y = map.tilesToPixels(21, 12)
		wall[2]:toFront()
		
		--generate.gWisps(wisp, map, mapData, 1, 4)
		generate.gWater(water, map, mapData, 1, 1)
		generate.gWalls(wall, map, mapData, 1, 2)
	elseif mapData.pane == "L" then
		-- Pink rune
		rune[4].x, rune[4].y = map.tilesToPixels(21, 18)			
		rune[4].isVisible = true
		
		-- Wisps
		wisp[1].x, wisp[1].y = map.tilesToPixels(29, 12)
		wisp[2].x, wisp[2].y = map.tilesToPixels(25, 12)
		wisp[3].x, wisp[3].y = map.tilesToPixels(21, 12)
		wisp[4].x, wisp[4].y = map.tilesToPixels(21, 16)
		wisp[5].x, wisp[5].y = map.tilesToPixels(39, 10)
		wisp[6].x, wisp[6].y = map.tilesToPixels(39, 14)	
	
		-- Water
		water[1].x, water[1].y = map.tilesToPixels(8.5, 14)
		
		-- Walls
		wall[1].x, wall[1].y = map.tilesToPixels(21, 12)
		wall[2].x, wall[2].y = map.tilesToPixels(21, 12)
		generate.gWisps(wisp, map, mapData, 1, 6)
		generate.gWater(water, map, mapData, 1, 1)
		generate.gWalls(wall, map, mapData, 1, 2)
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "R" then
		print("You shouldn't be in here...")
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(two, objects, map, mapData.pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(two, objects, map, mapData.pane)
	-- destroy the unused objects
	generate.destroyObjects(two, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.panes = two.panes
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

	print("destroying objects", #mObjects)
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