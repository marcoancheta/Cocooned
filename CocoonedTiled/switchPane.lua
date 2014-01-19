--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- switchPane.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local dusk = require("Dusk.Dusk")
local print = print


function switchP(event, mapData)


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
			if mapData.pane == "M" then
				mapData.pane = "L"
			elseif mapData.pane == "R" then
				mapData.pane = "M"
			end
		elseif event.xStart < event.x and swipeLength > 50 then 
			print( "Swiped Right" )
			if mapData.pane == "M" then
				mapData.pane = "R"
			elseif mapData.pane == "L" then
				mapData.pane = "M"
			end
		elseif event.yStart > event.y and swipeLengthy > 50 then
			print( "Swiped Down" )
			if mapData.pane == "M" then
				mapData.pane = "D"
			elseif mapData.pane == "U" then
				mapData.pane = "M"
			end
		elseif event.yStart < event.y and swipeLengthy > 50 then
			print( "Swiped Up" )
			if mapData.pane == "M" then
				mapData.pane = "U"
			elseif mapData.pane == "D" then
				mapData.pane = "M"
			end
		end	
		
		-- print debug for white pane is swtiched
		--print(mapDataT.pane)
	end	
end

local switchPane = {
	switchP = switchP
}

return switchPane

--end of switchPane mechanic