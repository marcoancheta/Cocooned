--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- ten.lua
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
-- Level ten Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local ten = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,true,false,true,true},
	timer = 300,
	playerCount = 1,
<<<<<<< HEAD
	playerPos = {{["x"]=4, ["y"]=4},},
=======
	playerPos = {{["x"]=10, ["y"]=4},},
>>>>>>> origin/Derrick
	-- number of wisps in the level
	wispCount = 29,
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
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		wisp[1].x, wisp[1].y = generate.tilesToPixels(5, 21)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(15, 10)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(18, 8)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(23, 10)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(24, 14)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(21, 15)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(18, 15)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(16, 13)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(20, 8)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(1, 10)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(1, 14)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(2, 17)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(32, 1)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(36, 4)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(38, 10)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(34, 10)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(31, 6)

		-- Runes
		rune[2].x, rune[2].y = generate.tilesToPixels(3, 21)			
		rune[2].isVisible = true

		generate.gWisps(wisp, map, mapData, 1, 17, ten.wispCount)
	elseif mapData.pane == "L" then
		wisp[18].x, wisp[18].y = generate.tilesToPixels(3, 6)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(4, 5)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(6, 5)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(7, 6)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(8, 7)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(7, 8)
		wisp[24].x, wisp[24].y = generate.tilesToPixels(5, 8)
		wisp[25].x, wisp[25].y = generate.tilesToPixels(17, 18)
		wisp[26].x, wisp[26].y = generate.tilesToPixels(20, 20)
		wisp[27].x, wisp[27].y = generate.tilesToPixels(17, 21)
		wisp[28].x, wisp[28].y = generate.tilesToPixels(16, 21)
		wisp[29].x, wisp[29].y = generate.tilesToPixels(15, 19)

		generate.gWisps(wisp, map, mapData, 18, 29, ten.wispCount)
<<<<<<< HEAD

=======
	elseif mapData.pane == "U" then
		generate.gWater(map, mapData)
>>>>>>> origin/Derrick
	elseif mapData.pane == "R" then
		-- Fish
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(15, 15)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(22, 8)
 		objects["fish11"].time = 675

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(11, 12)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(26, 12)
 		objects["fish21"].time = 675

 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(15, 8)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(23, 15)
 		objects["fish12"].time = 675

 		objects["fish22"].x, objects["fish22"].y = generate.tilesToPixels(18, 7)
 		objects["fish22"].eX, objects["fish22"].eY = generate.tilesToPixels(19, 16)
 		objects["fish22"].time = 675

 		-- Exit portal
 		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(19, 12)
		generate.gWater(map, mapData)
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "U" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(ten, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(ten, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(ten, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = ten.panes
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