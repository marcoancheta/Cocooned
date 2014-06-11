--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- seven.lua
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
-- Level seven Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local seven = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,false,false,true,true},
	-- Check to see which runes are available
	-- Choices: "none", "blueRune", "greenRune", "pinkRune", "purpleRune", "yellowRune"
	--             nil,    rune[1],     rune[2],    rune[3],      rune[4],      rune[5]
	runeAvailable = {["M"]= {"blueRune"}, 
					 ["U"]= {"none"}, 
					 ["D"]= {"none"}, 
					 ["R"]= {"blueRune"}, 
					 ["L"]= {"purpleRune"}},
	timer = 300,
	playerCount = 2,
	playerPos = {{["x"]=8, ["y"]=6}, 
				 {["x"]=11, ["y"]=6}},
	-- number of wisps in the level
	wispCount = 27,
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
		["blueAura"] = 2,
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
local function load(mapData, map, rune, objects, wisp, water, wall, auraWall, players, player)
	objectList = objects
		-- Check which pane

	if mapData.pane == "M" then
		-- Break walls rune
		rune[1].x, rune[1].y = generate.tilesToPixels(35, 3)			
		rune[1].isVisible = true

		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(12, 6)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(14, 8)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(16, 10)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(28, 16)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(30, 18)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(32, 20)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(34, 22)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(18, 12)


		-- set shadow angle for the pane
		shadows.x = 1
		shadows.y = 18
				
		generate.gWisps(wisp, map, mapData, 1, 8, seven.wispCount)
		generate.gBreakWalls(map, mapData, "breakWall")		
		-- generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		wisp[9].x, wisp[9].y = generate.tilesToPixels(7, 5)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(7, 7)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(7, 9)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(7, 11)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(9, 11)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(11, 11)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(13, 11)
		
		-- Shrink rune 
		rune[4].x, rune[4].y = generate.tilesToPixels(35.5, 14.5)			
		rune[4].isVisible = true

		-- Exit Portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(5, 21)

		-- set shadow angle for the pane
		shadows.x = 1
		shadows.y = 18

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 9, 15, seven.wispCount)
	elseif mapData.pane == "R" then	
		-- Blue Aura
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(6,2)

		-- Blue Aura
		objects["blueAura2"]:setSequence("move")
		objects["blueAura2"]:play()
		objects["blueAura2"].x, objects["blueAura2"].y = generate.tilesToPixels(28,9)

		-- Blue Aura
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = generate.tilesToPixels(25,13)

		-- Break walls rune
		rune[1].x, rune[1].y = generate.tilesToPixels(19, 23)			
		rune[1].isVisible = true

		-- Wisps
		wisp[16].x, wisp[16].y = generate.tilesToPixels(15, 6)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(15, 9)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(15, 13)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(15, 17)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(8, 17)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(15, 5)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(18, 5)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(21, 5)
		wisp[24].x, wisp[24].y = generate.tilesToPixels(38, 17)
		wisp[25].x, wisp[25].y = generate.tilesToPixels(34, 17)
		wisp[26].x, wisp[26].y = generate.tilesToPixels(30, 17)
		wisp[27].x, wisp[27].y = generate.tilesToPixels(26, 17)

		-- set shadow angle for the pane
		shadows.x = 1
		shadows.y = 18

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 16, 27, seven.wispCount)
	elseif mapData.pane == "U" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(seven, objects, map, mapData, rune, player)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(seven, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(seven, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = seven.panes
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
seven.load = load
seven.destroyAll = destroyAll

return seven
-- end of seven.lua