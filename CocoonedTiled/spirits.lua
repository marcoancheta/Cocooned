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
		
		for i=5, 18 do
			temp[i].bodyType = "dynamic"
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

local function processSpirits(objects, rune, map, breakWall)

	temp[1] = objects["moveWall1"]
	temp[2] = objects["moveWall2"]
	temp[3] = objects["moveWall3"]
	temp[4] = objects["moveWall4"]
	
	for i=5, #breakWall do
		temp[i] = breakWall[i-4]
	end
	
	Runtime:addEventListener("enterFrame", run)
end

rSpirits.processSpirits = processSpirits

return rSpirits