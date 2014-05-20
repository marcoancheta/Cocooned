--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- one.lua
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
-- Level one Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local one = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	timer = 30,
	playerCount = 1,
	playerPos = {	{["x"]=20,["y"]=14},
				},
	-- number of wisps in the level
	wispCount = 18,
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
		wisp[1].x, wisp[1].y = generate.tilesToPixels(15, 13)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(13, 12)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(10, 12)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(7, 11)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(5, 12)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(2, 14)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(3, 17)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(7, 19)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(10, 18)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(13, 18)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(16, 18)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(19, 19)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(26, 16)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(31, 17)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(36, 13)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(35, 14)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(36, 15)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(37, 14)

		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(15, 22.5)
		--objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(10, 12)

		generate.gWisps(wisp, map, mapData, 1, 18)
	elseif mapData.pane == "L" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
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
	generate.gObjects(one, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(one, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(one, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = one.panes
	map.front.itemGoal = 0
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
one.load = load
one.destroyAll = destroyAll

return one
-- end of one.lua