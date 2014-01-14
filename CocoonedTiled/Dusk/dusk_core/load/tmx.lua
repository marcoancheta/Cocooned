--------------------------------------------------------------------------------
--[[
Dusk Engine Component: TMX

Parses TMX map data.
--]]
--------------------------------------------------------------------------------

local lib_tmx = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local tprint = require("Dusk.dusk_core.misc.tprint")

--------------------------------------------------------------------------------
-- Parse TMX String
--------------------------------------------------------------------------------
function lib_tmx.parse(str)
	tprint.add("Parse TMX")

	-- TMX parsing goes here

	-- For now, though, we can't parse it, so throw an error
	tprint.error("TMX map support is still in development.")

	tprint.remove()
end

return lib_tmx