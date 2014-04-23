--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocofived by Damaged Panda Games (http://signup.cocofivedgame.com/)
-- five.lua
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
-- Level five Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local five = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,true},
	playerCount = 1,
	-- number of wisps in the level
	wispCount = 17,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0,
		["enemy"] = 0,
		["fixedIceberg"] = 1
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
		["fixedIceberg"] = 0
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
		["fixedIceberg"] = 0
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
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 0
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
		["fixedIceberg"] = 0
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
		rune[5].x, rune[5].y = generate.tilesToPixels(4, 17)			
		rune[5].isVisible = true
		
		wisp[1].x, wisp[1].y = generate.tilesToPixels(10, 6)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(17, 7)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(25, 7)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(30, 15)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(24, 17)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 19)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(4.5, 4.5)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(15, 20)

		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(12, 2)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(12, 11)
 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(22, 11)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(22, 2)
 		objects["fish11"].time = 675
 		objects["fish12"].time = 675

		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(3, 8)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(3, 21)
		objects["fixedIceberg1"].time = 3800
		
		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 1, 8)

	elseif mapData.pane == "R" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "L" then
		wisp[9].x, wisp[9].y = generate.tilesToPixels(5, 7)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(11, 10)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(30, 14)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(32, 18)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(27, 10)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(22, 8)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(36, 20)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(13, 15)	
		wisp[17].x, wisp[17].y = generate.tilesToPixels(17, 11)	

		objects["exitPortal1"]:setSequence("still")
		-- Should be at 4,4
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(1, 1)

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 9, 17)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(five, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(five, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(five, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = five.panes
	map.middle.itemGoal = 1
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
five.load = load
five.destroyAll = destroyAll

return five
-- end of five.lua