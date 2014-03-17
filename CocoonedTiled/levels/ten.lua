--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocotwod by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- ten.lua
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
-- Level ten Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local ten = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,true,false},
	-- number of wisps in the level
	wispCount = 34,
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
		["redAura"] = 1,
		["greenAura"] = 1,
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
		["fish1"] = 2,
		["fish2"] = 2,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
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

		objects["fish11"].x, objects["fish11"].y = map.tilesToPixels(1, 11)
		objects["fish11"].eX, objects["fish11"].eY = map.tilesToPixels(1, 4)
		objects["fish21"].eX, objects["fish21"].eY = map.tilesToPixels(5, 3)
		objects["fish21"].x, objects["fish21"].y = map.tilesToPixels(5, 11)
		objects["fish12"].x, objects["fish12"].y = map.tilesToPixels(1, 11)
		objects["fish12"].eX, objects["fish12"].eY = map.tilesToPixels(1, 4)
		objects["fish22"].eX, objects["fish22"].eY = map.tilesToPixels(5, 3)
		objects["fish22"].x, objects["fish22"].y = map.tilesToPixels(5, 11)
		
		wisp[1].x, wisp[1].y = map.tilesToPixels(2, 6)
		wisp[2].x, wisp[2].y = map.tilesToPixels(6, 9)
		wisp[3].x, wisp[3].y = map.tilesToPixels(11, 6)
		wisp[4].x, wisp[4].y = map.tilesToPixels(16, 9)
		wisp[5].x, wisp[5].y = map.tilesToPixels(19, 7)
		wisp[6].x, wisp[6].y = map.tilesToPixels(21, 8)
		wisp[7].x, wisp[7].y = map.tilesToPixels(23, 2)
		wisp[8].x, wisp[8].y = map.tilesToPixels(31, 2)
		wisp[9].x, wisp[9].y = map.tilesToPixels(32, 8)
		wisp[10].x, wisp[10].y = map.tilesToPixels(32, 16)
		wisp[11].x, wisp[11].y = map.tilesToPixels(32, 22)
		wisp[12].x, wisp[12].y = map.tilesToPixels(25, 18)
		wisp[13].x, wisp[13].y = map.tilesToPixels(22, 20)
		wisp[14].x, wisp[14].y = map.tilesToPixels(18, 22)
		wisp[15].x, wisp[15].y = map.tilesToPixels(15, 20)
		wisp[16].x, wisp[16].y = map.tilesToPixels(13, 18)
		wisp[17].x, wisp[17].y = map.tilesToPixels(9, 20)
		wisp[18].x, wisp[18].y = map.tilesToPixels(6, 18)
		wisp[19].x, wisp[19].y = map.tilesToPixels(38, 2)
		wisp[20].x, wisp[20].y = map.tilesToPixels(38, 10)
		
		generate.gWisps(wisp, map, 1, 20)
	
	elseif pane == "R" then
		-- Exit portals
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(0, 9)
		objects["exitPortal2"]:setSequence("still")
		objects["exitPortal2"].x, objects["exitPortal2"].y = map.tilesToPixels(36, 5)
		
		wisp[21].x, wisp[21].y = map.tilesToPixels(12, 2)
		wisp[22].x, wisp[22].y = map.tilesToPixels(18, 1)
		wisp[23].x, wisp[23].y = map.tilesToPixels(20, 1)
		wisp[24].x, wisp[24].y = map.tilesToPixels(26, 2)
		wisp[25].x, wisp[25].y = map.tilesToPixels(28, 5)
		wisp[26].x, wisp[26].y = map.tilesToPixels(30, 8)
		wisp[27].x, wisp[27].y = map.tilesToPixels(29, 12)
		wisp[28].x, wisp[28].y = map.tilesToPixels(25, 14)
		wisp[29].x, wisp[29].y = map.tilesToPixels(21, 15)
		wisp[30].x, wisp[30].y = map.tilesToPixels(16, 13)
		

		generate.gWisps(wisp, map, 21, 30)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(ten, objects, map, pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(ten, objects, map, pane)
	-- destroy the unused objects
	generate.destroyObjects(ten, rune, wisp, objects)

	-- set which panes are avaiable for player
	map.panes = ten.panes
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
ten.load = load
ten.destroyAll = destroyAll

return ten

-- end of ten.lua