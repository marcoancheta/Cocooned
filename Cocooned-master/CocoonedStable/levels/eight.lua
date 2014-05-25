--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocofourdgame.com/)
-- eight.lua
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
-- Level eight Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local eight = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,false,false},
	timer = 300,
	playerCount = 1,
	playerPos = {{["x"]=20, ["y"]=15},},
	-- number of wisps in the level
	wispCount = 25,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["wolf"] = 0,
		["fish1"] = 7,
		["fish2"] = 8,
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
		-- Wisps
		wisp[1].x, wisp[1].y = generate.tilesToPixels(25, 17)
		wisp[2].x, wisp[2].y = generate.tilesToPixels(8, 10)
		wisp[3].x, wisp[3].y = generate.tilesToPixels(9, 12)
		wisp[4].x, wisp[4].y = generate.tilesToPixels(9, 5)
		wisp[5].x, wisp[5].y = generate.tilesToPixels(13, 5)
		wisp[6].x, wisp[6].y = generate.tilesToPixels(15, 8)
		wisp[7].x, wisp[7].y = generate.tilesToPixels(15, 11)
		wisp[8].x, wisp[8].y = generate.tilesToPixels(15, 15)
		wisp[9].x, wisp[9].y = generate.tilesToPixels(13, 19)
		wisp[10].x, wisp[10].y = generate.tilesToPixels(10, 21)
		wisp[11].x, wisp[11].y = generate.tilesToPixels(7, 12)
		wisp[12].x, wisp[12].y = generate.tilesToPixels(18, 6)
		wisp[13].x, wisp[13].y = generate.tilesToPixels(24, 5)
		wisp[14].x, wisp[14].y = generate.tilesToPixels(28, 4)
		wisp[15].x, wisp[15].y = generate.tilesToPixels(32, 3)
		wisp[16].x, wisp[16].y = generate.tilesToPixels(37, 3)
		wisp[17].x, wisp[17].y = generate.tilesToPixels(20, 11)
		wisp[18].x, wisp[18].y = generate.tilesToPixels(24, 14)
		wisp[19].x, wisp[19].y = generate.tilesToPixels(27, 11)
		wisp[20].x, wisp[20].y = generate.tilesToPixels(20, 13)
		wisp[21].x, wisp[21].y = generate.tilesToPixels(19, 19)
		wisp[22].x, wisp[22].y = generate.tilesToPixels(23, 19)
		wisp[23].x, wisp[23].y = generate.tilesToPixels(28, 21)
		wisp[24].x, wisp[24].y = generate.tilesToPixels(33, 21)
		wisp[25].x, wisp[25].y = generate.tilesToPixels(37, 21)

		-- Fish 
		objects["fish11"].x, objects["fish11"].y = generate.tilesToPixels(20, 3)
 		objects["fish11"].eX, objects["fish11"].eY = generate.tilesToPixels(20, 8)
 		objects["fish11"].time = 675

 		objects["fish21"].x, objects["fish21"].y = generate.tilesToPixels(25, 8)
 		objects["fish21"].eX, objects["fish21"].eY = generate.tilesToPixels(25, 3)
 		objects["fish21"].time = 675

 		objects["fish12"].x, objects["fish12"].y = generate.tilesToPixels(20, 9)
 		objects["fish12"].eX, objects["fish12"].eY = generate.tilesToPixels(20, 17)
 		objects["fish12"].time = 675

 		objects["fish22"].x, objects["fish22"].y = generate.tilesToPixels(25, 8)
 		objects["fish22"].eX, objects["fish22"].eY = generate.tilesToPixels(25, 17)
 		objects["fish22"].time = 675

 		objects["fish13"].x, objects["fish13"].y = generate.tilesToPixels(29, 8)
 		objects["fish13"].eX, objects["fish13"].eY = generate.tilesToPixels(29, 17)
 		objects["fish13"].time = 675

 		objects["fish23"].x, objects["fish23"].y = generate.tilesToPixels(22, 17)
 		objects["fish23"].eX, objects["fish23"].eY = generate.tilesToPixels(22, 9)
 		objects["fish23"].time = 675

 		objects["fish14"].x, objects["fish14"].y = generate.tilesToPixels(27, 17)
 		objects["fish14"].eX, objects["fish14"].eY = generate.tilesToPixels(27, 8)
 		objects["fish14"].time = 675

 		objects["fish24"].x, objects["fish24"].y = generate.tilesToPixels(18, 17)
 		objects["fish24"].eX, objects["fish24"].eY = generate.tilesToPixels(18, 22)
 		objects["fish24"].time = 675

 		objects["fish15"].x, objects["fish15"].y = generate.tilesToPixels(21, 22)
 		objects["fish15"].eX, objects["fish15"].eY = generate.tilesToPixels(21, 17)
 		objects["fish15"].time = 675

 		objects["fish26"].x, objects["fish26"].y = generate.tilesToPixels(23, 17)
 		objects["fish26"].eX, objects["fish26"].eY = generate.tilesToPixels(23, 22)
 		objects["fish26"].time = 675

 		objects["fish16"].x, objects["fish16"].y = generate.tilesToPixels(6, 11)
 		objects["fish16"].eX, objects["fish16"].eY = generate.tilesToPixels(6, 7)
 		objects["fish16"].time = 675

 		objects["fish27"].x, objects["fish27"].y = generate.tilesToPixels(11, 7)
 		objects["fish27"].eX, objects["fish27"].eY = generate.tilesToPixels(11, 11)
 		objects["fish27"].time = 675

 		objects["fish17"].x, objects["fish17"].y = generate.tilesToPixels(6, 13)
 		objects["fish17"].eX, objects["fish17"].eY = generate.tilesToPixels(6, 18)
 		objects["fish17"].time = 675

 		objects["fish28"].x, objects["fish28"].y = generate.tilesToPixels(12, 17)
 		objects["fish28"].eX, objects["fish28"].eY = generate.tilesToPixels(12, 12)
 		objects["fish28"].time = 675

 		-- Runes
 		rune[2].x, rune[2].y = generate.tilesToPixels(37, 3)			
		rune[2].isVisible = true

		rune[4].x, rune[4].y = generate.tilesToPixels(37, 21)			
		rune[4].isVisible = true

		-- Exit portal
 		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = generate.tilesToPixels(37, 12)
				
		generate.gWisps(wisp, map, mapData, 1, 25, eight.wispCount)
		--generate.gAuraWalls(map, mapData, "blueWall")
		generate.gWater(map, mapData)
	elseif mapData.pane == "L" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "U" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "R" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	elseif mapData.pane == "D" then
		if gameData.debugMode then
			print("You shouldn't be in here...")
		end
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(eight, objects, map, mapData, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(eight, objects, map, mapData)
	-- destroy the unused objects
	generate.destroyObjects(eight, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.front.panes = eight.panes
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
eight.load = load
eight.destroyAll = destroyAll

return eight
-- end of eight.lua