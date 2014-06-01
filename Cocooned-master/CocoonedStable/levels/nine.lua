--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- nine.lua
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
-- Level nine Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local nine = { 
	-- boolean for which pane is being used
	-- { Middle, Up, Down, Right, Left }
	panes = {true,true,false,true,true},
	-- Check to see which runes are available
	-- Choices: "none", "blueRune", "greenRune", "pinkRune", "purpleRune", "yellowRune"
	--             nil,    rune[1],     rune[2],    rune[3],      rune[4],      rune[5]
	runeAvailable = {["M"]= {"greenRune"}, 
					 ["U"]= {"purpleRune"}, 
					 ["D"]= {"none"}, 
					 ["R"]= {"none"}, 
					 ["L"]= {"none"}},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=20, ["y"]=18}},
	-- number of wisps in the level
	wispCount = 38,
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
		["fixedIceberg"] = 2,
		["worldPortal"] = 0
	},	
	["L"] = {
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
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 5,
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
		wisp[1].x, wisp[1].y = generate.tilesToPixels(10, 22)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(12, 20)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(14, 18)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(16, 20)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(18, 22)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 22)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(22, 21)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(24, 20)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(26, 18)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(28, 20)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(30, 22)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(32, 10)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(34, 12)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(30, 10)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(15, 4)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(13, 3)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(17, 3)

 		-- Rune 
 		rune[2].x, rune[2].y = generate.tilesToPixels(32, 11)			
		rune[2].isVisible = true

		-- Iceberg
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(14, 13)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(36, 2) 
		objects["fixedIceberg1"].time = 5500
		objects["fixedIceberg1"].movement = "fixed" 
				
		generate.gWisps(wisp, map, mapData, 1, 17, nine.wispCount)
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		--wisp[17].x, wisp[17].y = generate.tilesToPixels(22, 13)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(25, 10)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(18, 10)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(16, 12)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(13, 12)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(10, 12)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(7, 12)

		-- Fish
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(7, 11)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(2, 11)
 		objects["fish11"].time = 675
		objects["fish11"]:rotate(90)

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(20, 3)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(20, 8)
 		objects["fish21"].time = 675

		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(39, 16)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(28, 18)
		objects["fixedIceberg1"].time = 1100
		objects["fixedIceberg1"].movement = "fixed"

		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(29, 15)
		objects["fixedIceberg2"].eX, objects["fixedIceberg2"].eY = generate.tilesToPixels(29, 2)
		objects["fixedIceberg2"].time = 11000
		objects["fixedIceberg2"].movement = "fixed"  

		objects["fixedIceberg3"].x, objects["fixedIceberg3"].y = generate.tilesToPixels(25, 2)
		objects["fixedIceberg3"].eX, objects["fixedIceberg3"].eY = generate.tilesToPixels(16, 2)
		objects["fixedIceberg3"].time = 11000
		objects["fixedIceberg3"].movement = "fixed" 

		objects["fixedIceberg4"].x, objects["fixedIceberg4"].y = generate.tilesToPixels(16, 4)
		objects["fixedIceberg4"].eX, objects["fixedIceberg4"].eY = generate.tilesToPixels(16, 16)
		objects["fixedIceberg4"].time = 11000
		objects["fixedIceberg4"].movement = "fixed"  

		objects["fixedIceberg5"].x, objects["fixedIceberg5"].y = generate.tilesToPixels(14, 16)
		objects["fixedIceberg5"].eX, objects["fixedIceberg5"].eY = generate.tilesToPixels(8, 6)
		objects["fixedIceberg5"].time = 11000
		objects["fixedIceberg5"].movement = "fixed"    

		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(3, 3)
		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 18, 23, nine.wispCount)

	elseif mapData.pane == "U" then
		
		wisp[24].x, wisp[24].y = generate.tilesToPixels(20, 15)

		rune[4].x, rune[4].y = generate.tilesToPixels(5, 5)			
		rune[4].isVisible = true

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 24, 24, nine.wispCount)
	elseif mapData.pane == "R" then
		-- Wisps
		wisp[25].x, wisp[25].y = generate.tilesToPixels(33, 1)
		wisp[26].x, wisp[26].y = generate.tilesToPixels(31, 3)
		wisp[27].x, wisp[27].y = generate.tilesToPixels(33, 5)
		wisp[28].x, wisp[28].y = generate.tilesToPixels(36, 3)
		wisp[29].x, wisp[29].y = generate.tilesToPixels(18, 21)
		wisp[30].x, wisp[30].y = generate.tilesToPixels(21, 19)
		wisp[31].x, wisp[31].y = generate.tilesToPixels(25, 20)
		wisp[32].x, wisp[32].y = generate.tilesToPixels(28, 21)
		wisp[33].x, wisp[33].y = generate.tilesToPixels(30, 20)
		wisp[34].x, wisp[34].y = generate.tilesToPixels(33, 18)
		wisp[35].x, wisp[35].y = generate.tilesToPixels(37, 19)
		wisp[36].x, wisp[36].y = generate.tilesToPixels(30, 13)
		wisp[37].x, wisp[37].y = generate.tilesToPixels(19, 6)
		wisp[38].x, wisp[38].y = generate.tilesToPixels(20, 8)

		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(29, 16)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(29, 8) 
		objects["fixedIceberg1"].time = 5500
		objects["fixedIceberg1"].movement = "fixed" 

		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(2, 1)
		objects["fixedIceberg2"].eX, objects["fixedIceberg2"].eY = generate.tilesToPixels(16, 1) 
		objects["fixedIceberg2"].time = 5500
		objects["fixedIceberg2"].movement = "fixed"

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 25, 38, nine.wispCount)
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(nine, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(nine, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(nine, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = nine.panes
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
nine.load = load
nine.destroyAll = destroyAll

return nine
-- end of nine.lua