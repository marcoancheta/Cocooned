--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- generateObjects.lua
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- moveable object class that creates moveable objects (moveableObject.lua)
local moveableObject = require("moveableObject")
-- wind emmiter object class (windEmitter.lua)
local windEmitterMechanic = require("windEmitter")
--------------------------------------------------------------------------------
-- generate wisps functions
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function gWisps(wisp, map, mapData, startIndex, endIndex)
	
	for i=startIndex, endIndex do
		-- set properties of wisps
		wisp[i].speed = 50
	   	wisp[i].isVisible = true
	   	wisp[i].func = "energyCollision"
	   	wisp[i].collectable = true
	   	wisp[i].name = "wisp" .. i

	   	-- insert wisp into map display group
		if mapData.levelNum ~= "LS" then
			map:insert(wisp[i])
		else
			map.layer["tiles"]:insert(wisp[i])
		end

		-- add physics body for wisp for collision
		physics.addBody(wisp[i], "static", {bounce=0})

	end
end

--------------------------------------------------------------------------------
-- generate objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- finalizing objects in pane
local function gObjects(level, objects, map, mapData, runes)
	-- goes down object list and sets all their properties
	for i = 1, #objectNames do
		-- save name of object
		local name = objectNames[i]
		
		-- go down list and set properties
		for j = 1, level[mapData.pane][name] do
			-- set properties and add to physics group
			if mapData.levelNum == "LS" then
				objects[name .. j].func = "levelPortalCollision"
				physics.addBody(objects[name ..j], "static", {bounce = 0})
				objects[name ..j].collType = "passThru"
			else
				objects[name .. j].func = name .. "Collision"
				physics.addBody(objects[name ..j], "static", {bounce = 0})
				objects[name ..j].collType = "passThru"
			end
			
			-- add object to map display group

			if mapData.levelNum ~= "LS" then
				map:insert(objects[name .. j])				
			else
				map.layer["tiles"]:insert(objects[name .. j])
			end
		end
	end

	-- goes down rune list and adds runes that are visible in pane
	for i = 1, #runes do
		-- check if rune is visible and if so, add to map display group
		if runes[i].isVisible == true then
			if mapData.levelNum ~= "LS" then
				map:insert(runes[i])
			else
				map.layer["tiles"]:insert(runes[i])
			end
		end
	end
end

--------------------------------------------------------------------------------
-- generate moveable objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- goes down object list and starts moving objects that are set to move
local function gMObjects(level, objects, map, mapData)
	-- clear mObjects is not already cleared
	local mObjects = {}
	
	-- create moveable fish1 objects
	for i = 1, level[mapData.pane]["fish1"] do
		-- create moveable object and set name
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["fish1" .. i]
		mObjects[i].moveable = true

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
	local offset = 0
	if level[mapData.pane]["fish1"] > 0 then
		offset = level[mapData.pane]["fish1"]
	end

	-- create moveable fish2 obects
	for i = 1+offset, level[mapData.pane]["fish2"]+offset do
		-- create moveable object and set name
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["fish2" .. i-offset]
		mObjects[i].moveable = true

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

	if level[mapData.pane]["fish2"] > 0 then
		offset = offset + level[mapData.pane]["wolf"]
	end

	-- creates wind emmitter
	local duration = 1200 --800
	local startAlpha = 1
	local endAlpha = 0
	local pImage = nil
	local pImageWidth = nil
	local pImageHeight = nil
	local emitterDensity = 10
	local windSpeed = 500
	local windEmitterDensity = 0
	local windRadiusRange = 1000
	local windThickness = 10

	for i = 1+offset, level[mapData.pane]["wolf"]+offset do
		local windEmitter = windEmitterLib:createEmitter(windRadiusRange, windThickness, duration, startAlpha, endAlpha, pImage, pImageWidth, pImageHeight)
		local windDisplayGroup = display.newGroup()
		local emitWind = { count = 1 }
		function emitWind:timer(event)
    		if (self.count == 1) then
    			windEmitter:emit(windDisplayGroup, objects["wolf" .. i-offset].x , objects["wolf" .. i-offset].y+30, 
    				objects["wolf" .. i-offset].direction, objects["wolf" .. i-offset].distance)
    			self.count = -1
 				timer.performWithDelay(100, emitWind, windEmitterDensity)
    		elseif(self.count == -1) then
    			windEmitter:emit(windDisplayGroup, objects["wolf" .. i-offset].x , objects["wolf" .. i-offset].y+30, 
    				objects["wolf" .. i-offset].direction, objects["wolf" .. i-offset].distance)
    		elseif (self.count == 0) then
    			timer.cancel(event.source)
    			timer.performWithDelay(2000, function() windDisplayGroup:removeSelf() end)
    		end
		end
		timer.performWithDelay(windSpeed, emitWind)
		mObjects[i] = emitWind
		mObjects[i].moveable = false
	end
	-- return object table
	return mObjects

