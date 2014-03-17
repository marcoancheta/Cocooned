--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocotwod by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- seven.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- moveable object class that creates moveable objects (moveableObject.lua)
local moveableObject = require("moveableObject")
-- wind emmiter object class (windEmitter.lua)
local windEmitterMechanic = require("windEmitter")
-- generator for objects (generateObjects.lua)
local generate = require("generateObjects")

--------------------------------------------------------------------------------
-- Level seven Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local seven = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,true,true,true,true},
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
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0,
		["enemy"] = 0
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
		["enemy"] = 0
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
		["enemy"] = 0
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
		["enemy"] = 0
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
		["enemy"] = 0
	}
}

-- variable that holds objects of pane for later use
local objectList
local mObjects

--------------------------------------------------------------------------------
-- load pane function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- loads objects depending on which pane player is in
-- this is where the objects locations are set in each pane
local function load(pane, map, rune, objects, wisp)
	objectList = objects
	
	-- Check which pane
	if pane == "M" then
		
		wisp[1].x, wisp[1].y = map.tilesToPixels(2, 2)
		wisp[2].x, wisp[2].y = map.tilesToPixels(8, 6)
		wisp[3].x, wisp[3].y = map.tilesToPixels(2, 10)
		wisp[4].x, wisp[4].y = map.tilesToPixels(12, 6)
		wisp[5].x, wisp[5].y = map.tilesToPixels(2, 21)
		wisp[6].x, wisp[6].y = map.tilesToPixels(9, 21)
		wisp[7].x, wisp[7].y = map.tilesToPixels(17, 21)
		wisp[8].x, wisp[8].y = map.tilesToPixels(24, 21)
		wisp[9].x, wisp[9].y = map.tilesToPixels(36, 21)
		wisp[10].x, wisp[10].y = map.tilesToPixels(36, 18)
		wisp[11].x, wisp[11].y = map.tilesToPixels(35, 10)
		wisp[12].x, wisp[12].y = map.tilesToPixels(38, 4)
		wisp[13].x, wisp[13].y = map.tilesToPixels(33, 1)
		wisp[14].x, wisp[14].y = map.tilesToPixels(27, 1)
		wisp[15].x, wisp[15].y = map.tilesToPixels(21, 1)
		wisp[16].x, wisp[16].y = map.tilesToPixels(15, 1)

		
		generate.gWisps(wisp, map, 1, 16)
	elseif pane == "R" then
		-- Exit portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(25, 14)

		wisp[17].x, wisp[5].y = map.tilesToPixels(13, 21)
		wisp[18].x, wisp[6].y = map.tilesToPixels(17, 21)
		wisp[19].x, wisp[7].y = map.tilesToPixels(21, 21)
		wisp[20].x, wisp[8].y = map.tilesToPixels(24, 21)
		wisp[21].x, wisp[9].y = map.tilesToPixels(37, 18)
		wisp[22].x, wisp[5].y = map.tilesToPixels(37, 13)
		wisp[23].x, wisp[6].y = map.tilesToPixels(37, 8)
		wisp[24].x, wisp[7].y = map.tilesToPixels(37, 3)
		wisp[25].x, wisp[8].y = map.tilesToPixels(36, 11)
		wisp[26].x, wisp[9].y = map.tilesToPixels(36, 14)
		wisp[27].x, wisp[5].y = map.tilesToPixels(33, 1)
		wisp[28].x, wisp[6].y = map.tilesToPixels(28, 1)
		wisp[29].x, wisp[7].y = map.tilesToPixels(15, 8)
		wisp[30].x, wisp[8].y = map.tilesToPixels(25, 8)


		generate.gWisps(wisp, map, 17, 30)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(seven, objects, map, pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(seven, objects, map, pane)
	-- destroy the unused objects
	generate.destroyObjects(seven, rune, wisp, objects)

	-- set which panes are avaiable for player
	map.panes = seven.panes
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
seven.load = load
seven.destroyAll = destroyAll

return seven

-- end of seven.lua