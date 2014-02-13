--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- fifteen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")


local fifteen = { 
}
local energy = {} 
local objects = {}

local function generateEnergy(energy, map, startIndex, endIndex)
	-- Position coins
	local count = 1
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
		count = count + 1
	end
end

local function destroyObjects(rune, objectList) 
	for i = 1, #rune do
		if rune[i].isVisible == false then
			rune[i]:removeSelf()
			rune[i] = nil
		end
	end

end

local function load(pane, map, rune, objectList, sheetList)
	
	-- Check which pane
	if pane == "M" then
		print("createRune")
		-- Assign rune coordinates
		rune[1].x, rune[1].y = map.tilesToPixels(20, 9)			
		-- Insert blueRune to map
		map.layer["tiles"]:insert(rune[1])	
		-- Only make it visible once when gameStarts
		rune[1].isVisible = true

		for i=1, 10 do	
			print("create pane M")
	   		energy[i] = display.newSprite(sheetList[1], spriteOptions.energy)
	   		energy[i].x, energy[i].y = map.tilesToPixels(i*3, 7)
	   		
		end
		generateEnergy(energy, map, 1, 10)
	
	elseif pane == "U" then
		-- Assign rune coordinates
		rune[2].x, rune[2].y = map.tilesToPixels(38, 9)	
		rune[2].isVisible = true	
		-- Insert greenRune to map
		map.layer["tiles"]:insert(rune[2])		
		for i=11, 20 do	
			print("create pane U")
	   		energy[i] = display.newSprite(sheetList[1], spriteOptions.energy)
	   		energy[i].x, energy[i].y = map.tilesToPixels((i-10)*3, 7)
		end
		generateEnergy(energy, map, 11, 20)

	elseif pane == "D" then
		-- Assign rune coordinates
		rune[3].x, rune[3].y = map.tilesToPixels(5, 15)
		rune[3].isVisible = true
		-- Insert pinkRune to map`
		map.layer["tiles"]:insert(rune[3])
		
		for i=21, 30 do	
	   		energy[i] = display.newSprite(sheetList[1], spriteOptions.energy)
	   		energy[i].x, energy[i].y = map.tilesToPixels((i-20)*3, 7)
		end
		generateEnergy(energy, map, 21, 30)
	end

	destroyObjects(rune, objectList)
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