--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- fifteen.lua
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
local generate = require("Objects.generateObjects")

--------------------------------------------------------------------------------
-- Level fifteen Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local fifteen = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,true,true,true,true},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=12, ["y"]=16}},
	-- number of wisps in the level
	wispCount = 1,
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
		["exitPortal"] = 0,
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 2,
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 2,
		["worldPortal"] = 0
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
		--generate.gWisps(wisp, map, mapData, 1, 23, fifteen.wispCount)
		--generate.gAuraWalls(map, mapData, "blueWall")
		--generate.gWater(map, mapData)
	elseif mapData.pane == "R" then
		-- Breakable rune
		rune[4].x, rune[4].y = generate.tilesToPixels(4, 21)			
		rune[4].isVisible = true

		-- Exit Portal
		-- Exit portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(21, 11)
		--generate.gWater(map, mapData)
		--generate.gWisps(wisp, map, mapData, 24, 39, fifteen.wispCount)
	elseif mapData.pane == "L" then
		-- FISH GO HERE

		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(30, 2)
		objects["fixedIceberg1"].time = 3800 --not needed if free
		objects["fixedIceberg1"].movement = "free" --fixed or free

		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(37, 8)
		objects["fixedIceberg2"].time = 3800 --not needed if free
		objects["fixedIceberg2"].movement = "free" --fixed or free
	elseif mapData.pane == "U" then
		-- FISH GO HERE

		-- Slow time rune
		rune[3].x, rune[3].y = generate.tilesToPixels(23, 21)			
		rune[3].isVisible = true

		-- Slow time rune
		rune[3].x, rune[3].y = generate.tilesToPixels(12, 22)			
		rune[3].isVisible = true

		-- Slow time rune
		rune[3].x, rune[3].y = generate.tilesToPixels(35, 22)			
		rune[3].isVisible = true

		-- Auras 
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(14, 3)

		-- Auras 
		objects["greenAura2"]:setSequence("move")
		objects["greenAura2"]:play()
		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(24, 3)

		-- Shrink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(33, 9)			
		rune[4].isVisible = true

		-- Shrink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(37, 18)			
		rune[4].isVisible = true

		generate.gAuraWalls(map, mapData, "greenWall")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(fifteen, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(fifteen, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(fifteen, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = fifteen.panes
	map.front.itemGoal = 2
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
fifteen.load = load
fifteen.destroyAll = destroyAll

return fifteen
-- end of fifteen.lua