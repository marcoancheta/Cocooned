--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- one.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
local moveableObject = require("moveableObject")


local one = { 
	energyCount = 30,
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 1,
		["moveWall"] = 4,
		["blueTotem"] = 0,
		["redTotem"] = 2,
		["greenTotem"] = 2,
		["switch"] = 0,
		["switchWall"] = 0
	},
	["D"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 10,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 1,
		["switchWall"] = 5
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 6,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 1,
		["switchWall"] = 5
	},
	["R"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 10,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
	},	
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 1,
		["switchWall"] = 13
	}
}

local objectList

local function generateEnergy(energy, map, startIndex, endIndex)
	for i=startIndex, endIndex do
		--print("Create energy at: ", energy[i].name)
		energy[i].speed = 50
	   	energy[i].isVisible = true
	   	energy[i].func = "energyCollision"
	   	energy[i].collectable = true
	   	energy[i].name = "energy" .. i
		map.layer["tiles"]:insert(energy[i])
		energy[i]:setSequence("move")
		energy[i]:play()
		physics.addBody(energy[i], "static", {bounce=0})
	end
end

local function generateObjects(objects, map, pane, runes)
	for i = 1, #objectNames do
		local name = objectNames[i]
		for j = 1, one[pane][name] do
			map.layer["tiles"]:insert(objects[name .. j])
			objects[name .. j].func = name .. "Collision"
			physics.addBody(objects[name ..j], "static", {bounce = 0})
			objects[name ..j].collType = "passThru"
		end
	end

	for i = 1, #rune do
		if rune[i].isVisible == true then
			map.layer["tiles"]:insert(rune[i])
		end
	end
end

local mObjects = {}

local function generateMoveableObjects(objects, map, pane)
	mObjects = {}
	for i = 1, one[pane]["moveWall"] do
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["moveWall" .. i]

		local startX, startY = objects["moveWall" .. i].x, objects["moveWall" .. i].y
		--print("startX:", startX)
		local endX, endY = objects["moveWall" .. i].eX, objects["moveWall" .. i].eY
		local time = objects["moveWall" .. i].time

		mObjects[i].object.startX, mObjects[i].object.startY = startX, startY
		mObjects[i].object.endX, mObjects[i].object.endY = endX, endY
		mObjects[i].object.time = time
		mObjects[i]:startTransition(mObjects[i].object)
	end
	

end

local function destroyObjects(rune, energy, objects) 

	-- deleted extra runes
	for i = 1, #rune do
		if rune[i].isVisible == false then
			rune[i]:removeSelf()
			rune[i] = nil
		end
	end

	-- deleted extra energies
	for i = 1, one.energyCount do
		--print("energyCount:", i)
		if energy[i].isVisible == false then
			energy[i]:removeSelf()
			energy[i] = nil
		end
	end

end

