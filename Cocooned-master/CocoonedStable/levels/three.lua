--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocothreed by Damaged Panda Games (http://signup.cocothreedgame.com/)
-- three.lua
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
-- Level three Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local three = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	playerCount = 1,
	-- number of wisps in the level
	wispCount = 7,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 1,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 1,
		["enemy"] = 0,
		["fixedIceberg"] = 0,
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
		
		-- Pink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(20, 12)			
		rune[4].isVisible = true
		
		--[[ A-5-2 wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(10, 10)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(15, 12)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(30, 13)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(35, 20)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(30, 30)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 30)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(38, 10)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(15, 35)
		]]
		wisp[1].x, wisp[1].y = generate.tilesToPixels(10, 8)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(2, 13)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(7, 16)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(3, 20)
		-- Right three wisps
		wisp[5].x, wisp[5].y = generate.tilesToPixels(23, 10)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 15)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(17, 10)

		
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(30, 4)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(30, 19)
 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(22, 4)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(22, 19)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(26, 4)
 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(26, 19)
 		objects["fish11"].time = 375
 		objects["fish12"].time = 375
 		objects["fish21"].time = 375
 		
		
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(35, 12)

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 1, 7)

	elseif mapData.pane == "L" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "R" then
		print("You shouldn't be in here...")
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(three, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(three, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(three, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.panes = three.panes
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
three.load = load
three.destroyAll = destroyAll

return three
-- end of three.lua