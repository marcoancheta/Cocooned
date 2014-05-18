--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- physicsData.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Physics data for all levels (except Level Selector and World)
local function getData(levelNum)
	return (require("levels." .. levelNum .. "_collision.walls")).physicsData(1.0)
end

-- Physics data for level selector scenes only
local function getLSData(level)
	return (require("levels." .. level.levelNum .. "_collision." ..level.world.. ".walls")).physicsData(1.0)
end

-- Physics data for world scene only
local function getWorldData(levelNum)
	return (require("levels." .. levelNum .. "_collision.walls")).physicsData(1.0)
end

-- Physics data for water
local function getWater(levelNum)
	return (require("levels." .. levelNum .. "_collision.water")).physicsData(1.0)
end

-- Physics data for aura walls
local function getAura(levelNum)
	return (require("levels." .. levelNum .. "_collision.auraWalls")).physicsData(1.0)
end

-- Physics data for shore
local function getFloor(levelNum)
	return (require("levels." .. levelNum .. "_collision.floor")).physicsData(1.0)
end

-- Physics data for objects
local function getObject(objName)
	return (require("collision." .. objName .. "")).physicsData(1.0)
end

local physicsData = {
	getData = getData,
	getLSData = getLSData,
	getWorldData = getWorldData,
	getWater = getWater,
	getAura = getAura,
	getFloor = getFloor,
	getObject = getObject
}

return physicsData