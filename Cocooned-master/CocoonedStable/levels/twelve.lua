--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- twelve.lua
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
-- Level twelve Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local twelve = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,false,false,true,true},
	-- Check to see which runes are available
	-- Choices: "none", "blueRune", "greenRune", "pinkRune", "purpleRune", "yellowRune"
	--             nil,    rune[1],     rune[2],    rune[3],      rune[4],      rune[5]
	runeAvailable = {["M"]= {"none"}, 
					 ["U"]= {"none"}, 
					 ["D"]= {"none"}, 
					 ["R"]= {"purpleRune"}, 
					 ["L"]= {"none"}},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=16, ["y"]=12},},
	-- number of wisps in the level
	wispCount = 4,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 2,
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
		["blueAura"] = 1,
		["redAura"] = 0,
		["greenAura"] = 2,
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
		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(27, 8)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(29, 11)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(27, 14)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(29, 17)

		-- Auras 
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(16, 8)

		objects["greenAura2"]:setSequence("move")
		objects["greenAura2"]:play()
		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(4, 11)

		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(37, 12)
		
		-- Generate objects 
		generate.gWisps(wisp, map, mapData, 1, 4, twelve.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "R" then
		-- Auras 
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(2, 20)

		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(8, 22)

		objects["greenAura2"]:setSequence("move")
		objects["greenAura2"]:play()
		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(18, 1)

		--objects["redAura1"]:setSequence("move")
		--objects["redAura1"]:play()
		--objects["redAura1"].x, objects["redAura1"].y = generate.tilesToPixels(6, 16)

		-- Shrink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(10, 11)			
		rune[4].isVisible = true

		--generate.gWater(map, mapData)
		--generate.gWisps(wisp, map, mapData, 24, 39, twelve.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")
		generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		generate.gAuraWalls(map, mapData, "greenWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(twelve, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(twelve, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(twelve, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = twelve.panes
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
twelve.load = load
twelve.destroyAll = destroyAll

return twelve
-- end of twelve.lua