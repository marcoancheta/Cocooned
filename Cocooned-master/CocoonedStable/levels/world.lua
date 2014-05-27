--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- world.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Classes
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")
-- generator for objects (generateObjects.lua)
local generate = require("Objects.generateObjects")
local movement = require("Mechanics.movement")

--------------------------------------------------------------------------------
-- World Variables
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local world = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }}
	panes = {true,false,false,false,false},
	
	-- number of wisps in the level
	wispCount = 0,
	waterCount = 0,
	wallCount = 0,
	auraWallCount = 0,
	playerCount = 1,
	playerPos = {{["x"]=21,["y"]=15}},
	
	-- mapData clone
	-- world.levelNum || world.pane || world.version
	levelNum = 0,
	pane = "M",
	version = 0,

	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["world"] = {
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
		["exitPortal"] = 3,
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0,
	},
}

-- variable that holds objects of pane for later use
local objectList
local mObjectslocal
local bg

--------------------------------------------------------------------------------
-- load pane function
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- loads objects depending on which pane player is in
-- this is where the objects locations are set in each pane
local function load(mapData, map, rune, objects, wisp, water, wall, auraWall)
	objectList = objects
	-- Check which pane
	if mapData.pane == "world" then
		if gameData.debugMode then
			print(mapData.world)
		end

		-- Place World Portals.
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(10, 15)
		objects["exitPortal2"].x, objects["exitPortal2"].y = generate.tilesToPixels(20.5, 11)
		objects["exitPortal3"].x, objects["exitPortal3"].y = generate.tilesToPixels(32, 15)
		
		-- Corona Simulator Accel Coordinates:
	 	--objects["exitPortal3"].x, objects["exitPortal3"].y = generate.tilesToPixels(14, 12)	


		-- Play animation for all world portals
		for i=1, world["world"]["exitPortal"] do
			objects["exitPortal" ..i.. ""]:setSequence("move")
			objects["exitPortal" ..i.. ""]:play()
			objects["exitPortal" ..i.. ""]:scale(2, 2)
		end
	end
	
	-- generates all objects in pane when locations are set
	generate.gObjects(world, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(world, objects, map, mapData)	
	-- destroy the unused objects
	generate.destroyObjects(world, rune, wisp, water, wall, objects)
	-- set which panes are available for player
	map.panes = world.panes
end

--------------------------------------------------------------------------------
-- destroy ALL objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- destroys all objects in pane
-- called when switching panes to reset memory usage
local function destroyAll() 
	display.remove(bg)
	display.remove(locks)
	bg = nil
	--locks = nil
	
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
world.load = load
world.destroyAll = destroyAll

return world
-- end of world.lua