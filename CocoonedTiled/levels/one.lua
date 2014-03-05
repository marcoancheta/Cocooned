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
-- moveable object class that creates moveable objects (moveableObject.lua)
local moveableObject = require("moveableObject")

--------------------------------------------------------------------------------
-- Level One Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local one = { 
	-- boolean for which pane is being used
	--   { Middle, Down, Up, Right, Left }
	panes = {true,true,true,true,true},
	-- number of wisps in the level
	wispCount = 30,
	waterCount = 10,
	-- number of objects in each pane (M,D,U,R,L)
	-- if there is a certain object in that pane, set the quantity of that object here
	-- else leave it at 0
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["fish1"] = 0,
		["fish2"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 1,
		["exitPortal"] = 0,
		["enemy"] = 0,
	},
	["D"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
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

--------------------------------------------------------------------------------
-- geneate wisps functions
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function generateWisps(wisp, map, startIndex, endIndex)
	for i=startIndex, endIndex do

		-- set properties of wisps
		wisp[i].speed = 50
	   	wisp[i].isVisible = true
	   	wisp[i].func = "energyCollision"
	   	wisp[i].collectable = true
	   	wisp[i].name = "wisp" .. i

	   	-- insert wisp into map display group
		map.layer["tiles"]:insert(wisp[i])

		-- add physics body for wisp for collision
		physics.addBody(wisp[i], "static", {bounce=0})

	end
end

--------------------------------------------------------------------------------
-- geneate water functions
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function generateWater(water, map, startIndex, endIndex)
	for i=startIndex, endIndex do

	   	-- insertwater into map display group
		map.layer["water"]:insert(water[i])

		-- add physics body for wisp for collision
		physics.addBody(water[i], "static", {bounce=0})
		
		-- set properties of wisps
	   	water[i].isVisible = true
	    water[i].func = "waterCollision"
	   	water[i].collType = "passThru"
		water[i].escape = "downRight"
	    water[i].name = "water"

	end
end

--------------------------------------------------------------------------------
-- generate objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- finalizing objects in pane
local function generateObjects(objects, map, pane, runes)
	-- goes down object list and sets all their properties
	for i = 1, #objectNames do

		-- save name of object
		local name = objectNames[i]

		-- go down list and set properties
		for j = 1, one[pane][name] do

			-- add object to map display group
			map.layer["tiles"]:insert(objects[name .. j])

			-- set properties and add to physics group
			objects[name .. j].func = name .. "Collision"
			physics.addBody(objects[name ..j], "static", {bounce = 0})
			objects[name ..j].collType = "passThru"
		end
	end

	-- goes down rune list and adds runes that are visible in pane
	for i = 1, #rune do

		-- check if rune is visible and if so, add to map display group
		if rune[i].isVisible == true then
			map.layer["tiles"]:insert(rune[i])
		end
	end
end

-- variable that holds all movable objects for later use
local mObjects = {}

--------------------------------------------------------------------------------
-- generate moveable objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- goes down object list and starts moving objects that are set to move
local function generateMoveableObjects(objects, map, pane)

	-- clear mObjects is not already cleared
	mObjects = {}

	-- create moveable fish1 objects
	for i = 1, one[pane]["fish1"] do

		-- create moveable object and set name
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["fish1" .. i]

		-- set start and end points where moveable object will transition to
		local startX, startY = objects["fish1" .. i].x, objects["fish1" .. i].y
		local endX, endY = objects["fish1" .. i].eX, objects["fish1" .. i].eY
		local time = objects["fish1" .. i].time

		-- set properties of moveable object
		mObjects[i].object.startX, mObjects[i].object.startY = startX, startY
		mObjects[i].object.endX, mObjects[i].object.endY = endX, endY
		mObjects[i].object.time = time
		mObjects[i].object.moveable = true

		-- start moving object
		mObjects[i]:startTransition(mObjects[i].object)
	end

	-- set offset for next moveable object
	local offset = one[pane]["fish1"]

	-- create moveable fish2 obects
	for i = 1+offset, one[pane]["fish2"]+offset do

		-- create moveable object and set name
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["fish2" .. i-offset]

		-- set start and end points where moveable object will transition to
		local startX, startY = objects["fish2" .. i-offset].x, objects["fish2" .. i-offset].y
		local endX, endY = objects["fish2" .. i-offset].eX, objects["fish2" .. i-offset].eY
		local time = objects["fish2" .. i-offset].time

		-- set properties of moveable object
		mObjects[i].object.startX, mObjects[i].object.startY = startX, startY
		mObjects[i].object.endX, mObjects[i].object.endY = endX, endY
		mObjects[i].object.time = time
		mObjects[i].object.moveable = true

		-- start moving object
		mObjects[i]:startTransition(mObjects[i].object)
	end
end

--------------------------------------------------------------------------------
-- destroy unused objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- call this function after setting all objects in pane so it will destroy unused object
-- to decrease memory usage
local function destroyObjects(rune, wisp, water, objects) 

	-- deleted extra runes
	for i = 1, #rune do
		if rune[i].isVisible == false then
			rune[i]:removeSelf()
			rune[i] = nil
		end
	end

	-- deleted extra wisps
	for i = 1, one.wispCount do
		--print("energyCount:", i)
		if wisp[i].isVisible == false then
			wisp[i]:removeSelf()
			wisp[i] = nil
		end
	end
	
	-- deleted extra waters
	for i = 1, one.waterCount do
		--print("energyCount:", i)
		if water[i].isVisible == false then
			water[i]:removeSelf()
			water[i] = nil
		end
	end
end

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
		objects["switchWall1"].x, objects["switchWall1"].y = map.tilesToPixels(12, 8)
		
		water[1].x, water[1].y = map.tilesToPixels(20, 22)
		water[2].x, water[2].y = map.tilesToPixels(20, 3)
		
		water[2]:scale(1, -1)
		generateWater(water, map, 1, 2)
		generateObjects(objects, map, pane, rune)
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
		
		generateWisps(wisp, map, 10, 16)
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

		generateWisps(wisp, map, 17, 22)
	elseif pane == "R" then
		-- Green rune
		rune[4].x, rune[4].y = map.tilesToPixels(3.5, 3.5)
		rune[4].isVisible = true
		
		wisp[5].x, wisp[5].y = map.tilesToPixels(8.5, 4)
		wisp[6].x, wisp[6].y = map.tilesToPixels(11.5, 4)
		wisp[7].x, wisp[7].y = map.tilesToPixels(36, 17)
		wisp[8].x, wisp[8].y = map.tilesToPixels(36, 11)
		wisp[9].x, wisp[9].y = map.tilesToPixels(36, 14)

		generateWisps(wisp, map, 5, 9)
	elseif pane == "L" then
		wisp[23].x, wisp[23].y = map.tilesToPixels(8, 5.5)
		wisp[24].x, wisp[24].y = map.tilesToPixels(13, 5.5)
		wisp[25].x, wisp[25].y = map.tilesToPixels(18, 5.5)
		wisp[26].x, wisp[26].y = map.tilesToPixels(28.5, 12)
		wisp[27].x, wisp[27].y = map.tilesToPixels(8, 19)
		wisp[28].x, wisp[28].y = map.tilesToPixels(13, 19)
		wisp[29].x, wisp[29].y = map.tilesToPixels(18, 19)

		generateWisps(wisp, map, 23, 29)
	end

	-- generates all objects in pane when locations are set
	generateObjects(objects, map, pane, rune)
	-- generate all moveable objects in pane when locations are set
	generateMoveableObjects(objects, map, pane)
	-- destroy the unused objects
	destroyObjects(rune, wisp, water, objects)

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

	-- destroy all moveable objects and stop moving them
	for i=1, #mObjects do
		mObjects[i]:endTransition()
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