local function load(pane, map, rune, objects, energy)
	objectList = objects
	
	-- Check which pane
	if pane == "M" then
		-- Assign rune coordinates and set visibility to true
		rune[1].x, rune[1].y = map.tilesToPixels(3.5 , 3.5)	
		rune[1].isVisible = true
		rune[2].x, rune[2].y = map.tilesToPixels(37.5, 3.5)	
		rune[2].isVisible = true
		rune[3].x, rune[3].y = map.tilesToPixels(3.5, 21.5)	
		rune[3].isVisible = true	
		rune[4].x, rune[4].y = map.tilesToPixels(37.5, 21.5)	
		rune[4].isVisible = true

		objects["moveWall1"].x, objects["moveWall1"].y  = map.tilesToPixels(7.5, 6)
		objects["moveWall1"].eX, objects["moveWall1"].eY = map.tilesToPixels(7.5, 18.5)
		objects["moveWall1"].time = 500


		objects["moveWall2"].x, objects["moveWall2"].y  = map.tilesToPixels(8, 6)
		objects["moveWall2"].eX, objects["moveWall2"].eY = map.tilesToPixels(8, 18.5)
		objects["moveWall2"].time = 500

		objects["moveWall3"].x, objects["moveWall3"].y  = map.tilesToPixels(32.5, 18.5)
		objects["moveWall3"].eX, objects["moveWall3"].eY = map.tilesToPixels(32.5, 6)
		objects["moveWall3"].time = 500


		objects["moveWall4"].x, objects["moveWall4"].y  = map.tilesToPixels(33, 18.5)
		objects["moveWall4"].eX, objects["moveWall4"].eY = map.tilesToPixels(33, 6)
		objects["moveWall4"].time = 500

		objects["greenAura1"].x, objects["greenAura1"].y = map.tilesToPixels(4, 12.5)
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(36.5, 12.5)

		objects["greenTotem1"].x, objects["greenTotem1"].y = map.tilesToPixels(18, 6.5)
		objects["greenTotem2"].x, objects["greenTotem2"].y = map.tilesToPixels(23, 6.5)

		objects["redTotem1"].x, objects["redTotem1"].y = map.tilesToPixels(18, 18.5)
		objects["redTotem2"].x, objects["redTotem2"].y = map.tilesToPixels(23, 18.5)

		energy[1].x, energy[1].y = map.tilesToPixels(4, 9.5)
		energy[2].x, energy[2].y = map.tilesToPixels(4, 16.5)
		energy[3].x, energy[3].y = map.tilesToPixels(36.5, 9.5)
		energy[4].x, energy[4].y = map.tilesToPixels(36.5, 16.5)

		for i = 1, 5 do
			energy[i+4].x, energy[i+4].y = map.tilesToPixels( 11 + i*3.5, 3.5)
		end
		for i = 1, 5 do
			energy[i+9].x, energy[i+9].y = map.tilesToPixels( 11 + i*3.5, 21.5)
		end
		-- finalize by adding objects to map
		generateEnergy(energy, map, 1, 14)
		generateObjects(objects, map, pane, rune)
		generateMoveableObjects(objects, map, pane)
	
	elseif pane == "U" then
		print("inside pane U")
		print(#objects)
		-- Assign rune coordinates
		objects["switch1"].x, objects["switch1"].y = map.tilesToPixels(19.5, 3.5)

		objects["moveWall1"].x, objects["moveWall1"].y  = map.tilesToPixels(15.5, 3.5)
		objects["moveWall1"].eX, objects["moveWall1"].eY = map.tilesToPixels(15.5, 6)
		objects["moveWall1"].time = 600


		objects["moveWall2"].x, objects["moveWall2"].y  = map.tilesToPixels(16, 3.5)
		objects["moveWall2"].eX, objects["moveWall2"].eY = map.tilesToPixels(16, 6)
		objects["moveWall2"].time = 600

		objects["moveWall3"].x, objects["moveWall3"].y  = map.tilesToPixels(23, 3.5)
		objects["moveWall3"].eX, objects["moveWall3"].eY = map.tilesToPixels(23, 6)
		objects["moveWall3"].time = 600


		objects["moveWall4"].x, objects["moveWall4"].y  = map.tilesToPixels(23.5, 3.5)
		objects["moveWall4"].eX, objects["moveWall4"].eY = map.tilesToPixels(23.5, 6)
		objects["moveWall4"].time = 600

		objects["moveWall5"].x, objects["moveWall5"].y  = map.tilesToPixels(15.5, 7)
		objects["moveWall5"].eX, objects["moveWall5"].eY = map.tilesToPixels(23.5, 7)
		objects["moveWall5"].time = 600


		objects["moveWall6"].x, objects["moveWall6"].y  = map.tilesToPixels(15.5, 8)
		objects["moveWall6"].eX, objects["moveWall6"].eY = map.tilesToPixels(23.5, 8)
		objects["moveWall6"].time = 600

		for i = 1, 5 do
			objects["switchWall" .. i].x, objects["switchWall" .. i].y = map.tilesToPixels(35, 1 + i*1)
		end
		

		generateObjects(objects, map, pane, rune)
		generateMoveableObjects(objects, map, pane)	
	
	elseif pane == "D" then
		objects["switch1"].x, objects["switch1"].y = map.tilesToPixels(37.5, 12.5)

		objects["moveWall1"].x, objects["moveWall1"].y  = map.tilesToPixels(2, 7.5)
		objects["moveWall1"].eX, objects["moveWall1"].eY = map.tilesToPixels(6, 7.5)
		objects["moveWall1"].time = 600


		objects["moveWall2"].x, objects["moveWall2"].y  = map.tilesToPixels(2, 8.5)
		objects["moveWall2"].eX, objects["moveWall2"].eY = map.tilesToPixels(6, 8.5)
		objects["moveWall2"].time = 600

		objects["moveWall3"].x, objects["moveWall3"].y  = map.tilesToPixels(2, 16)
		objects["moveWall3"].eX, objects["moveWall3"].eY = map.tilesToPixels(6, 16)
		objects["moveWall3"].time = 600


		objects["moveWall4"].x, objects["moveWall4"].y  = map.tilesToPixels(2, 17)
		objects["moveWall4"].eX, objects["moveWall4"].eY = map.tilesToPixels(6, 17)
		objects["moveWall4"].time = 600

		objects["moveWall5"].x, objects["moveWall5"].y  = map.tilesToPixels(31.5, 7)
		objects["moveWall5"].eX, objects["moveWall5"].eY = map.tilesToPixels(31.5, 2)
		objects["moveWall5"].time = 600


		objects["moveWall6"].x, objects["moveWall6"].y  = map.tilesToPixels(31, 7)
		objects["moveWall6"].eX, objects["moveWall6"].eY = map.tilesToPixels(31, 2)
		objects["moveWall6"].time = 600

		objects["moveWall7"].x, objects["moveWall7"].y  = map.tilesToPixels(31.5, 17)
		objects["moveWall7"].eX, objects["moveWall7"].eY = map.tilesToPixels(31.5, 7)
		objects["moveWall7"].time = 600

		objects["moveWall8"].x, objects["moveWall8"].y  = map.tilesToPixels(31, 17)
		objects["moveWall8"].eX, objects["moveWall8"].eY = map.tilesToPixels(31, 7)
		objects["moveWall8"].time = 600


		objects["moveWall9"].x, objects["moveWall9"].y  = map.tilesToPixels(31.5, 22)
		objects["moveWall9"].eX, objects["moveWall9"].eY = map.tilesToPixels(31.5, 17)
		objects["moveWall9"].time = 600

		objects["moveWall10"].x, objects["moveWall10"].y  = map.tilesToPixels(31, 22)
		objects["moveWall10"].eX, objects["moveWall10"].eY = map.tilesToPixels(31, 17)
		objects["moveWall10"].time = 600

		for i = 1, 5 do
			objects["switchWall" .. i].x, objects["switchWall" .. i].y = map.tilesToPixels(0.75 + i*1, 6)
		end

		generateObjects(objects, map, pane, rune)
		generateMoveableObjects(objects, map, pane)	
	elseif pane == "R" then

		objects["moveWall1"].x, objects["moveWall1"].y  = map.tilesToPixels(39, 17)
		objects["moveWall1"].eX, objects["moveWall1"].eY = map.tilesToPixels(32.5, 17)
		objects["moveWall1"].time = 600


		objects["moveWall2"].x, objects["moveWall2"].y  = map.tilesToPixels(39, 18)
		objects["moveWall2"].eX, objects["moveWall2"].eY = map.tilesToPixels(32.5, 18)
		objects["moveWall2"].time = 600

		objects["moveWall3"].x, objects["moveWall3"].y  = map.tilesToPixels(31.5, 23)
		objects["moveWall3"].eX, objects["moveWall3"].eY = map.tilesToPixels(31.5, 16.5)
		objects["moveWall3"].time = 600


		objects["moveWall4"].x, objects["moveWall4"].y  = map.tilesToPixels(31, 23)
		objects["moveWall4"].eX, objects["moveWall4"].eY = map.tilesToPixels(31, 16.5)
		objects["moveWall4"].time = 600

		objects["moveWall5"].x, objects["moveWall5"].y  = map.tilesToPixels(9, 6)
		objects["moveWall5"].eX, objects["moveWall5"].eY = map.tilesToPixels(9, 12)
		objects["moveWall5"].time = 600

		objects["moveWall6"].x, objects["moveWall6"].y  = map.tilesToPixels(9.5, 6)
		objects["moveWall6"].eX, objects["moveWall6"].eY = map.tilesToPixels(9.5, 12)
		objects["moveWall6"].time = 600

		objects["moveWall7"].x, objects["moveWall7"].y  = map.tilesToPixels(7, 17)
		objects["moveWall7"].eX, objects["moveWall7"].eY = map.tilesToPixels(7, 7)
		objects["moveWall7"].time = 600

		objects["moveWall8"].x, objects["moveWall8"].y  = map.tilesToPixels(7.5, 17)
		objects["moveWall8"].eX, objects["moveWall8"].eY = map.tilesToPixels(7.5, 7)
		objects["moveWall8"].time = 600


		objects["moveWall9"].x, objects["moveWall9"].y  = map.tilesToPixels(9, 12)
		objects["moveWall9"].eX, objects["moveWall9"].eY = map.tilesToPixels(9, 18)
		objects["moveWall9"].time = 600

		objects["moveWall10"].x, objects["moveWall10"].y  = map.tilesToPixels(9.5, 12)
		objects["moveWall10"].eX, objects["moveWall10"].eY = map.tilesToPixels(9.5, 18)
		objects["moveWall10"].time = 600

		generateObjects(objects, map, pane, rune)
		generateMoveableObjects(objects, map, pane)

	elseif pane == "L" then
		objects["switch1"].x, objects["switch1"].y = map.tilesToPixels(18, 12)
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(3.5, 12)

		for i = 1, 4 do
			objects["switchWall" .. i].x, objects["switchWall" .. i].y = map.tilesToPixels(16, 9.5 + 1*i)
		end

		for i = 5, 8 do
			objects["switchWall" .. i].x, objects["switchWall" .. i].y = map.tilesToPixels(12.5, 9.5 + 1*i-4)
		end

		for i = 9, 13 do
			objects["switchWall" .. i].x, objects["switchWall" .. i].y = map.tilesToPixels(6, 18 + 1*(i-8))
		end


		generateObjects(objects, map, pane, rune)
	end

	destroyObjects(rune, energy, objects)
end

local function destroyAll() 

	for i=1, #energy do
		display.remove(energy[i])
		energy[i] = nil
	end
	for i=1, #mObjects do
		mObjects[i]:endTransition()
	end
end

one.load = load
one.destroyAll = destroyAll

return one