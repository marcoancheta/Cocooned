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
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,true,true,true},
	timer = 300,
	playerCount = 1,
	-- number of wisps in the level
	wispCount = 35,
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
		["fixedIceberg"] = 1
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
		["fixedIceberg"] = 2
	},
	["R"] = {
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
		["fixedIceberg"] = 2
	},	
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 6,
		["fish2"] = 5,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 1, 
		["enemy"] = 0,
		["fixedIceberg"] = 5
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
		wisp[5].x, wisp[5].y = generate.tilesToPixels(18, 23)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(20, 23)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(22, 21)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(24, 20)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(26, 18)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(28, 20)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(30, 22)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(32, 10)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(31, 12)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(30, 10)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(15, 4)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(13, 3)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(17, 3)

 		-- Rune 
 		rune[2].x, rune[2].y = generate.tilesToPixels(25, 11)			
		rune[2].isVisible = true

		-- Iceberg
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(14, 13)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(36, 2) 
		objects["fixedIceberg1"].time = 5500
		objects["fixedIceberg1"].movement = "fixed" 
				
		generate.gWisps(wisp, map, mapData, 1, 17)
		--generate.gAuraWalls(map, mapData, "blueWall")
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

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(20, 3)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(20, 8)
 		objects["fish21"].time = 675

 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(3, 16)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(7, 16)
 		objects["fish12"].time = 675

 		objects["fish22"].x, objects["fish22"].y = generate.tilesToPixels(8, 18)
 		objects["fish22"].eX, objects["fish22"].eY = generate.tilesToPixels(10, 15)
 		objects["fish22"].time = 675

 		objects["fish13"].x, objects["fish13"].y = generate.tilesToPixels(15, 12)
 		objects["fish13"].eX, objects["fish13"].eY = generate.tilesToPixels(20, 12)
 		objects["fish13"].time = 675

 		objects["fish23"].x, objects["fish23"].y = generate.tilesToPixels(20, 12)
 		objects["fish23"].eX, objects["fish23"].eY = generate.tilesToPixels(20, 8)
 		objects["fish23"].time = 675

 		objects["fish14"].x, objects["fish14"].y = generate.tilesToPixels(15, 8)
 		objects["fish14"].eX, objects["fish14"].eY = generate.tilesToPixels(15, 4)
 		objects["fish14"].time = 675

 		objects["fish24"].x, objects["fish24"].y = generate.tilesToPixels(20, 4)
 		objects["fish24"].eX, objects["fish24"].eY = generate.tilesToPixels(25, 4)
 		objects["fish24"].time = 675

 		objects["fish15"].x, objects["fish15"].y = generate.tilesToPixels(25, 3)
 		objects["fish15"].eX, objects["fish15"].eY = generate.tilesToPixels(30, 4)
 		objects["fish15"].time = 675

 		objects["fish25"].x, objects["fish25"].y = generate.tilesToPixels(20, 4)
 		objects["fish25"].eX, objects["fish25"].eY = generate.tilesToPixels(25, 4)
 		objects["fish25"].time = 675

 		objects["fish16"].x, objects["fish16"].y = generate.tilesToPixels(25, 4)
 		objects["fish16"].eX, objects["fish16"].eY = generate.tilesToPixels(25, 48)
 		objects["fish16"].time = 675

		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(39, 16)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(28, 18)
		objects["fixedIceberg1"].time = 11000
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
		generate.gWisps(wisp, map, mapData, 18, 23)

	elseif mapData.pane == "U" then
		
		wisp[24].x, wisp[24].y = generate.tilesToPixels(7, 12)

		rune[4].x, rune[4].y = generate.tilesToPixels(20, 15)			
		rune[2].isVisible = true

		objects["fixedIceberg3"].x, objects["fixedIceberg3"].y = generate.tilesToPixels(35, 5)
		objects["fixedIceberg3"].time = 3800 --not needed if free
		objects["fixedIceberg3"].movement = "free" --fixed or free

		objects["fixedIceberg4"].x, objects["fixedIceberg4"].y = generate.tilesToPixels(18, 12)
		objects["fixedIceberg4"].time = 3800 --not needed if free
		objects["fixedIceberg4"].movement = "free" --fixed or free

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 24, 24)
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


		-- Auras
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = generate.tilesToPixels(19, 7)

		-- Icebergs
		objects["fixedIceberg1"].x, objects["fixedIceberg1"].y = generate.tilesToPixels(16, 16)
		objects["fixedIceberg1"].eX, objects["fixedIceberg1"].eY = generate.tilesToPixels(39, 10) 
		objects["fixedIceberg1"].time = 5500
		objects["fixedIceberg1"].movement = "fixed" 

		objects["fixedIceberg2"].x, objects["fixedIceberg2"].y = generate.tilesToPixels(12, 7)
		objects["fixedIceberg2"].eX, objects["fixedIceberg2"].eY = generate.tilesToPixels(16, 1) 
		objects["fixedIceberg2"].time = 5500
		objects["fixedIceberg2"].movement = "fixed"

		generate.gWater(map, mapData)
		generate.gWisps(wisp, map, mapData, 25, 35)
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
nine.load = load
nine.destroyAll = destroyAll

return nine
-- end of nine.lua