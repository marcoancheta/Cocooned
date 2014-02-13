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
	--miniMapMechanic.updateMiniMap(mapData, miniMap, swipeX, swipeY)

	local swipeDirection

	-- Load Ball shrinking animation
	local switchPanesSheet = graphics.newImageSheet("mapdata/art/switchPanesSheet.png", 
				 {width = 72, height = 72, sheetContentWidth = 792, sheetContentHeight = 72, numFrames = 6})
		
	paneSwitch = display.newSprite(switchPanesSheet, spriteOptions.paneSwitch)
	paneSwitch.speed = 5
	paneSwitch.isVisible = false
	paneSwitch.isBodyActive = true
    --coins[i].name = "coin" .. i
    paneSwitch.collision = onLocalCollision

	--miniMapMechanic.updateMiniMap(mapData, miniMap, swipeX, swipeY)

	-- if event touch is ended, check which way was swiped 
	-- change pane is possible
	if "ended" == phase or "cancelled" == phase then

		if mapData.pane == "M" then
			if event.xStart > event.x and swipeLength > swipeLengthY and swipeLength > 150 then
				paneSwitch:play()
				mapData.pane = "L"
				swipeDirection = "L"
			elseif event.xStart < event.x and swipeLength > swipeLengthY and swipeLength > 150 then
				paneSwitch:play()
				mapData.pane = "R"
				swipeDirection = "R"
			elseif event.yStart > event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
				paneSwitch:play()
				mapData.pane = "D"
				swipeDirection = "D"
			elseif event.yStart < event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
				paneSwitch:play()
				mapData.pane = "U"
				swipeDirection = "U"
			end
		elseif mapData.pane == "L" then
			if event.xStart < event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
				paneSwitch:play()
				mapData.pane = "M"
				swipeDirection = "R"
			elseif swipeLength > 150 and swipeLengthY > 150 and swipeX > 0 then
				if event.yStart > event.y then
					paneSwitch:play()
					mapData.pane = "D"
					swipeDirection = "DR"
				elseif event.yStart < event.y then
					paneSwitch:play()
					mapData.pane = "U"
					swipeDirection = "UR"
				end
			end
		elseif mapData.pane == "R" then
			if event.xStart > event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
				paneSwitch:play()
				mapData.pane = "M"
				swipeDirection = "L"
			elseif swipeLength > 150 and swipeLengthY > 150 and swipeX < 0 then
				paneSwitch:play()
				if event.yStart > event.y then
					paneSwitch:play()
					mapData.pane = "D"
					swipeDirection = "DL"
				elseif event.yStart < event.y then
					paneSwitch:play()
					mapData.pane = "U"
					swipeDirection = "UL"
				end
			end
		elseif mapData.pane == "U" then
			if event.yStart > event.y and swipeLength < swipeLengthY and swipeLength < 150 then
				paneSwitch:play()
				mapData.pane = "M"
				swipeDirection = "D"
			elseif swipeLengthY > 150 and swipeLength > 150 and swipeY < 0 then
				paneSwitch:play()
				if event.xStart < event.x then
					paneSwitch:play()
					mapData.pane = "R"
					swipeDirection = "DR"
				elseif event.xStart > event.x then
					paneSwitch:play()
					mapData.pane = "L"
					swipeDirection = "DL"
				end
			end
		elseif mapData.pane == "D" then
			if event.yStart < event.y and swipeLength < swipeLengthY and swipeLength < 150 then
				paneSwitch:play()
				mapData.pane = "M"
				swipeDirection = "U"
			elseif swipeLengthY > 150 and swipeLength > 150 and swipeY > 0 then
				if event.xStart < event.x then
					paneSwitch:play()
					mapData.pane = "R"
					swipeDirection = "UR"
				elseif event.xStart > event.x then
					paneSwitch:play()
					mapData.pane = "L"
					swipeDirection = "UL"
				end
			end
		end
		--miniMapMechanic.resetMiniMap(miniMap, mapData, player)
		print("swipe", mapData.pane)
		
	end

	-- if switching panes, move miniMap cursor to that pane and set alpha to 0
	if tempPane ~= mapData.pane then
		miniMapMechanic.resetMiniMap(miniMap, mapData, player)
		
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
		if miniMap.isVisible == false then
			physics.pause()
			gameData.isShowingMiniMap = true
			miniMap.isVisible = true
		else
		--hide miniMap
			physics.start()
			gameData.isShowingMiniMap = false
			miniMap.isVisible = false
		end
	end
end


local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen
}

return touchMechanic

--end of touch mechanic