end

--------------------------------------------------------------------------------
-- Generate water functions
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function gWater(water, map, mapData, startIndex, endIndex)
	local physicsData = {}
	
	for i=startIndex, endIndex do
		-- insert water into map display group
		if mapData.levelNum ~= "2" then
			map.layer["tiles"]:insert(water[i])
		else
			map:insert(water[i])
		end
		-- set properties of water
		water[i].isVisible = true
		water[i].alpha = 0;
		water[i].func = "waterCollision"
		water[i].collType = "passThru"
		water[i].escape = "topRight"
		water[i].name = "water"
	end
	
	-- add physics body for water for collision
	if mapData.levelNum == "2" then
		-- load in physics data.
		physicsData[1] = (require "levels.two_collision.walls").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "M" then
			physics.addBody(water[1], "static", physicsData[1]:get("2-1-WATER2") )	
		elseif mapData.pane == "L" then
			physics.addBody(water[1], "static", physicsData[1]:get("2-2-WATER2") )	
		end
	elseif mapData.levelNum == "4" then
		-- load in physics data.
		physicsData[1] = (require "levels.four_collision.walls").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "M" then
			physics.addBody(water[1], "static", physicsData[1]:get("4-1WATER1") )
			physics.addBody(water[2], "static", physicsData[1]:get("4-1WATER2") )
		elseif mapData.pane == "R" then
			physics.addBody(water[1], "static", physicsData[1]:get("4-2WATER1") )
			physics.addBody(water[2], "static", physicsData[1]:get("4-2WATER2") )
		end
	end
end

--------------------------------------------------------------------------------
-- Generate walls functions
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function gWalls(wall, map, mapData, startIndex, endIndex)
	local physicsData = {}
	
	for i=startIndex, endIndex do
	   	-- insertwater into map display group
	   	if mapData.levelNum ~= "LS" then
	   		map:insert(wall[i])
		else			
			map.layer["tiles"]:insert(wall[i])
		end
		-- set properties of wisps
	   	wall[i].isVisible = true
	   	wall[i].alpha = 0
	   	wall[i].collType = "wall"
	    wall[i].name = "wall"
	    print("inserted walls")
	end
	
	-- add physics body for wall for collision
	if mapData.levelNum == "LS" then
		-- load in physics data.
		physicsData[1] = (require "levels.lvlselect_collision.walls").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "LS" then
			physics.addBody(wall[1], "static", physicsData[1]:get("lvl_island"))
		end
	elseif mapData.levelNum == "1" then
		-- load in physics data.
		physicsData[1] = (require "levels.one_collision.walls").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "M" then
			physics.addBody(wall[1], "static", physicsData[1]:get("1-1_BB") )
		end
	elseif mapData.levelNum == "2" then
		-- load in physics data.
		physicsData[1] = (require "levels.two_collision.walls").physicsData(1.0)
		physicsData[2] = (require "levels.storyborder_collision.border").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "M" then
			physics.addBody(wall[1], "static", physicsData[1]:get("2-1-WALL4") )
			--physics.addBody(wall[2], "static", physicsData[2]:get("border2") )
		elseif mapData.pane == "L" then
			physics.addBody(wall[1], "static", physicsData[1]:get("2-2-WALL4") )
			--physics.addBody(wall[2], "static", physicsData[2]:get("border2") )
		end

		--wall[2]:setFillColor(0, 0, 0, 1)
	elseif mapData.levelNum == "4" then
		-- load in physics data.
		physicsData[1] = (require "levels.four_collision.walls").physicsData(1.0)
		-- assign physics according to pane.
		if mapData.pane == "M" then
			physics.addBody(wall[1], "static", physicsData[1]:get("4-1WALL") )
		elseif mapData.pane == "R" then
			physics.addBody(wall[1], "static", physicsData[1]:get("4-2WALL") )
		end
	end
