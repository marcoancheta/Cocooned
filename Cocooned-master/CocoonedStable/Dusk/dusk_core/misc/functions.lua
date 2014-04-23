--------------------------------------------------------------------------------
--[[
Dusk Engine Component: Functions

Various helper functions for the rest of Dusk to use.
--]]
--------------------------------------------------------------------------------

local functions = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local json = require("json")
local lib_settings = require("Dusk.dusk_core.misc.settings")
local dot = require("Dusk.dusk_core.misc.dot")
local tprint = require("Dusk.dusk_core.misc.tprint")

local type = type
local pairs = pairs
local table_concat = table.concat
local string_len = string.len

--------------------------------------------------------------------------------
-- Mini Functions
--------------------------------------------------------------------------------
-- String to value
local stringToValue = function(value) local v if value == "true" or value == "false" then if value == "true" then v = true else v = false end elseif value:match("%-?%d+%.?[%d]+") == value then v = tonumber(value) elseif value:match("^!json!") then v = json.decode(value:sub(7)) else if value:sub(1,1) == "\"" and value:sub(-1) == "\"" then v = value:sub(2, -2) else v = value end end return v end
-- First not nil
local fnn = function(...) for i = 1, #arg do if arg[i] ~= nil then return arg[i] end end end
-- Splice table
local spliceTable = function(elements, primary, secondary) local newTable = {} for k, v in pairs(elements) do newTable[k] = fnn(primary[k], secondary[k]) end return newTable end
-- Is polygon clockwise
local function isPolyClockwise(pointList) local area = 0 for i = 1, #pointList - 2, 2 do local pointStart = {x = pointList[i] - pointList[1], y = pointList[i + 1]-pointList[2]} local pointEnd = {x = pointList[i + 2]-pointList[1], y = pointList[i + 3]-pointList[2]} area = area + (pointStart.x*-pointEnd.y)-(pointEnd.x*-pointStart.y) end return (area < 0) end
-- Reverse polygon (in form of [x,y, x,y, x,y], not [[x,y], [x,y]])
local function reversePolygon(t) local nt = {} for i = 1, #t, 2 do nt[#nt + 1] = t[#t - i] nt[#nt + 1] = t[#t - i + 1] end return nt end
-- Get X/Y (either number[x] and number[y], table[x] with .x,.y, or table[x] with [1],[2])
local function getXY(x, y) local x, y = x, y if type(x) == "table" then if x.x and x.y then x, y = x.x, x.y else x, y = x[1], x[2] end end if x and y then return x, y else tprint.error("Missing X- or Y-argument.") end end
-- Clamp value to a range
local function clamp(v, l, h) return (v < l and l) or (v > h and h) or v end
-- Reverse table ([1, 2, 3] -> [3, 2, 1])
local function reverseTable(t) local new = {} for i = 1, #t do new[#t - (i - 1)] = t[i] end return new end
-- Add properties
local function addProperties(props, propName, obj) for k, v in pairs(props[propName]) do if (lib_settings.get("dotImpliesTable") or props.options.usedot[k]) and not props.options.nodot[k] then dot(obj, k, v) else obj[k] = v end end end
-- Get directory
local function getDirectory(dirTree, path) local path = path local numDirs = #dirTree local _i = 1 while path:sub(_i, _i + 2) == "../" do _i = _i + 3 numDirs = numDirs - 1 end local filename = path:sub(_i) local dirPath = table_concat(dirTree, "/", 1, numDirs) return dirPath, filename end
-- Has bit
local function hasBit(x, p) return x % (p + p) >= p end
-- Set bit
local function setBit(x, p) return hasbit(x, p) and x or x + p end
-- Clear bit
local function clearBit(x, p) return x - p end

--------------------------------------------------------------------------------
-- Get Properties
--------------------------------------------------------------------------------
local function getProperties(data, objPrefix, isLayer)
	local p = {
		options = {nodot = {}, usedot = {}},
		physics = {{}}, -- Start with one element for the default body
		object = {},
		layer = {},
		props = {}
	}

	if not isLayer then p.layer = nil end
	
	local insertionTable
	local objPrefix = objPrefix or "tiles" -- This goes in front of the properties meant for each object in the layer
	local objPrefixLen = objPrefix:len() + 2 -- +2 because +1 is required for the colon after the prefix, and +1 is required to start at the character after that

	for key, value in pairs(data) do
		local k, v

		local dotMode = "default"
		if key:match("^!nodot!") then
			key = key:sub((lib_settings.get("spaceAfterEscapedPrefix") and 9) or 8)
			dotMode = "0"
		elseif key:match("^!dot!") then
			key = key:sub((lib_settings.get("spaceAfterEscapedPrefix") and 7) or 6)
			dotMode = "1"
		end

		if key:match("^physics:") then
			insertionTable = p.physics[1]
			k = key:sub(9)
		elseif key:match("^physics%d+:") then
			local match = key:match("physics(%d+):")
			local _i = tonumber(match)
			if not p.physics[_i] then p.physics[_i] = {} end
			insertionTable = p.physics[_i]
			k = key:sub(9 + string_len(match))
		elseif key:match("^props:") then
			insertionTable = p.props
			k = key:sub(6)
		else
			if isLayer then
				if key:match("^" .. objPrefix .. ":") then
					insertionTable = p.object
					k = key:sub(objPrefixLen)
				else
					insertionTable = p.layer
					if key:match("^layer:") then k = key:sub(7) else k = key end
				end
			else
				insertionTable = p.object
				if key:match("^self:") then k = key:sub(5) else k = key end
			end
		end

		v = stringToValue(value)

		if k == "enabled" and insertionTable == p.physics[1] then
			if v == true then
				p.options.physicsExistent = true
			elseif v == false then
				p.options.physicsExistent = false
			end
		else
			if dotMode == "1" then p.options.usedot[k] = true elseif dotMode == "0" then p.options.nodot[k] = true end
			insertionTable[k] = v
		end
	end

	local i = 1
	local newPhysics = {}

	while p.physics[i] do newPhysics[i] = p.physics[i] i = i + 1 end -- Clip off any gaps in the physics table (created with a property like physics3:somethingOrOther and no physics2)

	p.physics = newPhysics
	p.options.physicsBodyCount = #p.physics

	return p
end

--------------------------------------------------------------------------------
-- Add Functions to Public Library
--------------------------------------------------------------------------------
functions.stringToValue = stringToValue
functions.fnn = fnn
functions.spliceTable = spliceTable
functions.isPolyClockwise = isPolyClockwise
functions.reversePolygon = reversePolygon
functions.getXY = getXY
functions.clamp = clamp
functions.reverseTable = reverseTable
functions.addProperties = addProperties
functions.getProperties = getProperties
functions.getDirectory = getDirectory
functions.hasBit = hasBit
functions.setBit = setBit
functions.clearBit = clearBit

return functions