--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- physicsData.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function getData(levelNum)
	return (require("levels." .. levelNum .. "_collision.walls")).physicsData(1.0)
end

local function getWater(levelNum)
	return (require("levels." .. levelNum .. "_collision.water")).physicsData(1.0)
end

local function getAura(levelNum)
	return (require("levels." .. levelNum .. "_collision.auraWalls")).physicsData(1.0)
end

local physicsData = {
	getData = getData,
	getWater = getWater,
	getAura = getAura
}

return physicsData