--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- switchPane.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local dusk = require("Dusk.Dusk")
local gameData = require("gameData")
local miniMap = require("miniMap")
local print = print

--------------------------------------------------------------------------------
-- Variables for touch mechanics
--------------------------------------------------------------------------------

-- variable for miniMap mechanic for previous tap time
local tapTime = 0
local canSwipe = true
local miniMapDisplay

--------------------------------------------------------------------------------
-- touchScreen function
--------------------------------------------------------------------------------
function touchScreen(event, mapData, player)

	-- phase name
	local phase = event.phase
	local tempPane = mapData.pane

--------------------------------------------------------------------------------
-- miniMap mechanic
--------------------------------------------------------------------------------

	if gameData.showMiniMap then
		if "ended" == phase then
			if (event.time - tapTime) < 300 then
				print(event.time - tapTime)
				if gameData.isShowingMiniMap then
					miniMapDisplay:removeSelf()
					gameData.isShowingMiniMap = false
					print("show miniMap")
				else
					miniMapDisplay = miniMap.createMiniMap(mapData, player)
					gameData.isShowingMiniMap = true
				end
			end
			tapTime = event.time
		end
	end
	
--------------------------------------------------------------------------------
-- swipe mechanic
--------------------------------------------------------------------------------

	--get swipe length for x and y
	local swipeLength = math.abs(event.x - event.xStart)
	local swipeLengthy = math.abs(event.y - event.yStart)
	
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

		if tempPane ~= mapData.pane and gameData.isShowingMiniMap then
			miniMapDisplay:removeSelf()
			gameData.isShowingMiniMap = false
			print("showing miniMap")
		end
		-- print debug for white pane is swtiched
		--print(mapDataT.pane)
	end	
end

local touchMechanic = {
	touchScreen = touchScreen
}

return touchMechanic

--end of touch mechanic