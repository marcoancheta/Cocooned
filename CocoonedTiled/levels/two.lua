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
		["redTotem"] = 2,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 1
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
		["switchWall"] = 0,
		["exitPortal"] = 0
	},
	["U"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 1,
		["moveWall"] = 4,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 0,
		["switchWall"] = 0,
		["exitPortal"] = 0
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
		["switchWall"] = 0,
		["exitPortal"] = 0
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
		["switchWall"] = 0,
		["exitPortal"] = 0
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
			if name == "redTotem" then
				print(name)
				physics.addBody(objects[name ..j], "static", {bounce=0, radius=80})
				objects[name ..j].collType = "passThru"
			else
				physics.addBody(objects[name ..j], "static", {bounce = 0})
				objects[name ..j].collType = "passThru"
			end
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
	local startIndex, endIndex = 0, 0
	-- Check which pane
	if pane == "M" then
		local exitPortalSheet = graphics.newImageSheet( "mapdata/art/exitPortalSheet.png", spriteOptions.exitPortal )
		local exitPortal = display.newSprite(exitPortalSheet, spriteOptions.exitPortal)
		objects["exitPortal1"]:setSequence("still")
		objects["exitPortal1"].x, objects["exitPortal1"].y = map.tilesToPixels(4, 12.5)

		-- Red Totem
		objects["redTotem1"].x, objects["redTotem1"].y = map.tilesToPixels(8, 10)
		objects["redTotem2"].x, objects["redTotem2"].y = map.tilesToPixels(8, 15)
		
		energy[1].x, energy[1].y = map.tilesToPixels(19, 7)
		energy[2].x, energy[2].y = map.tilesToPixels(19, 17)
		energy[3].x, energy[3].y = map.tilesToPixels(14, 12)
		energy[4].x, energy[4].y = map.tilesToPixels(24, 12)
		
		startIndex = 1
		endIndex = 4
	elseif pane == "U" then
		-- Red Aura
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(29, 13)		
		-- Green Aura
		objects["greenAura1"].x, objects["greenAura1"].y = map.tilesToPixels(36, 22)

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
		
		energy[10].x, energy[10].y = map.tilesToPixels(7, 13)
		energy[11].x, energy[11].y = map.tilesToPixels(15.5, 13)
		energy[12].x, energy[12].y = map.tilesToPixels(18.5, 13)
		energy[13].x, energy[13].y = map.tilesToPixels(21.5, 13)
		energy[14].x, energy[14].y = map.tilesToPixels(24.5, 13)
		energy[15].x, energy[15].y = map.tilesToPixels(36, 14)
		energy[16].x, energy[16].y = map.tilesToPixels(36, 17)
		
		startIndex = 10
		endIndex = 16
		print("U")
	elseif pane == "D" then
		local num = 12
				
		-- Blue rune
		rune[1].x, rune[1].y = map.tilesToPixels(19, 21)			
		rune[1].isVisible = true
				
		energy[17].x, energy[17].y = map.tilesToPixels(15, 4)
		energy[18].x, energy[18].y = map.tilesToPixels(19, 4)
		energy[19].x, energy[19].y = map.tilesToPixels(23, 4)
		energy[20].x, energy[20].y = map.tilesToPixels(17.5, 7)
		energy[21].x, energy[21].y = map.tilesToPixels(21, 7)
		energy[22].x, energy[22].y = map.tilesToPixels(19, 14)
		
		startIndex = 17
		endIndex = 22
		print("D")
	elseif pane == "R" then
	
		-- Yellow rune
		rune[5].x, rune[5].y = map.tilesToPixels(15, 20)
		rune[5].isVisible = true
	
		energy[23].x, energy[23].y = map.tilesToPixels(8, 5.5)
		energy[24].x, energy[24].y = map.tilesToPixels(13, 5.5)
		energy[25].x, energy[25].y = map.tilesToPixels(18, 5.5)
		energy[26].x, energy[26].y = map.tilesToPixels(28.5, 12)
		energy[27].x, energy[27].y = map.tilesToPixels(8, 19)
		energy[28].x, energy[28].y = map.tilesToPixels(13, 19)
		energy[29].x, energy[29].y = map.tilesToPixels(18, 19)
		
		startIndex = 23
		endIndex = 29
		print("R")
	elseif pane == "L" then
		-- Switch Wall
		--objects["switchWall1"].x, objects["switchWall1"].y = map.tilesToPixels(32, 12.5)
		--objects["switchWall1"]:scale(0.5, 8)
	
		-- Green rune
		rune[5].x, rune[5].y = map.tilesToPixels(3.5, 3.5)
		rune[5].isVisible = true
		
		--energy[5].x, energy[5].y = map.tilesToPixels(8.5, 4)
		--energy[6].x, energy[6].y = map.tilesToPixels(11.5, 4)
		energy[7].x, energy[7].y = map.tilesToPixels(36, 17)
		energy[8].x, energy[8].y = map.tilesToPixels(36, 11)
		energy[9].x, energy[9].y = map.tilesToPixels(36, 14)
		
		startIndex = 7
		endIndex = 9		
		print("L")
	end
	
	generateObjects(objects, map, pane, runes)
	generateMoveableObjects(objects, map, pane, runes)
	generateEnergy(energy, map, startIndex, endIndex)
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