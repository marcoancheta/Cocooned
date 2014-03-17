--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- eight.lua
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
-- Level eight Variables
--------------------------------------------------------------------------------
-- Updated by: Marco + Mark-o =D
--------------------------------------------------------------------------------
local eight = { 
	-- boolean for which pane is being used
	-- { Middle, Down, Up, Right, Left }
	panes = {true,false,false,true,true},
	-- number of wisps in the level
	wispCount = 36,
	waterCount = 91,
	wallCount = 2,
	auraWallCount = 0,
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
	["R"] = {
		["blueAura"] = 1,
		["redAura"] = 1,
		["greenAura"] = 1,
		["wolf"] = 0,
		["fish1"] = 1,
		["fish2"] = 1,
		["blueTotem"] = 1,
		["redTotem"] = 1,
		["greenTotem"] = 1,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0,
		["enemy"] = 1,
	},	
	["L"] = {
		["blueAura"] = 1,
		["redAura"] = 1,
		["greenAura"] = 0,
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

		-- Portal
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(38, 11)

        -- Shrink Rune (?)
		rune[4].x, rune[4].y = map.tilesToPixels(0, 11)			
		rune[4].isVisible = true
				
		-- Wisps
		
		wisp[1].x, wisp[1].y = map.tilesToPixels(14, 4)
		wisp[2].x, wisp[2].y = map.tilesToPixels(12, 6)
		wisp[3].x, wisp[3].y = map.tilesToPixels(25, 4)
		wisp[4].x, wisp[4].y = map.tilesToPixels(27, 6)
		wisp[5].x, wisp[5].y = map.tilesToPixels(12, 17)
		wisp[6].x, wisp[6].y = map.tilesToPixels(14, 19)
		wisp[7].x, wisp[7].y = map.tilesToPixels(27, 17)
		wisp[8].x, wisp[8].y = map.tilesToPixels(25, 19)
		
		generate.gWisps(wisp, map, mapData, 1, 4)
		generate.gWater(water, map, mapData, 1, 1)
		generate.gWalls(wall, map, mapData, 1, 2)

	elseif mapData.pane == "L" then
	    --Blue Aura
		objects["blueAura5"]:setSequence("move")
		objects["blueAura5"]:play()
		objects["blueAura5"].x, objects["blueAura5"].y = map.tilesToPixels(19, 0)	

		objects["blueAura6"]:setSequence("move")
		objects["blueAura6"]:play()
		objects["blueAura6"].x, objects["blueAura6"].y = map.tilesToPixels(19, 22)

		--Red Aura
		objects["redAura7"]:setSequence("move")
		objects["redAura7"]:play()
		objects["redAura7"].x, objects["redAura7"].y = map.tilesToPixels(10, 11)

		objects["fish17"].x, objects["fish17"].y = map.tilesToPixels(3,10)
        objects["fish17"].eX, objects["fish17"].eY = map.tilesToPixels(3,13)

        objects["fish18"].x, objects["fish18"].y = map.tilesToPixels(5,10)
        objects["fish18"].eX, objects["fish18"].eY = map.tilesToPixels(5,13)

        objects["fish19"].x, objects["fish19"].y = map.tilesToPixels(7,10)
        objects["fish19"].eX, objects["fish19"].eY = map.tilesToPixels(7,13)

		-- Pink rune
		rune[4].x, rune[4].y = map.tilesToPixels(19, 11)			
		rune[4].isVisible = true

		rune[3].x, rune[3].y = map.tilesToPixels(0, 11)			
		rune[3].isVisible = true

		-- Wisps
		wisp[15].x, wisp[15].y = map.tilesToPixels(16, 0)
		wisp[16].x, wisp[16].y = map.tilesToPixels(22, 0)
		wisp[17].x, wisp[17].y = map.tilesToPixels(16, 22)
		wisp[18].x, wisp[18].y = map.tilesToPixels(22, 22)
		wisp[19].x, wisp[19].y = map.tilesToPixels(0, 8)
		wisp[20].x, wisp[20].y = map.tilesToPixels(0, 14)	

		generate.gWisps(wisp, map, mapData, 1, 6)
		generate.gWater(water, map, mapData, 1, 1)
		generate.gWalls(wall, map, mapData, 1, 2)

	elseif mapData.pane == "U" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "D" then
		print("You shouldn't be in here...")
	elseif mapData.pane == "R" then
        --Green Aura
		objects["greenAura1"]:setSequence("move")
		objects["greenAura1"]:play()
		objects["greenAura1"].x, objects["greenAura1"].y = map.tilesToPixels(0, 0)

        --Red Aura
		objects["redAura1"]:setSequence("move")
		objects["redAura1"]:play()
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(1, 4)	

		objects["redAura2"]:setSequence("move")
		objects["redAura2"]:play()
		objects["redAura2"].x, objects["redAura2"].y = map.tilesToPixels(5, 1)	

		objects["redAura3"]:setSequence("move")
		objects["redAura3"]:play()
		objects["redAura3"].x, objects["redAura3"].y = map.tilesToPixels(9, 1)	

		objects["redAura4"]:setSequence("move")
		objects["redAura4"]:play()
		objects["redAura4"].x, objects["redAura4"].y = map.tilesToPixels(4, 6)	

		objects["redAura5"]:setSequence("move")
		objects["redAura5"]:play()
		objects["redAura5"].x, objects["redAura5"].y = map.tilesToPixels(7, 4)	

		objects["redAura6"]:setSequence("move")
		objects["redAura6"]:play()
		objects["redAura6"].x, objects["redAura6"].y = map.tilesToPixels(0, 22)	

		--Blue Aura
		objects["blueAura1"]:setSequence("move")
		objects["blueAura1"]:play()
		objects["blueAura1"].x, objects["blueAura1"].y = map.tilesToPixels(4, 3)	

		objects["blueAura2"]:setSequence("move")
		objects["blueAura2"]:play()
		objects["blueAura2"].x, objects["blueAura2"].y = map.tilesToPixels(7, 1)

		objects["blueAura3"]:setSequence("move")
		objects["blueAura3"]:play()
		objects["blueAura3"].x, objects["blueAura3"].y = map.tilesToPixels(6, 6)		

		objects["blueAura4"]:setSequence("move")
		objects["blueAura4"]:play()
		objects["blueAura4"].x, objects["blueAura4"].y = map.tilesToPixels(38, 22)	

        --FISH
        objects["fish11"].x, objects["fish11"].y = map.tilesToPixels(2,16)
        objects["fish11"].eX, objects["fish11"].eY = map.tilesToPixels(2,20)

        objects["fish12"].x, objects["fish12"].y = map.tilesToPixels(4,16)
        objects["fish12"].eX, objects["fish12"].eY = map.tilesToPixels(4,20)

        objects["fish13"].x, objects["fish13"].y = map.tilesToPixels(6,16)
        objects["fish13"].eX, objects["fish13"].eY = map.tilesToPixels(6,20)

        objects["fish14"].x, objects["fish14"].y = map.tilesToPixels(8,16)
        objects["fish14"].eX, objects["fish14"].eY = map.tilesToPixels(8,20)

        objects["fish15"].x, objects["fish15"].y = map.tilesToPixels(10,16)
        objects["fish15"].eX, objects["fish15"].eY = map.tilesToPixels(10,20)

        objects["fish16"].x, objects["fish16"].y = map.tilesToPixels(12,16)
        objects["fish16"].eX, objects["fish16"].eY = map.tilesToPixels(12,20)

		-- Pink rune
		rune[4].x, rune[4].y = map.tilesToPixels(21, 18)			
		rune[4].isVisible = true

		rune[3].x, rune[3].y = map.tilesToPixels(36, 21)			
		rune[3].isVisible = true
		
		-- Wisps
		wisp[9].x, wisp[9].y = map.tilesToPixels(15, 0)
		wisp[10].x, wisp[10].y = map.tilesToPixels(4, 2)
		wisp[11].x, wisp[11].y = map.tilesToPixels(4, 18)
		wisp[12].x, wisp[12].y = map.tilesToPixels(6, 18)
		wisp[13].x, wisp[13].y = map.tilesToPixels(8, 18)
		wisp[14].x, wisp[14].y = map.tilesToPixels(38, 16)	

		generate.gWisps(wisp, map, mapData, 1, 6)
		generate.gWater(water, map, mapData, 1, 1)
		generate.gWalls(wall, map, mapData, 1, 2)

	end

	-- generates all objects in pane when locations are set
	generate.gObjects(eight, objects, map, mapData.pane, rune)
	-- generate all moveable objects in pane when locations are set
	mObjects = generate.gMObjects(eight, objects, map, mapData.pane)
	-- destroy the unused objects
	generate.destroyObjects(eight, rune, wisp, water, wall, objects)

	-- set which panes are avaiable for player
	map.panes = eight.panes
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
eight.load = load
eight.destroyAll = destroyAll

return eight

-- end of eight.lua