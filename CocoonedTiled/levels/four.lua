--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- four.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
local moveableObject = require("moveableObject")

local four = { 
	energyCount = 30,
	breakWallCount = 30,
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 1,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
	},
	["D"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 0,
		["moveWall"] = 4,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
	},
	["R"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
	},	
	["L"] = {
		["blueAura"] = 0,
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0
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
		print("generating:", four[pane][name])
		for j = 1, four[pane][name] do
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
	for i = 1, four[pane]["moveWall"] do
		mObjects[i] = moveableObject.create()
		mObjects[i].object = objects["moveWall" .. i]

		local startX, startY = objects["moveWall" .. i].x, objects["moveWall" .. i].y
		--print("startX:", startX)
		local endX, endY = objects["moveWall" .. i].eX, objects["moveWall" .. i].eY
		local time = objects["moveWall" .. i].time

		mObjects[i].object.startX, mObjects[i].object.startY = startX, startY
		mObjects[i].object.endX, mObjects[i].object.endY = endX, endY
		mObjects[i].object.time = time
		mObjects[i].object.moveable = true
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
	for i = 1, four.energyCount do
		--print("energyCount:", i)
		if energy[i].isVisible == false then
			energy[i]:removeSelf()
			energy[i] = nil
		end
	end
end

local function load(pane, map, rune, objects, energy, player)
	objectList = objects
	
	-- Check which pane
	if pane == "M" then
		--local redAuraSheet = graphics.newImageSheet( "mapdata/art/redAuraSheet.png", spriteOptions.redAura )
		--local redAura = display.newSprite(redAuraSheet, spriteOptions.redAura)
		--objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(13, 11)
		--rune[1].x, rune[1].y = map.tilesToPixels(15, 15)
		--rune[1].isVisible = true
		
		-- Red Totem
		objects["redTotem1"].x, objects["redTotem1"].y = map.tilesToPixels(13, 11)
	elseif pane == "U" then
		-- Red Aura
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(29, 13)
	
		-- Swimming fishes
		objects["moveWall1"].x, objects["moveWall1"].y = map.tilesToPixels(12, 8)
		objects["moveWall1"].eX, objects["moveWall1"].eY = map.tilesToPixels(12, 19)
		objects["moveWall2"].eX, objects["moveWall2"].eY = map.tilesToPixels(16, 8)
		objects["moveWall2"].x, objects["moveWall2"].y = map.tilesToPixels(16, 19)
		objects["moveWall3"].x, objects["moveWall3"].y = map.tilesToPixels(20, 8)
		objects["moveWall3"].eX, objects["moveWall3"].eY = map.tilesToPixels(20, 19)
		objects["moveWall4"].eX, objects["moveWall4"].eY = map.tilesToPixels(24, 8)
		objects["moveWall4"].x, objects["moveWall4"].y = map.tilesToPixels(24, 19)
		
		objects["moveWall1"].time = 375
		objects["moveWall2"].time = 375
		objects["moveWall3"].time = 375
		objects["moveWall4"].time = 375
		
		-- Pink rune	
		rune[3].x, rune[3].y = map.tilesToPixels(3.5, 13)
		rune[3].isVisible = true
		
		print("U")
	elseif pane == "D" then
		local num = 12
		
		-- Blue rune
		rune[1].x, rune[1].y = map.tilesToPixels(19.5, 12)			
		rune[1].isVisible = true
				
		print("D")
	elseif pane == "R" then
		-- Green rune
		rune[2].x, rune[2].y = map.tilesToPixels(3.5, 5)
		rune[2].isVisible = true
					
		print("R")
	elseif pane == "L" then
		print("L")
	end
	
	generateObjects(objects, map, pane, runes)
	generateMoveableObjects(objects, map, pane, runes)
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

four.load = load
four.destroyAll = destroyAll
four.takeWallsDown = takeWallsDown

return four