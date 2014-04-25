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
local generate = require("Loading.generateObjects")
local movement = require("Mechanics.movement")

--------------------------------------------------------------------------------
-- Level One Variables
--------------------------------------------------------------------------------

-- Updated by: Marco
--------------------------------------------------------------------------------
local LS = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	-- number of wisps in the level
	wispCount = 0,
	waterCount = 0,
	wallCount = 0,
	auraWallCount = 0,
	-- mapData clone
	-- LS.levelNum || LS.pane || LS.version
	levelNum = 0,
	pane = "M",
	version = 0,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["LS"] = {
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
		["exitPortal"] = 5,
		["enemy"] = 0,
		["fixedIceberg"] = 0
	},
}

-- variable that holds objects of pane for later use
local objectList
local mObjectslocal
local bg
local locks = {}

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
	if mapData.pane == "LS" then		
		objects["exitPortal1"].x, objects["exitPortal1"].y = 70, 220
		objects["exitPortal2"].x, objects["exitPortal2"].y = 70, 120
		objects["exitPortal3"].x, objects["exitPortal3"].y = 250, 100
		objects["exitPortal4"].x, objects["exitPortal4"].y = 420, 120
		objects["exitPortal5"].x, objects["exitPortal5"].y = 420, 220
		
		for i=1, 5 do
			objects["exitPortal" ..i.. ""]:setSequence("move")
			objects["exitPortal" ..i.. ""]:play()
			
			locks[i] = display.newImageRect("mapdata/art/buttons/lock.png", 35, 35)
			locks[i].x = objects["exitPortal" ..i.. ""].x
			locks[i].y = objects["exitPortal" ..i.. ""].y
							
			if i==1 then
				locks[i].isVisible = true
				objects["exitPortal" ..i.. ""]:setSequence("still")
				objects["exitPortal" ..i.. ""].isSensor = true
			else
				locks[i].isVisible = false
			end		
			
			locks[i]:toFront()
		end
	end	
	
	-- generates all objects in pane when locations are set
	generate.gObjects(LS, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(LS, objects, map, mapData)	
	-- destroy the unused objects
	generate.destroyObjects(LS, rune, wisp, water, wall, objects)
	-- set which panes are avaiable for player
	map.panes = LS.panes
end

--------------------------------------------------------------------------------
-- destroy ALL objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- destroys all objects in pane
-- called when switching panes to reset memory usage
local function destroyAll() 
	display:remove(locks)
	locks = nil
	
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
LS.load = load
LS.destroyAll = destroyAll

return LS
-- end of one.lua