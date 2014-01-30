--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- touchMechanic.lua
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
function swipeScreen(event, mapData, player)

	-- phase name
	local phase = event.phase
	local tempPane = mapData.pane


--------------------------------------------------------------------------------
-- swipe mechanic
--------------------------------------------------------------------------------

	--get swipe length for x and y
	local swipeLength = math.abs(event.x - event.xStart)
	local swipeLengthY = math.abs(event.y - event.yStart)

	local swipeX = event.x - event.xStart
	local swipeY = event.y - event.yStart

	if gameData.isShowingMiniMap then
		miniMap.updateMiniMap(mapData, miniMapDisplay, swipeX, swipeY)
	end
	
	-- if event touch is ended, check which way was swiped 
	-- change pane is possible
	if "ended" == phase or "cancelled" == phase then
		if event.xStart > event.x and swipeLength > 50 and swipeLengthY < 50 then 
			print("Swiped Right")
			if mapData.pane == "M" then
				mapData.pane = "L"
			elseif mapData.pane == "R" then
				mapData.pane = "M"
			end
		elseif event.xStart < event.x and swipeLength > 50  and swipeLengthY < 50 then 
			print( "Swiped Left" )
			if mapData.pane == "M" then
				mapData.pane = "R"
			elseif mapData.pane == "L" then
				mapData.pane = "M"
			end
		elseif event.yStart > event.y and swipeLengthY > 35 and swipeLength < 50 then
			print( "Swiped Down" )
			if mapData.pane == "M" then
				mapData.pane = "D"
			elseif mapData.pane == "U" then
				mapData.pane = "M"
			end
		elseif event.yStart < event.y and swipeLengthY > 35 and swipeLength <50 then
			print( "Swiped Up" )
			if mapData.pane == "M" then
				mapData.pane = "U"
			elseif mapData.pane == "D" then
				mapData.pane = "M"
			end
		end	

		-- if miniMap is showing and pane switched, remove miniMap
		if tempPane ~= mapData.pane and gameData.isShowingMiniMap then
			miniMap.resetMiniMap()
			miniMapDisplay:removeSelf()
			gameData.isShowingMiniMap = false
			print("showing miniMap")
		end
		-- print debug for white pane is swtiched
		--print(mapDataT.pane)
	end	
end

function tapScreen(event, mapData, player, physics) 

	--------------------------------------------------------------------------------
	-- miniMap mechanic
	--------------------------------------------------------------------------------

	if event.numTaps >= 2 then
		if gameData.showMiniMap then
			if gameData.isShowingMiniMap then
				physics.start()
				miniMapDisplay:removeSelf()
				gameData.isShowingMiniMap = false
				print("show miniMap")
			else
				physics.pause()
				miniMapDisplay = miniMap.createMiniMap(mapData, player)
				gameData.isShowingMiniMap = true
			end

		end
	end
end


local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen
}

return touchMechanic

--end of touch mechanic