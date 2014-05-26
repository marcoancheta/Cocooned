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
	-- { Middle, Up, Down, Right, Left }
	panes = {true,true,true,true,true},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=20, ["y"]=15},},
	-- number of wisps in the level
	wispCount = 0,
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 2,
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
		["fixedIceberg"] = 4,
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
		--wisp[1].x, wisp[1].y = generate.tilesToPixels(25, 17)
		-- Exit portal
 		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(2, 11)

		-- Break objects rune
		rune[4].x, rune[4].y = generate.tilesToPixels(3, 21)			
		rune[4].isVisible = true
	
		--generate.gWisps(wisp, map, mapData, 1, 25, fourtween.wispCount)
		--generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(2, 3)			
		rune[2].isVisible = true
		generate.gWater(map, mapData)
	elseif mapData.pane == "U" then
		-- Slow time rune
		rune[3].x, rune[3].y = generate.tilesToPixels(3, 2)			
		rune[3].isVisible = true

		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(24, 6)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(24, 15)

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(20, 16)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(20, 6)

		objects["greenAura1"]:setSequence("move")
 		objects["greenAura1"]:play()
 		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(37, 20)

 		objects["greenAura2"]:setSequence("move")
 		objects["greenAura2"]:play()
 		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(22, 21)

 		generate.gAuraWalls(map, mapData, "greenWall")
 		generate.gWater(map, mapData)
	elseif mapData.pane == "R" then
		-- Slow time rune
		rune[3].x, rune[3].y = generate.tilesToPixels(19, 2)			
		rune[3].isVisible = true

		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(24, 10)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(24, 19)
		objects["fixedIceberg1"].time = 7000
		objects["fixedIceberg1"].movement = "fixed" 

		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(21, 19)
		objects["fixedIceberg2"].eX, objects["fixedIceberg2"].eY = generate.tilesToPixels(14, 19)
		objects["fixedIceberg2"].time = 7000
		objects["fixedIceberg2"].movement = "fixed" 

		objects["fixedIceberg3"].x, objects["fixedIceberg3"].y = generate.tilesToPixels(14, 19)
		objects["fixedIceberg3"].eX, objects["fixedIceberg3"].eY = generate.tilesToPixels(13, 6)
		objects["fixedIceberg3"].time = 7000
		objects["fixedIceberg3"].movement = "fixed" 

		objects["fixedIceberg4"].x, objects["fixedIceberg4"].y = generate.tilesToPixels(5, 11)
		objects["fixedIceberg4"].eX, objects["fixedIceberg4"].eY = generate.tilesToPixels(5, 21)
		objects["fixedIceberg4"].time = 7000
		objects["fixedIceberg4"].movement = "fixed" 

		generate.gWater(map, mapData)
	elseif mapData.pane == "D" then
		-- Shrink rune
		rune[4].x, rune[4].y = generate.tilesToPixels(38, 11)			
		rune[4].isVisible = true
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(fourteen, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(fourteen, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(fourteen, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = fourteen.panes
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