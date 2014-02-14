--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- fifteen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")


local fifteen = { 
	energyCount = 30,
	["M"] = {
		["blueAura"] = 0,
		["redAura"] = 1,
		["greenAura"] = 0,
		["moveWall"] = 0,
		["blueTotem"] = 0,
		["redTotem"] = 0,
		["greenTotem"] = 0,
		["switch"] = 1,
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
		["redAura"] = 0,
		["greenAura"] = 0,
		["moveWall"] = 0,
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
		for j = 1, fifteen[pane][name] do
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

local function destroyObjects(rune, energy, objectList) 

	-- deleted extra runes
	for i = 1, #rune do
		if rune[i].isVisible == false then
			rune[i]:removeSelf()
			rune[i] = nil
		end
	end

	-- deleted extra energies
	for i = 1, fifteen.energyCount do
		print("energyCount:", i)
		if energy[i].isVisible == false then
			energy[i]:removeSelf()
			energy[i] = nil
		end
	end

end

local function load(pane, map, rune, objects, energy)
	
	-- Check which pane
	if pane == "M" then
		print("createRune")
		-- Assign rune coordinates
		rune[1].x, rune[1].y = map.tilesToPixels(20, 9)	
		rune[1].isVisible = true		
		
		objects["switch1"].x, objects["switch1"].y = map.tilesToPixels(12,5)
		objects["redAura1"].x, objects["redAura1"].y = map.tilesToPixels(12,12)

		generateObjects(objects, map, pane, rune)
	
	elseif pane == "U" then
		-- Assign rune coordinates
		rune[2].x, rune[2].y = map.tilesToPixels(20, 9)	
		rune[2].isVisible = true

		generateObjects(objects, map, pane, rune)	
	
	elseif pane == "D" then

	end

	destroyObjects(rune, energy, objectList)
end

local function destroyAll() 
	for i=1, #energy do
		display.remove(energy[i])
		energy[i] = nil
	end
end

fifteen.load = load
fifteen.destroyAll = destroyAll

return fifteen