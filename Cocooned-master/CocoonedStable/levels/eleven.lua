--------------------------------------------------------------------------------
 --------------------------------------------------------------------------------
 -- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
 -- eleven.lua
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
 -- Level eleven Variables
 --------------------------------------------------------------------------------
 -- Updated by: Marco
 --------------------------------------------------------------------------------
 local eleven = { 
 	-- boolean for which pane is being used
 	-- { Middle, Down, Up, Right, Left }
 	panes = {true,false,false,true,false},
 	timer = 300,
 	playerCount = 1,
 	playerPos = {	 {["x"]=4, ["y"]=4},
 
 				},
 	-- number of wisps in the level
 	wispCount = 39,
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
 		["fixedIceberg"] = 0
 	},
 	["R"] = {
 		["blueAura"] = 2,
 		["redAura"] = 0,
 		["greenAura"] = 0,
 		["wolf"] = 0,
 		["fish1"] = 1,
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
 		wisp[1].x, wisp[1].y = generate.tilesToPixels(2, 7)
 		wisp[2].x, wisp[2].y = generate.tilesToPixels(2, 10)
 		wisp[3].x, wisp[3].y = generate.tilesToPixels(3, 13)
 		wisp[4].x, wisp[4].y = generate.tilesToPixels(4, 16)
 		wisp[5].x, wisp[5].y = generate.tilesToPixels(6, 19)
 		wisp[6].x, wisp[6].y = generate.tilesToPixels(11, 21)
 		wisp[7].x, wisp[7].y = generate.tilesToPixels(31, 20)
 		wisp[8].x, wisp[8].y = generate.tilesToPixels(18, 17)
 		wisp[9].x, wisp[9].y = generate.tilesToPixels(36, 10)
 		wisp[10].x, wisp[10].y = generate.tilesToPixels(33, 3)
 		wisp[11].x, wisp[11].y = generate.tilesToPixels(28, 1)
 		wisp[12].x, wisp[12].y = generate.tilesToPixels(13, 3)
 		wisp[13].x, wisp[13].y = generate.tilesToPixels(11, 4)
 		wisp[14].x, wisp[14].y = generate.tilesToPixels(9, 7)
 		wisp[15].x, wisp[15].y = generate.tilesToPixels(9, 9)
 		wisp[16].x, wisp[16].y = generate.tilesToPixels(9, 12)
 		wisp[17].x, wisp[17].y = generate.tilesToPixels(11, 14)
 		wisp[18].x, wisp[18].y = generate.tilesToPixels(14, 16)
 		wisp[19].x, wisp[19].y = generate.tilesToPixels(23, 17)		
 		wisp[20].x, wisp[20].y = generate.tilesToPixels(27, 16)
 		wisp[21].x, wisp[21].y = generate.tilesToPixels(30, 13)
 		wisp[22].x, wisp[22].y = generate.tilesToPixels(12, 15)
 		wisp[23].x, wisp[23].y = generate.tilesToPixels(29, 8)
 
 		-- Exit portal
  		objects["exitPortal1"]:setSequence("still")
 		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(20, 9)
 
 		generate.gWisps(wisp, map, mapData, 1, 23)
 		--generate.gAuraWalls(map, mapData, "blueWall")
 		generate.gWater(map, mapData)
 	elseif mapData.pane == "L" then
 
 
 	elseif mapData.pane == "U" then
 
 	elseif mapData.pane == "R" then
 		-- Wisps
 		wisp[24].x, wisp[24].y = generate.tilesToPixels(5, 15)
 		wisp[25].x, wisp[25].y = generate.tilesToPixels(7, 7)
 		wisp[26].x, wisp[26].y = generate.tilesToPixels(11, 4)
 		wisp[27].x, wisp[27].y = generate.tilesToPixels(17, 2)
 		wisp[28].x, wisp[28].y = generate.tilesToPixels(22, 1)
 		wisp[29].x, wisp[29].y = generate.tilesToPixels(30, 1)
 		wisp[30].x, wisp[30].y = generate.tilesToPixels(35, 4)
 		wisp[31].x, wisp[31].y = generate.tilesToPixels(37, 7)
 		wisp[32].x, wisp[32].y = generate.tilesToPixels(33, 18)
 		wisp[33].x, wisp[33].y = generate.tilesToPixels(36, 14)
 		wisp[34].x, wisp[34].y = generate.tilesToPixels(25, 18)
 		wisp[35].x, wisp[35].y = generate.tilesToPixels(19, 17)
 		wisp[36].x, wisp[36].y = generate.tilesToPixels(24, 7)
 		wisp[37].x, wisp[37].y = generate.tilesToPixels(22, 9)
 		wisp[38].x, wisp[38].y = generate.tilesToPixels(24, 11)
 		wisp[39].x, wisp[39].y = generate.tilesToPixels(26, 9)
 
 
 		-- Fish
 		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(30, 17)
  		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(30, 22)
  		objects["fish11"].time = 675
 
  		objects["blueAura1"]:setSequence("move")
 		objects["blueAura1"]:play()
 		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(24, 9)
 
 		objects["blueAura2"]:setSequence("move")
 		objects["blueAura2"]:play()
 		objects["blueAura2"].x, objects["blueAura2"].y = generate.tilesToPixels(7, 21)
 
 		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(1, 15)			
 		rune[2].isVisible = true
 
 		generate.gWater(map, mapData)
 		generate.gWisps(wisp, map, mapData, 24, 39)
 
 
 
 	elseif mapData.pane == "D" then
 		print("You shouldn't be in here...")
 	end
 
 	-- generates all objects in pane when locations are set
 	generate.gObjects(eleven, objects, map, mapData, rune)
 	-- generate all moveable objects in pane when locations are set
 	mObjects = generate.gMObjects(eleven, objects, map, mapData)
 	-- destroy the unused objects
 	generate.destroyObjects(eleven, rune, wisp, water, wall, objects)
 
 	-- set which panes are avaiable for player
 	map.front.panes = eleven.panes
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
 eleven.load = load
 eleven.destroyAll = destroyAll
 
 return eleven
 -- end of eleven.lua