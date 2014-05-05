--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- snow.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Simple snow effect: http://forums.coronalabs.com/topic/27637-snow-effect/
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
local levelNames = require("utils.levelNames")
local gameData = require("Core.gameData")
local fGroup

local function new()
	fGroup = display.newGroup()
end

local function meltSnow()
	transition.cancel()
	
	if fGroup then
		fGroup:removeSelf()
		fGroup = nil
	end
end


local function removeFlake(target)
    target:removeSelf()
    target = nil
end

local function spawnSnowFlake()
    local flake = display.newCircle(0,0,5)
	flake.name = "flake"
    flake.x = math.random(display.contentWidth)
    flake.y = -2
    local wind = math.random(80) - 40
    flake.trans = transition.to(flake,{time=math.random(10000) + 3000, 
										y = display.contentHeight, 
										x = flake.x + wind, 
										onComplete=removeFlake})
										
	return flake
end

--[[
local function levelSnow(mapData)
	local level = require("levels." .. levelNames[mapData.levelNum])
	local xPos = {math.random(display.contentWidth), -math.random(display.contentWidth), math.random(display.contentWidth)}
	local yPos = { }
	local flake = display.newCircle(0,0,5)
	local wind = math.random(80) - 40
	
	for i=1, #level.panes do
		if level.panes[i] then
			print("level.panes[" ..i.. "]", level.panes[i])
			for j=1, i, 1 do
				if j==i then
					if mapData.pane == "M" then
						flake.x = math.random(display.contentWidth)
						flake.y = -2
						local snowTrans = transition.to(flake,{time=math.random(10000) + 3000, 
														y = 200, x = flake.x + wind, 
														onComplete=removeFlake})
					end
				end
			end
		end
	end
end
]]--

local function makeSnow(event, mapData)
	local temp
    if math.random(10) == 1 then -- adjust speed here by making the random number higher or lower
		temp = spawnSnowFlake()
		fGroup:insert(temp)
		fGroup:toFront()
	end	
	
	return true
end

--[[
local function gameSnow(event, mapData)
	if math.random(10) == 1 then -- adjust speed here by making the random number higher or lower
		levelSnow(mapData)
	end	
	return true
end
]]--

local snow = {
	makeSnow = makeSnow,
	--[[
	levelSnow = levelSnow,
	gameSnow = gameSnow,
	]]--
	new = new,
	meltSnow = meltSnow
}

return snow
-- end of snow.lua