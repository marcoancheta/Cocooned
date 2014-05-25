--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- six.lua
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
-- Level six Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local six = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,true,false},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=25, ["y"]=14}},
	-- number of wisps in the level
	wispCount = 30,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 2,
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
		-- Fish1 Set
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(4, 4)
		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(4, 13)
		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(13, 3)
		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(13, 13)		

		-- Fish2 Set
		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(9, 15)
		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(9, 4)
		objects["fish22"].x, objects["fish22"].y = generate.tilesToPixels(18, 13)
		objects["fish22"].eX, objects["fish22"].eY = generate.tilesToPixels(18, 3)

		-- Rune 
		rune[2].x, rune[2].y = generate.tilesToPixels(4, 21)			
		rune[2].isVisible = true

		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(2, 8)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(6, 9)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(11, 8)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(15, 9)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(20, 7)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(22, 8)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(22, 6)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(20, 9)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(22, 10)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(26, 15)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(23, 18)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(20, 20)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(17, 21)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(14, 20)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(11, 21)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(8, 20)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(5, 21)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(39.5, 8)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(39, 10)

		generate.gWisps(wisp, map, mapData, 1, 19, six.wispCount)
		generate.gWater(map, mapData)
	elseif mapData.pane == "R" then
		-- Exit portals
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(38, 5)

		wisp[20].x, wisp[20].y = generate.tilesToPixels(21, 5)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(24, 6)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(25, 8.5)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(24, 11)
		wisp[24].x, wisp[24].y = generate.tilesToPixels(21, 12.5)
		wisp[25].x, wisp[25].y = generate.tilesToPixels(18, 11)
		wisp[26].x, wisp[26].y = generate.tilesToPixels(17, 8.5)
		wisp[27].x, wisp[27].y = generate.tilesToPixels(18, 6)
		wisp[28].x, wisp[28].y = generate.tilesToPixels(21, 5)
		wisp[29].x, wisp[29].y = generate.tilesToPixels(38, 7)
		wisp[30].x, wisp[30].y = generate.tilesToPixels(38, 9)

		generate.gWisps(wisp, map, mapData, 20, 30, six.wispCount)
		generate.gWater(map, mapData)
	elseif mapData.pane == "U" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "L" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(six, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(six, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(six, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = six.panes
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
six.load = load
six.destroyAll = destroyAll

return six
-- end of six.lua