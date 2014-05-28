--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- thirteen.lua
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
-- Level thirteen Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local thirteen = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,true,false,true,true},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=21, ["y"]=12},},
	-- number of wisps in the level
	wispCount = 23,

	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 4,
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
		["fixedIceberg"] = 0,
		["worldPortal"] = 0
	},
	["R"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 1,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 1,
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
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 1,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 1,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
		["fixedIceberg"] = 1,
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
		wisp[1].x, wisp[1].y = generate.tilesToPixels(21, 9)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(21, 15)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(16, 12)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(26, 12)

		-- Auras 
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(37, 21)

		objects["greenAura2"]:setSequence("move")
		objects["greenAura2"]:play()
		objects["greenAura2"].x, objects["greenAura2"].y = generate.tilesToPixels(35, 2)

		objects["greenAura3"]:setSequence("move")
		objects["greenAura3"]:play()
		objects["greenAura3"].x, objects["greenAura3"].y = generate.tilesToPixels(3, 21)

		objects["greenAura4"]:setSequence("move")
		objects["greenAura4"]:play()
		objects["greenAura4"].x, objects["greenAura4"].y = generate.tilesToPixels(21, 2)

		-- Exit portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(4, 3)

		generate.gWisps(wisp, map, mapData, 1, 4, thirteen.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")

	elseif mapData.pane == "R" then
		-- Auras 
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(3, 2)

		-- Runes
		-- Slow time 
		rune[3].x, rune[3].y = generate.tilesToPixels(2, 12)			
		rune[3].isVisible = true

		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(10, 3)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(32, 3)
		objects["fixedIceberg1"].time = 7000
		objects["fixedIceberg1"].movement = "fixed" 

		-- Fish
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(13, 5)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(13, 18)

 		-- Fish
		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(21, 18)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(21, 5)

 		-- Fish
		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(29, 5)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(29, 18)


		generate.gWater(map, mapData)
		--generate.gWisps(wisp, map, mapData, 24, 39, thirteen.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")

	elseif mapData.pane == "U" then
		-- Wisps
		wisp[5].x, wisp[5].y = generate.tilesToPixels(5, 17)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(13, 17)	
		wisp[7].x, wisp[7].y = generate.tilesToPixels(9, 13)		
		wisp[8].x, wisp[8].y = generate.tilesToPixels(9, 20)		
		wisp[9].x, wisp[9].y = generate.tilesToPixels(6, 14)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(12, 20)		
		wisp[11].x, wisp[11].y = generate.tilesToPixels(15, 5)		
		wisp[12].x, wisp[12].y = generate.tilesToPixels(20, 8)		
		wisp[13].x, wisp[13].y = generate.tilesToPixels(18, 12)		
		wisp[14].x, wisp[14].y = generate.tilesToPixels(23, 17)		
		wisp[15].x, wisp[15].y = generate.tilesToPixels(24, 13)		
		wisp[16].x, wisp[16].y = generate.tilesToPixels(28, 20)	
		wisp[17].x, wisp[17].y = generate.tilesToPixels(12, 14)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(6, 20)

		-- Auras
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(9, 17)

		-- Runes 
		-- Shrink
		rune[4].x, rune[4].y = generate.tilesToPixels(3, 3)			
		rune[4].isVisible = true
		-- Slow time 
		rune[3].x, rune[3].y = generate.tilesToPixels(36, 3)			
		rune[3].isVisible = true

		generate.gWisps(wisp, map, mapData, 5, 18, thirteen.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")
		generate.gWater(map, mapData)

	elseif mapData.pane == "L" then
		-- Wisps
		wisp[19].x, wisp[19].y = generate.tilesToPixels(14, 6)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(13, 9)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(25, 10)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(31, 9)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(36, 7)

		-- Auras 
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(3, 21)

		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(3, 15)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(3, 10)
		objects["fixedIceberg1"].time = 7000
		objects["fixedIceberg1"].movement = "fixed" 

		-- Fish
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(15, 5)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(19, 13)

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(26, 15)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(25, 7)

 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(36, 4)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(32, 14)

		-- Runes
		-- Slow time 
		rune[3].x, rune[3].y = generate.tilesToPixels(4, 3)	
		rune[3].isVisible = true

		generate.gWisps(wisp, map, mapData, 19, 23, thirteen.wispCount)
		generate.gAuraWalls(map, mapData, "greenWall")
		generate.gWater(map, mapData)

	elseif mapData.pane == "D" then
		
		generate.gAuraWalls(map, mapData, "greenWall")
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(thirteen, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(thirteen, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(thirteen, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = thirteen.panes
	map.front.itemGoal = 4
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
thirteen.load = load
thirteen.destroyAll = destroyAll

return thirteen
-- end of thirteen.lua