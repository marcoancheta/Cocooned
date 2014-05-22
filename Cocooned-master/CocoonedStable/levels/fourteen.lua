--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- fourteen.lua
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
-- Level fourteen Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local fourteen = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,true,true,true,true},
	timer = 300,
	playerCount = 1,
	playerPos = {	 {["x"]=20, ["y"]=15},

				},
	-- number of wisps in the level
	wispCount = 25,
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
		["exitPortal"] = 0, 
		["enemy"] = 0,
		["fixedIceberg"] = 0
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
		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(25, 17)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(8, 10)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(9, 12)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(9, 5)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(13, 5)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(15, 8)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(15, 11)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(15, 15)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(13, 19)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(10, 21)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(7, 12)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(18, 6)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(24, 5)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(28, 4)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(32, 3)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(37, 3)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(20, 11)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(24, 14)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(27, 11)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(20, 13)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(19, 19)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(23, 19)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(28, 21)
		wisp[24].x, wisp[24].y = generate.tilesToPixels(33, 21)
		wisp[25].x, wisp[25].y = generate.tilesToPixels(37, 21)

		-- Fish

 		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(2, 21)			
		rune[2].isVisible = true

		-- Exit portal
 		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(2, 11)
				
		generate.gWisps(wisp, map, mapData, 1, 25)
		--generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(2, 21)			
		rune[2].isVisible = true

	elseif mapData.pane == "U" then
		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(2, 1)			
		rune[2].isVisible = true

		objects["greenAura1"]:setSequence("move")
 		objects["greenAura1"]:play()
 		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(37, 20)

 		objects["redAura1"]:setSequence("move")
 		objects["redAura1"]:play()
 		objects["redAura1"].x, objects["redAura1"].y = generate.tilesToPixels(24, 10)

	elseif mapData.pane == "R" then

	elseif mapData.pane == "D" then
		objects["blueAura1"]:setSequence("move")
 		objects["blueAura1"]:play()
 		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(39, 11)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(fourteen, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(fourteen, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(fourteen, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = fourteen.panes
	map.front.itemGoal = 2
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
fourteen.load = load
fourteen.destroyAll = destroyAll

return fourteen
-- end of fourteen.lua