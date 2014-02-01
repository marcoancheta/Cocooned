--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- touchMechanic.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local dusk = require("Dusk.Dusk")
local gameData = require("gameData")
local miniMapMechanic = require("miniMap")
local print = print

--------------------------------------------------------------------------------
-- Variables for touch mechanics
--------------------------------------------------------------------------------

-- variable for miniMap mechanic for previous tap time
local tapTime = 0
local canSwipe = true

--------------------------------------------------------------------------------
-- touchScreen function
--------------------------------------------------------------------------------
function swipeScreen(event, mapData, player, miniMap)

	-- phase name
	local phase = event.phase
	local tempPane = mapData.pane

--------------------------------------------------------------------------------
-- swipe mechanic
--------------------------------------------------------------------------------

	--get swipe length for x and y
	local swipeLength = math.abs(event.x - event.xStart)
	local swipeLengthY = math.abs(event.y - event.yStart)

	-- move miniMap to show feedback of panes moving
	local swipeX = event.x - event.xStart
	local swipeY = event.y - event.yStart
	-- function call to move miniMap
	miniMapMechanic.updateMiniMap(mapData, miniMap, swipeX, swipeY)
	
	-- if event touch is ended, check which way was swiped 
	-- change pane is possible
	if "ended" == phase or "cancelled" == phase then
		if event.xStart > event.x and swipeLength > swipeLengthY and swipeLength > 20 then 
			print("Swiped Right")
			if mapData.pane == "M" then
				mapData.pane = "L"
			elseif mapData.pane == "R" then
				mapData.pane = "M"
			end
		elseif event.xStart < event.x and swipeLength > swipeLengthY and swipeLength > 20 then 
			print( "Swiped Left" )
			if mapData.pane == "M" then
				mapData.pane = "R"
			elseif mapData.pane == "L" then
				mapData.pane = "M"
			end
		elseif event.yStart > event.y and swipeLength < swipeLengthY and swipeLengthY > 15 then
			print( "Swiped Down" )
			if mapData.pane == "M" then
				mapData.pane = "D"
			elseif mapData.pane == "U" then
				mapData.pane = "M"
			end
		elseif event.yStart < event.y and swipeLength < swipeLengthY and swipeLengthY > 15 then
			print( "Swiped Up" )
			if mapData.pane == "M" then
				mapData.pane = "U"
			elseif mapData.pane == "D" then
				mapData.pane = "M"
			end
		end	
	end	

	-- if switching panes, move miniMap cursor to that pane and set alpha to 0
	if tempPane ~= mapData.pane then
		miniMapMechanic.resetMiniMap(miniMap, mapData)
		if gameData.isShowingMiniMap then
			miniMap.alpha = 0
			gameData.isShowingMiniMap = false
		end
	end

end

--------------------------------------------------------------------------------
-- tap mechanic
--------------------------------------------------------------------------------
function tapScreen(event, miniMap, physics) 
	-- if tapped twice, show miniMap or if showing, hide it
	if event.numTaps >= 2 then
		-- show miniMap 
		if miniMap.alpha == 0 then
			gameData.isShowingMiniMap = true
			miniMap.alpha = 0.75
		else
		--hide miniMap
			gameData.isShowingMiniMap = false
			miniMap.alpha = 0
		end
	end
end


local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen
}

return touchMechanic

--end of touch mechanic