--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- one.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- generator for objects (generateObjects.lua)
local generate = require("generateObjects")

--------------------------------------------------------------------------------
-- Level One Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local one = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,true,false,true,false},
	-- number of wisps in the level
	wispCount = 30,
	waterCount = 10,
	--wallCount = 10,
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
		["redTotem"] = 2,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 1,
		["enemy"] = 0,
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
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 1,
		["wolf"] = 0,
		["fish1"] = 2,
		["fish2"] = 2,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0, 
		["enemy"] = 0,
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
local function load(pane, map, rune, objects, wisp, water)
	objectList = objects
	
	-- Check which pane
	if pane == "M" then

		--objects["wolf1"].x , objects["wolf1"].y = map.tilesToPixels(4, 3)
		--objects["wolf1"].direction, objects["wolf1"].distance = "right", 500
		--objects["wolf1"].alpha = 0.75
		
	
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(4, 12.5)

		-- Red Totem
		objects["redTotem1"].x, objects["redTotem1"].y = map.tilesToPixels(6, 10)
		objects["redTotem2"].x, objects["redTotem2"].y = map.tilesToPixels(6, 15)
		
		wisp[1].x, wisp[1].y = map.tilesToPixels(19, 7)
		wisp[2].x, wisp[2].y = map.tilesToPixels(19, 17)
		wisp[3].x, wisp[3].y = map.tilesToPixels(14, 12)
		wisp[4].x, wisp[4].y = map.tilesToPixels(24, 12)
		

		generate.gWisps(wisp, map, 1, 4)
		--generate.gWalls(wall, map, 1, 2)
	elseif pane == "U" then
		-- Red Aura
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(29, 13)		
		-- Green Aura
		objects["greenAura1"].x, objects["greenAura1"].y = map.tilesToPixels(36, 22)

		-- Swimming fishes
		objects["fish11"].x, objects["fish11"].y = map.tilesToPixels(12, 8)
		objects["fish11"].eX, objects["fish11"].eY = map.tilesToPixels(12, 19)
		objects["fish21"].eX, objects["fish21"].eY = map.tilesToPixels(16, 8)
		objects["fish21"].x, objects["fish21"].y = map.tilesToPixels(16, 19)
		objects["fish12"].x, objects["fish12"].y = map.tilesToPixels(20, 8)
		objects["fish12"].eX, objects["fish12"].eY = map.tilesToPixels(20, 19)
		objects["fish22"].eX, objects["fish22"].eY = map.tilesToPixels(24, 8)
		objects["fish22"].x, objects["fish22"].y = map.tilesToPixels(24, 19)
		
		objects["fish11"].time = 375
		objects["fish12"].time = 375
		objects["fish21"].time = 375
		objects["fish22"].time = 375
		
		-- Pink rune	
		rune[3].x, rune[3].y = map.tilesToPixels(3.5, 13)
		rune[3].isVisible = true
		
		wisp[10].x, wisp[10].y = map.tilesToPixels(7, 13)
		wisp[11].x, wisp[11].y = map.tilesToPixels(15.5, 13)
		wisp[12].x, wisp[12].y = map.tilesToPixels(18.5, 13)
		wisp[13].x, wisp[13].y = map.tilesToPixels(21.5, 13)
		wisp[14].x, wisp[14].y = map.tilesToPixels(24.5, 13)
		wisp[15].x, wisp[15].y = map.tilesToPixels(36, 14)
		wisp[16].x, wisp[16].y = map.tilesToPixels(36, 17)
		
		generate.gWisps(wisp, map, 10, 16)
	elseif pane == "D" then
		-- Blue rune
		rune[1].x, rune[1].y = map.tilesToPixels(19, 21)			
		rune[1].isVisible = true
				
		wisp[17].x, wisp[17].y = map.tilesToPixels(15, 4)
		wisp[18].x, wisp[18].y = map.tilesToPixels(19, 4)
		wisp[19].x, wisp[19].y = map.tilesToPixels(23, 4)
		wisp[20].x, wisp[20].y = map.tilesToPixels(17.5, 7)
		wisp[21].x, wisp[21].y = map.tilesToPixels(21, 7)
		wisp[22].x, wisp[22].y = map.tilesToPixels(19, 14)

		generate.gWisps(wisp, map, 17, 22)
	elseif pane == "R" then
		-- Green rune
		rune[4].x, rune[4].y = map.tilesToPixels(3.5, 3.5)
		rune[4].isVisible = true
		
		wisp[5].x, wisp[5].y = map.tilesToPixels(8.5, 4)
		wisp[6].x, wisp[6].y = map.tilesToPixels(11.5, 4)
		wisp[7].x, wisp[7].y = map.tilesToPixels(36, 17)
		wisp[8].x, wisp[8].y = map.tilesToPixels(36, 11)
		wisp[9].x, wisp[9].y = map.tilesToPixels(36, 14)

		generate.gWisps(wisp, map, 5, 9)
	elseif pane == "L" then
		wisp[23].x, wisp[23].y = map.tilesToPixels(8, 5.5)
		wisp[24].x, wisp[24].y = map.tilesToPixels(13, 5.5)
		wisp[25].x, wisp[25].y = map.tilesToPixels(18, 5.5)
		wisp[26].x, wisp[26].y = map.tilesToPixels(28.5, 12)
		wisp[27].x, wisp[27].y = map.tilesToPixels(8, 19)
		wisp[28].x, wisp[28].y = map.tilesToPixels(13, 19)
		wisp[29].x, wisp[29].y = map.tilesToPixels(18, 19)

		generate.gWisps(wisp, map, 23, 29)
	end

	-- generates all objects in pane when locations are set
	generate.gObjects(one, objects, map, pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(one, objects, map, pane)
	-- destroy the unused objects
	generate.destroyObjects(one, rune, wisp, water, objects)

	-- set which panes are avaiable for player
	map.panes = one.panes
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
one.load = load
one.destroyAll = destroyAll

return one

-- end of one.lua