--[[
Twindex Data Structure
v1.0

by Caleb Place of Gymbyl Coding (written for Dusk Engine)

A fast and easy data structure for iterating through 2D arrays.

if twindex.loadMatrixUseYArray is set to true, matrix loading must use arrays of this format:

{
	{0, 0, 1, 0, 1},
	{1, 1, 0, 1, 0},
	{0, 1, 0, 0, 1},
	{0, 1, 1, 0, 1},
	{1, 0, 0, 1, 1}
}

Otherwise, arrays of this format must be used:

{
	0, 0, 1, 0, 1,
	1, 1, 0, 1, 0,
	0, 1, 0, 0, 1,
	0, 1, 1, 0, 1,
	1, 0, 0, 1, 1
}

Happy quickterating!
www.github.com/GymbylCoding
--]]

local twindexLib={}

twindexLib.loadMatrixUseYArray = false
twindexLib.off = 0

--[[
Seek Algorithms:

"fromHigh" -
	This seek algorithm starts at the bottom of the seek area if seeking Y or the right side if seeking X and goes backwards - up for Y and left for X.

"fromLow" -
	This seek algorithm starts at the top of the seek area if seeking Y or the left side if seeking X and goes forwards - down for Y and right for X.

"firstNotNil" -
	Note: Not implemented yet!
	Iterates alternatively from the high and low sides to find the first non-nil cell. Seeks from thence.

Nota Bene: Picking your seek algorithm is important - if your map is mostly oriented towards the bottom (or the right side) of your screen, use the fromHigh algorithm to minimize iteration. If most of your objects are on the top or left, use fromLow. This assures the maximum speed for iteration.
--]]
twindexLib.seekAlgorithm = "fromHigh"

local table_insert	= table.insert
local setmetatable	= setmetatable

function twindexLib.buildTwindex(real)
	local twindex = {}
	local real = real

	local off = twindexLib.off -- Number representing values that evaluate to empty

	local matrix = {}
	local xIndex = {}
	local yIndex = {}
	local loadMatrixUseYArray = twindexLib.loadMatrixUseYArray
	local checkEmpty

	if loadMatrixUseYArray then
		checkEmpty = function(a, x, y)
			if a[y] and a[y][x] then
				return a[y][x] == off
			else
				return true
			end
		end
	else
		checkEmpty = function(a, x, y, w, h)
			local i = ((y - 1) * w) + x
			if a[i] then
				return a[i] == off
			else
				return true
			end
		end
	end

	------------------------------------------------------------------------------
	-- Load Matrix
	------------------------------------------------------------------------------
	function twindex.loadMatrix(w, h, data)
		if real then
			local h = h -- Height
			local w = w -- Width
			twindex._W = w; twindex._H = h

			-- Build Y-indices
			for y = 1, h do
				matrix[y]={}
				for x = 1, w do
					local r = checkEmpty(data, x, y, w, h)

					if not r then
						local element = {x, y}
						table_insert(xIndex, element) -- Add X,Y position to xIndex
						matrix[y][x] = #xIndex
					else
						matrix[y][x] = off
					end
				end
			end

			-- Build X-indices
			for x = 1, w do
				for y = 1, h do
					if matrix[y][x] and matrix[y][x] ~= off then
						local element = {x, y}
						table_insert(yIndex, element) -- Add X,Y position to yIndex
						matrix[y][x] = {matrix[y][x], #yIndex} -- Overwrite previous number value with table
					end
				end
			end
		end
	end

	if real then
		------------------------------------------------------------------------------
		-- Seek Y
		-- Traverse vertically through the matrix
		------------------------------------------------------------------------------
		function twindex.seekY(x, y1, y2, func)
			local x = x
			local y1 = y1
			local y2 = y2
			local i
			local mark
			local isEmpty = false
			local iterate

			if twindexLib.seekAlgorithm == "fromLow" then
				i = y1

				while i <= y2 and i <= twindex._H do
					if matrix[i][x] ~= off then
						mark = i
						break
					else
						i = i + 1
					end
				end
				
				if i == y2 and matrix[i][x] == off then -- Iterated through entire column without hitting an existent element
					isEmpty = true
				end

				iterate = function()
					while (true) do -- Loop until manually broken by a change in X or a surpassed y2
						local e = yIndex[i]

						if e ~= nil and e[1] == x and e[2] <= y2 then
							i = i + 1
							--print("iterating "..e[1]..","..e[2])
							func(e[1], e[2])
						else
							--print("breaking")
							break
						end
					end
				end
			elseif twindexLib.seekAlgorithm == "fromHigh" then
				i = y2

				while i >= y1 and i >= 1 do
					if matrix[i][x] ~= off then
						mark = i
						break
					else
						i = i - 1
					end
				end

				if i == y1 and matrix[i][x] == off then
					isEmpty = true
				end

				iterate = function()
					while (true) do
						local e = yIndex[i]

						if e ~= nil and e[1] == x and e[2] >= y1 then
							i = i - 1
							--print("iterating "..e[1]..","..e[2])
							func(e[1], e[2])
						else
							--print("breaking")
							break
						end
					end
				end
			end

			if not isEmpty and matrix[i] and matrix[i][x] ~= nil and matrix[i][x] ~= off then
				local iIndex = matrix[i][x][2]
				i = iIndex

				iterate()
			end
		end -- twindex.seekY

		------------------------------------------------------------------------------
		-- Seek X
		-- Traverse horizontally through the matrix
		------------------------------------------------------------------------------
		function twindex.seekX(y, x1, x2, func)
			local y = y
			local x1 = x1
			local x2 = x2
			local i
			local mark
			local isEmpty = false

			if twindexLib.seekAlgorithm == "fromLow" then
				i = x1
				
				print("setting up fromLow algorithm")

				while i <= x2 and i <= twindex._W do
					if matrix[y][i] ~= off then
						mark = i
						break
					else
						i = i + 1
					end
				end
				
				if i == x2 and matrix[y][i] == off then
					isEmpty = true
				end

				iterate = function()
					while (true) do
						local e = xIndex[i]

						if e ~= nil and e[2] == y and e[1] <= x2 then
							i = i + 1
							--print("iterating "..e[1]..","..e[2])
							func(e[1], e[2])
						else
							--print("breaking")
							break
						end
					end
				end
			elseif twindexLib.seekAlgorithm == "fromHigh" then
				i = x2
				
				while i >= x1 and i >= 1 do
					if matrix[y][i] ~= off then
						mark = i
						break
					else
						i = i - 1
					end
				end

				if i == x1 and matrix[y][i] == off then
					isEmpty = true
				end
				
				iterate = function()
					while (true) do
						local e = xIndex[i]
						
						if e ~= nil and e[2] == y and e[1] >= x1 then
							i = i - 1
							--print("iterating "..e[1]..","..e[2])
							func(e[1], e[2])
						else
							--print("breaking")
							break
						end
					end
				end
			end
			
			if not isEmpty and matrix[y] and matrix[y][i] ~= nil and matrix[y][i] ~= off then
				local iIndex = matrix[y][i][1]
				i = iIndex

				iterate()
			end
		end -- twindex.seekX

	elseif not real then -- Create "fake" seek functions
		function twindex.seekY(x, y1, y2, func)
			local x = x
			local y1 = y1
			local y2 = y2

			for i = y1, y2 do
				func(x, i)
			end
		end		

		function twindex.seekX(y, x1, x2, func)
			local y = y
			local x1 = x1
			local x2 = x2

			for i = x1, x2 do
				func(i, y)
			end
		end

	end -- if real then

	return twindex
end

return twindexLib