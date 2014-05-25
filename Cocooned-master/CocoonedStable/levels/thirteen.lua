--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- thirteen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
<<<<<<< HEAD

=======
>>>>>>> origin/Derrick
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
-- Level thirteen Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local thirteen = { 
	-- boolean for which pane is being used
<<<<<<< HEAD
	-- { Middle, Down, Up, Right, Left }
	panes = {true,true,true,true,true},
	timer = 300,
	playerCount = 1,
	playerPos = {	 {["x"]=20, ["y"]=15},

				},
	-- number of wisps in the level
	wispCount = 0,
=======
	-- { Middle, Up, Down, Right, Left }
	panes = {true,false,false,true,false},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=4, ["y"]=4},},
	-- number of wisps in the level
	wispCount = 1,
>>>>>>> origin/Derrick
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
<<<<<<< HEAD
		["greenAura"] = 4,
=======
		["greenAura"] = 0,
>>>>>>> origin/Derrick
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
<<<<<<< HEAD
		["exitPortal"] = 1,
		["enemy"] = 0,
		["fixedIceberg"] = 0
	},
	["D"] = {
		["blueAura"] = 1,
=======
		["exitPortal"] = 0,
		["enemy"] = 0,
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
	},
	["D"] = {
		["blueAura"] = 0,
>>>>>>> origin/Derrick
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
<<<<<<< HEAD
		["fixedIceberg"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 1,
=======
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
>>>>>>> origin/Derrick
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
<<<<<<< HEAD
		["fixedIceberg"] = 0
=======
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
>>>>>>> origin/Derrick
	},
	["R"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
<<<<<<< HEAD
		["greenAura"] = 1,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 1,
=======
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
>>>>>>> origin/Derrick
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
<<<<<<< HEAD
		["fixedIceberg"] = 0
=======
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
>>>>>>> origin/Derrick
	},	
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
<<<<<<< HEAD
		["greenAura"] = 2,
=======
		["greenAura"] = 0,
>>>>>>> origin/Derrick
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
<<<<<<< HEAD
		["fixedIceberg"] = 0
=======
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
>>>>>>> origin/Derrick
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
<<<<<<< HEAD
		-- Check which pane

	if mapData.pane == "M" then
		-- Wisps
		--wisp[1].x, wisp[1].y = generate.tilesToPixels(25, 17)

		-- Auras
		objects["greenAura1"]:setSequence("move")
 		objects["greenAura1"]:play()
 		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(3, 20)

 		objects["greenAura2"]:setSequence("move")
 		objects["greenAura2"]:play()
 		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(37, 20)

 		objects["greenAura3"]:setSequence("move")
 		objects["greenAura3"]:play()
 		objects["greenAura3"].x, objects["greenAura3"].y = generate.tilesToPixels(36, 2)

		-- Exit portal
 		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(3, 2)
				
		--generate.gWisps(wisp, map, mapData, 1, 25)
		--generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(4, 1)			
		rune[2].isVisible = true

		-- Auras
		objects["greenAura1"]:setSequence("move")
 		objects["greenAura1"]:play()
 		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(2, 20)

 		-- Auras
		objects["greenAura2"]:setSequence("move")
 		objects["greenAura2"]:play()
 		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(8, 3)

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
		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(1, 12)			
		rune[2].isVisible = true

		-- Fish 
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(12, 4)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(12, 18)
 		objects["fish11"].time = 675

 		-- Fish 
		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(20, 17)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(20, 4)
 		objects["fish21"].time = 675

 		-- Fish 
		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(29, 3)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(29, 17)
 		objects["fish12"].time = 675

		-- Auras
		objects["greenAura1"]:setSequence("move")
 		objects["greenAura1"]:play()
 		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(2, 2)
	elseif mapData.pane == "D" then
		objects["blueAura1"]:setSequence("move")
 		objects["blueAura1"]:play()
 		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(39, 11)
=======
	-- Check which pane
	if mapData.pane == "M" then
		--generate.gWisps(wisp, map, mapData, 1, 23, thirteen.wispCount)
		--generate.gAuraWalls(map, mapData, "blueWall")
		--generate.gWater(map, mapData)
	elseif mapData.pane == "R" then
		--generate.gWater(map, mapData)
		--generate.gWisps(wisp, map, mapData, 24, 39, thirteen.wispCount)
	elseif mapData.pane == "L" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
>>>>>>> origin/Derrick
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(thirteen, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(thirteen, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(thirteen, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = thirteen.panes
<<<<<<< HEAD
	map.front.itemGoal = 2
=======
	map.front.itemGoal = 1
>>>>>>> origin/Derrick
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
thirteen.load = load
thirteen.destroyAll = destroyAll

return thirteen
-- end of thirteen.lua