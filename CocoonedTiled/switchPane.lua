local dusk = require("Dusk.Dusk")
local print = print


function switchP(event, mapData)

	--create temp mapData
	local mapDataT = mapData

	--get swipe length for x and y
	local swipeLength = math.abs(event.x - event.xStart)
	local swipeLengthy = math.abs(event.y - event.yStart)

	--get phase name
	local t = event.target
	local phase = event.phase

	-- if event touch is ended, check which way was swiped 
	-- change pane is possible
	if "ended" == phase or "cancelled" == phase then
		if event.xStart > event.x and swipeLength > 50 then 
			print("Swiped Left")
			if mapDataT.pane == "M" then
				mapDataT.pane = "L"
			elseif mapDataT.pane == "R" then
				mapDataT.pane = "M"
			end
		elseif event.xStart < event.x and swipeLength > 50 then 
			print( "Swiped Right" )
			if mapDataT.pane == "M" then
				mapDataT.pane = "R"
			elseif mapDataT.pane == "L" then
				mapDataT.pane = "M"
			end
		elseif event.yStart > event.y and swipeLengthy > 50 then
			print( "Swiped Down" )
			if mapDataT.pane == "M" then
				mapDataT.pane = "D"
			elseif mapDataT.pane == "U" then
				mapDataT.pane = "M"
			end
		elseif event.yStart < event.y and swipeLengthy > 50 then
			print( "Swiped Up" )
			if mapDataT.pane == "M" then
				mapDataT.pane = "U"
			elseif mapDataT.pane == "D" then
				mapDataT.pane = "M"
			end
		end	
		mapDataT.pane = tostring(mapDataT.pane)
		-- print debug for white pane is swtiched
		--print(mapDataT.pane)
	end	

	-- return new pane
	return mapDataT.pane
end

local switchPane = {
	switchP = switchP
}

return switchPane

--end of switchPane mechanic