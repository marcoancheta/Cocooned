--------------------------------------------------------------------------------
--[[
Dusk Engine Component: TPrint

The Dusk debugging system.
--]]
--------------------------------------------------------------------------------

local tprint = {}

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local table_insert = table.insert
local table_concat = table.concat
local print = print

tprint.traceback = {"Base"}
tprint.current = ""
tprint.isVisible = true

--------------------------------------------------------------------------------
-- Modify Traceback
--------------------------------------------------------------------------------
-- Add an item to traceback
function tprint.add(s)
	if tprint.current ~= "" then table_insert(tprint.traceback, tprint.current) end
	tprint.current = s
end

-- Remove last item from traceback
function tprint.remove()
	tprint.current = tprint.traceback[#tprint.traceback]
	tprint.traceback[#tprint.traceback] = nil
end

-- String-ize the traceback
function tprint.getTraceback()
	return "[" .. table_concat(tprint.traceback, "]:[") .. "]"
end

-- Clear traceback
function tprint.clear()
	tprint.traceback = {}
	tprint.current = ""
	tprint.isVisible = true
end

--------------------------------------------------------------------------------
-- List Error and Stop Program
--------------------------------------------------------------------------------
function tprint.error(er)
	local e = "\n\nDusk Error:\n  " .. er
	tprint(e, true)
	tprint.remove()
	error() -- Terminate program
end

function tprint.assert(condition, er)
	if not condition then tprint.error(er) end
end

local mt = {}

function mt.__call(self, msg, addTraceback) -- Print message
	if tprint.isVisible then
		if addTraceback then
			local m = msg .. "\n\n  State: " .. tprint.current .. "\n  Traceback: " .. tprint.getTraceback()
			print(m)
		elseif not addTraceback then
			print(msg)
		end
	end
end

return setmetatable(tprint, mt)