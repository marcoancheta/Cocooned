--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- five.lua
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
-- Level five Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local five = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,true,false},
	-- number of wisps in the level
	wispCount = 20,
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
		
		wisp[1].x, wisp[1].y = map.tilesToPixels(9, 21)
		wisp[2].x, wisp[2].y = map.tilesToPixels(9, 19)
		wisp[3].x, wisp[3].y = map.tilesToPixels(9, 15)
		wisp[4].x, wisp[4].y = map.tilesToPixels(9, 10)
		wisp[5].x, wisp[5].y = map.tilesToPixels(14, 8)
		wisp[6].x, wisp[6].y = map.tilesToPixels(18, 9)
		wisp[7].x, wisp[7].y = map.tilesToPixels(18, 14)
		wisp[8].x, wisp[8].y = map.tilesToPixels(18, 18)
		wisp[9].x, wisp[9].y = map.tilesToPixels(18, 21)
		
		generate.gWisps(wisp, map, 1, 9)
	
	elseif pane == "R" then
		-- Green rune
		rune[4].x, rune[4].y = map.tilesToPixels(37, 22)
		rune[4].isVisible = true

		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(20, 9)
		
		wisp[10].x, wisp[10].y = map.tilesToPixels(4, 1)
		wisp[11].x, wisp[11].y = map.tilesToPixels(4, 7)
		wisp[12].x, wisp[12].y = map.tilesToPixels(11, 7)
		wisp[13].x, wisp[13].y = map.tilesToPixels(2, 14)
		wisp[14].x, wisp[14].y = map.tilesToPixels(7, 14)
		wisp[15].x, wisp[15].y = map.tilesToPixels(12, 14)
		wisp[16].x, wisp[16].y = map.tilesToPixels(20, 14)
		wisp[17].x, wisp[17].y = map.tilesToPixels(26, 14)
		wisp[18].x, wisp[18].y = map.tilesToPixels(23, 21)  
		wisp[19].x, wisp[19].y = map.tilesToPixels(36, 5)
		wisp[20].x, wisp[20].y = map.tilesToPixels(36, 12)

		generate.gWisps(wisp, map, 10, 20)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(five, objects, map, pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(five, objects, map, pane)
	-- destroy the unused objects
	generate.destroyObjects(five, rune, wisp, objects)

	-- set which panes are avaiable for player
	map.panes = five.panes
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
five.load = load
five.destroyAll = destroyAll

return five

-- end of five.lua