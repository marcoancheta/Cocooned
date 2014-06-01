--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofivedgame.com/)
-- five.lua
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
-- variable access for shadows
local shadows = require("utils.shadows")

--------------------------------------------------------------------------------
-- Level five Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local five = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,false,false,false,true},
	-- Check to see which runes are available
	-- Choices: "none", "blueRune", "greenRune", "pinkRune", "purpleRune", "yellowRune"
	--             nil,    rune[1],     rune[2],    rune[3],      rune[4],      rune[5]
	runeAvailable = {["M"]= {"pinkRune"}, 
					 ["U"]= {"none"}, 
					 ["D"]= {"none"}, 
					 ["R"]= {"none"}, 
					 ["L"]= {"none"}},
	-- Timer
	timer = 200,
	playerCount = 1,
	playerPos = {{["x"]=5, ["y"]=5}},
	-- number of wisps in the level
	wispCount = 16,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 1,
		["fish2"] = 1,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0,
		["enemy"] = 0,
		["fixedIceberg"] = 1,
		["worldPortal"] = 0,
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
		-- Pink rune	
		rune[3].x, rune[3].y = generate.tilesToPixels(3, 20)			
		rune[3].isVisible = true

		-- Fish 
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(12, 2)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(12, 11)
 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(22, 11)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(22, 2)
 		objects["fish11"].time = 675
 		objects["fish21"].time = 675

 		-- Iceberg
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(3, 8)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(3, 21)
		objects["fixedIceberg1"].time = 3800
		objects["fixedIceberg1"].movement = "fixed"
		
		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(17, 7)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(25, 7)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(32, 10)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(30, 15)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(23, 16)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 19)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(35, 14)
		
		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 1, 7, five.wispCount)
	elseif mapData.pane == "R" then
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
	elseif mapData.pane == "L" then
		wisp[8].x, wisp[8].y = generate.tilesToPixels(5, 7)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(11, 10)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(30, 14)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(32, 18)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(27, 10)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(22, 8)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(36, 20)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(13, 15)	
		wisp[16].x, wisp[16].y = generate.tilesToPixels(17, 11)	

		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(4, 4)

		-- Purple rune	
		--rune[4].x, rune[4].y = generate.tilesToPixels(1.5, 1.5)			
		--rune[4].isVisible = true
		
		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 8, 16, five.wispCount)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(five, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(five, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(five, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = five.panes
	map.front.itemGoal = 1

	-- set shadow angle for the world
	shadows.x = 0
	shadows.y = 0
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
five.load = load
five.destroyAll = destroyAll

return five
-- end of five.lua