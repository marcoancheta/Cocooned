--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- bonusPane.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
local bonusGame = require("levels.bonusGame")

local bonusPane = {}
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

local function load(pane, map, sheetList)
	
	-- Check which pane
	if pane == "M" then
		for i=1, 10 do	
			print("create pane M")
	   		energy[i] = display.newSprite(sheetList[1], spriteOptions.energy)
	   		energy[i].x, energy[i].y = map.tilesToPixels(i*3, 15)
		end

		generateEnergy(energy, map, 1, 10)
	
	elseif pane == "U" or pane == "D" or pane == "L" or pane == "R" then
		for i=1, 2 do	
	   		energy[i] = display.newSprite(sheetList[1], spriteOptions.energy)
			energy[i].isVisible = false
		end
		
		bonusGame.main(pane, map, energy, sheetList[1])	
	end
end

local function destroyAll() 
	for i=1, #energy do
		display.remove(energy[i])
		energy[i] = nil
	end
end

bonusPane.load = load
bonusPane.destroyAll = destroyAll

return bonusPane
