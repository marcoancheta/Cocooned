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
local function removeFlake(target)
    target:removeSelf()
    target = nil
end

local function spawnSnowFlake()
    local flake = display.newCircle(0,0,5)
    flake.x = math.random(display.contentWidth)
    flake.y = -2
    local wind = math.random(80) - 40
    transition.to(flake,{time=math.random(10000) + 3000, y = display.contentHeight + 2, x = flake.x + wind, onComplete=removeFlake})
end

local function makeSnow(event)
    if math.random(10) == 1 then -- adjust speed here by making the random number higher or lower
		spawnSnowFlake()
	end
	return true
end

local snow = {
	makeSnow = makeSnow
}

return snow
-- end of snow.lua