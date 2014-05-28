--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- four.lua
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
-- Level four Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local four = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,false,false,false,true},
	timer = 180,
	playerCount = 1,
	playerPos = {{["x"]=21, ["y"]=22}},
	-- number of wisps in the level
	wispCount = 23,
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
		["exitPortal"] = 0,
		["enemy"] = 0,
		["fixedIceberg"] = 1,
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
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 3,
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

	if mapData.pane == "L" then
		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(25, 17)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(25, 10)
		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(25, 10)
		objects["fixedIceberg2"].eX, objects["fixedIceberg2"].eY = generate.tilesToPixels(4, 10)
		objects["fixedIceberg3"].x, objects["fixedIceberg3"].y = generate.tilesToPixels(10, 10)
		objects["fixedIceberg3"].eX, objects["fixedIceberg3"].eY = generate.tilesToPixels(10, 5)
		objects["fixedIceberg1"].time = 7000
		objects["fixedIceberg2"].time = 11000
		objects["fixedIceberg3"].time = 3800
		objects["fixedIceberg1"].movement = "fixed" 
		objects["fixedIceberg2"].movement = "fixed" 
		objects["fixedIceberg3"].movement = "fixed" 
		
		-- Exit Portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(14.5, 3)

		-- Wisps 
		wisp[1].x, wisp[1].y = generate.tilesToPixels(25, 17)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(25, 15)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(25, 13)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(25, 10)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(22, 10)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 10)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(18, 10)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(16, 10)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(14, 10)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(12, 10)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(10, 10)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(8, 10)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(6, 10)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(4, 10)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(10, 8)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(10, 6)
				
		generate.gWisps(wisp, map, mapData, 1, 16, four.wispCount)
		--generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "M" then
		wisp[17].x, wisp[17].y = generate.tilesToPixels(22, 13)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(25, 10)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(18, 10)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(16, 12)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(13, 12)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(10, 12)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(7, 12)

		rune[2].x, rune[2].y = generate.tilesToPixels(10, 1.5)			
		rune[2].isVisible = true

		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(10, 8)
		objects["fixedIceberg1"].time = 3800 --not needed if free
		objects["fixedIceberg1"].movement = "free" --fixed or free

		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(13, 1.5)

		generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 17, 23, four.wispCount)

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
	generate.gObjects(four, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(four, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(four, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = four.panes
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
four.load = load
four.destroyAll = destroyAll

return four
-- end of four.lua