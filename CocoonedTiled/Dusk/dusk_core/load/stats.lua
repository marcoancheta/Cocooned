--------------------------------------------------------------------------------
--[[
Dusk Engine Component: Stats

Collects general statistics about a map.
--]]
--------------------------------------------------------------------------------

local lib_stats = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local tprint = require("Dusk.dusk_core.misc.tprint")
local screen = require("Dusk.dusk_core.misc.screen")

local math_floor = math.floor

--------------------------------------------------------------------------------
-- Get Stats
--------------------------------------------------------------------------------
function lib_stats.get(data)
	local stats = {}

	if
		not data.layers or
		not data.tilesets or
		not data.width or
		not data.height or
		not data.tilewidth or
		not data.tileheight then
	
		tprint.error("Map is corrupted - missing one or more statistic values.")
	end

	stats.numTiledLayers = #data.layers
	stats.tilesetCount = #(data.tilesets or {})
	stats.orientation = data.orientation
	stats.mapWidth = data.width
	stats.mapHeight = data.height
	stats.rawTileWidth = data.tilewidth
	stats.rawTileHeight = data.tileheight
	stats.tileWidth = data.tilewidth * screen.zoomX
	stats.tileHeight = data.tileheight * screen.zoomY
	stats.width = stats.mapWidth * stats.tileWidth
	stats.height = stats.mapHeight * stats.tileHeight

	return stats
end

return lib_stats