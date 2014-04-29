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

local function removeFlake(target)
    target:removeSelf()
    target = nil
end

local function spawnSnowFlake()
    local flake = display.newCircle(0,0,5)
    flake.x = math.random(display.contentWidth)
    flake.y = -2
    local wind = math.random(80) - 40
    local snowTrans = transition.to(flake,{time=math.random(10000) + 3000, y = display.contentHeight + 2, x = flake.x + wind, onComplete=removeFlake})
end

local function makeSnow(event)
    if math.random(10) == 1 then -- adjust speed here by making the random number higher or lower
		spawnSnowFlake()
	end
	return true
end

local function levelSnow(mapData)
	local level = require("levels." .. levelNames[mapData.levelNum])
	
	for i=1, #level.panes do
		if level.panes[i] then
			print("level.panes[" ..i.. "]", level.panes[i])
			if i==1 then
			elseif i==2 then
			elseif i==3 then
			elseif i==4 then
			end
			
			for j=1, 4, 1 do
				if i==j then
					local flake = display.newCircle(0,0,5)
					flake.x = math.random(display.contentWidth)
					flake.y = -2
					local wind = math.random(80) - 40
					local snowTrans = transition.to(flake,{time=math.random(10000) + 3000, 
										y = display.contentHeight + 2, 
										x = flake.x + wind, onComplete=removeFlake})
				end
			end
		end
	end
end

local snow = {
	makeSnow = makeSnow,
	levelSnow = levelSnow
}

return snow
-- end of snow.lua