end

--------------------------------------------------------------------------------
-- Generate walls functions
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- takes in a start and end index and creates those wisps only
local function gAuraWalls(auraWall, map, mapData, startIndex, endIndex)
	local physicsData = { }
		
	for i=startIndex, endIndex do
	   	-- insertwater into map display group
	   	if mapData.levelNum ~= "LS" then
	   		map:insert(auraWall[i])
	   	else
	   		map.layer["tiles"]:insert(auraWall[i])
	   	end
		
		-- set properties of wisps
	   	auraWall[i].isVisible = true
	   	auraWall[i].alpha = 0
	   	auraWall[i].collType = "passThru"
		auraWall[i].func = "blueWallCollision"
	    auraWall[i].name = "blueWall"
	end
	
	-- add physics body for wisp for collision
	if mapData.levelNum == "1" then
		physicsData[1] = (require "levels.one_collision.blueWall").physicsData(1.0)
		physics.addBody(auraWall[1], "static", physicsData[1]:get("blueAuraWall") )
	end
end

--------------------------------------------------------------------------------
-- destroy unused objects function
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- call this function after setting all objects in pane so it will destroy unused object
-- to decrease memory usage
local function destroyObjects(level, rune, wisp, water, objects) 
	-- deleted extra runes
	for i = 1, #rune do
		if rune[i].isVisible == false then
			rune[i]:removeSelf()
			rune[i] = nil
		end
	end

	-- deleted extra energies
	for i = 1, level.wispCount do
		--print("energyCount:", i)
		if wisp[i].isVisible == false then
			wisp[i]:removeSelf()
			wisp[i] = nil
		end
	end
	
	-- deleted extra water
	for i = 1, level.waterCount do
		--print("energyCount:", i)
		if water[i].isVisible == false then
			water[i]:removeSelf()
			water[i] = nil
		end
	end
	
	-- deleted extra walls
	for i = 1, level.wallCount do
		--print("energyCount:", i)
		if wall[i].isVisible == false then
			wall[i]:removeSelf()
			wall[i] = nil
		end
	end
	
	-- deleted extra walls
	for i = 1, level.auraWallCount do
		--print("energyCount:", i)
		if auraWall[i].isVisible == false then
			auraWall[i]:removeSelf()
			auraWall[i] = nil
		end
	end
end

local function tilesToPixels( Tx, Ty)

	local x, y = Tx, Ty
	--tprint.assert((x ~= nil) and (y ~= nil), "Missing argument(s).")
	x, y = x - 0.5, y - 0.5
	print("generating tiles to pixels")
	x, y = (x * 36), (y * 36)

	return x, y
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
generateObjects = {
	gObjects = gObjects,
	gWisps = gWisps,
	gMObjects = gMObjects,
	gWater = gWater,
	gWalls = gWalls,
	gAuraWalls = gAuraWalls,
	destroyObjects = destroyObjects,
	tilesToPixels = tilesToPixels
}

return generateObjects

-- end of generateObjects.lua