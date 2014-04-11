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
local gameData = require("gameData")
-- generator for objects (generateObjects.lua)
local generate = require("generateObjects")

--------------------------------------------------------------------------------
-- Level One Variables
--------------------------------------------------------------------------------

-- Updated by: Marco
--------------------------------------------------------------------------------
local one = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	-- number of wisps in the level
	wispCount = 6,
	waterCount = 0,
	wallCount = 1,
	auraWallCount = 1,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
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
		["enemy"] = 0,
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
		-- Blue Aura
		
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(26, 6)
		
		-- Pink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(4.5, 4.5)			
		rune[4].isVisible = true
			
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(37, 7)
		
		wisp[1].x, wisp[1].y = generate.tilesToPixels(23, 6)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(24, 8)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(26, 9)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(28, 9)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(37, 10)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(37, 13)
			
		wall[1].x, wall[1].y = generate.tilesToPixels(21, 12)	 
				
		auraWall[1].x, auraWall[1].y = generate.tilesToPixels(6.5, 5) -- blueAuraWall
		
		--generate.gAuraWalls(auraWall, map, mapData, 1, 1)
		--generate.gWisps(wisp, map, mapData, 1, 6)
		--generate.gWalls(wall, map, mapData, 1, 1)
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "R" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "L" then
		print("You shouldn't be in here...")
	end

	-- generates all objects in pane when locations are set
	--generate.gObjects(one, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	--Objects = generate.gMObjects(one, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(one, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.panes = one.panes
end

--------------------------------------------------------------------------------
-- destroy ALL objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- destroys all objects in pane
-- called when switching panes to reset memory usage
local function destroyAll() 
	gameData.gameEnd = true
	
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
one.load = load
one.destroyAll = destroyAll

return one

-- end of one.lua