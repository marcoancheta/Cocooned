local gameData = require("gameData")
local movement = require("movement")

local floor = math.floor
local atan2 = math.atan2
local pi = math.pi

local rSpirits = {}
local playerCoord = {}
local spiritSprites = {}

local temp = {}

local function run(event)
	if gameData.blueG then
		
		-- Moveable walls
		for check = 1, map.layer["tiles"].numChildren do
			if map.layer["tiles"][check].name == "orangeWall" then
				
				map.layer["tiles"][check].bodyType = "dynamic"
			end
		end
			
		print("blue spirit")
		Runtime:removeEventListener("enterFrame", run)
		gameData.blueG = false
	elseif gameData.pinkG then
		temp[1].time = 20000
		temp[2].time = 20000
		temp[3].time = 20000
		temp[4].time = 20000
		
		print("pink spirit")
		Runtime:removeEventListener("enterFrame", run)
		gameData.pinkG = false
	elseif gameData.greenG then
		print("green spirit")
		Runtime:removeEventListener("enterFrame", run)
		gameData.greenG = false
	end
end

local function processSpirits(objects, rune, map)

	temp[1] = objects["moveWall1"]
	temp[2] = objects["moveWall2"]
	temp[3] = objects["moveWall3"]
	temp[4] = objects["moveWall4"]
	
	Runtime:addEventListener("enterFrame", run)
end

rSpirits.processSpirits = processSpirits

return rSpirits