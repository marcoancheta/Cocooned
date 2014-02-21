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
local tempPane

--------------------------------------------------------------------------------
-- touchScreen function
--------------------------------------------------------------------------------
function swipeScreen(event, mapData, player, miniMap)


	-- phase name
	local phase = event.phase
	tempPane = mapData.pane

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
	--[[
	local switchPanesSheet = graphics.newImageSheet( "mapdata/graphics/switchPanesSheet.png", {width = 72, height = 72, sheetContentWidth = 792, sheetContentHeight = 72, numFrames = 6} )
 
	local paneSwitch = display.newSprite( switchPanesSheet, spriteOptions.paneSwitch )
	paneSwitch.x = display.contentWidth/2  --center the sprite horizontally
	paneSwitch.y = display.contentHeight/2  --center the sprite vertically
		
	paneSwitch = display.newSprite(switchPanesSheet, spriteOptions.paneSwitch)
	paneSwitch.speed = 8
	paneSwitch.isVisible = false
	paneSwitch.isBodyActive = true
    paneSwitch.collision = onLocalCollision
    paneSwitch:setSequence( "move" )
    --]]

	--miniMapMechanic.updateMiniMap(mapData, miniMap, swipeX, swipeY)

	local direction = "N"

	if gameData.isShowingMiniMap ~= true then
		-- if event touch is ended, check which way was swiped 
		-- change pane is possible
		if "ended" == phase or "cancelled" == phase then

			if mapData.pane == "M" then
				if event.xStart > event.x and swipeLength > swipeLengthY and swipeLength > 150 then
					--paneSwitch:play()
					mapData.pane, direction = "L", "L"
				elseif event.xStart < event.x and swipeLength > swipeLengthY and swipeLength > 150 then
					--paneSwitch:play()
					mapData.pane, direction = "R", "R"
				elseif event.yStart > event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
					--paneSwitch:play()
					mapData.pane, direction = "U", "U"
				elseif event.yStart < event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
					--paneSwitch:play()
					mapData.pane, direction = "D", "D"
				end
			elseif mapData.pane == "L" then
				if event.xStart < event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
					--paneSwitch:play()
					mapData.pane , direction = "M", "L"
				elseif swipeLength > 150 and swipeLengthY > 150 and swipeX > 0 then
					if event.yStart > event.y then
						--paneSwitch:play()
						mapData.pane, direction = "U", "LU"
					elseif event.yStart < event.y then
						--paneSwitch:play()
						mapData.pane, direction = "D", "LD"
					end
				end
			elseif mapData.pane == "R" then
				if event.xStart > event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
					--paneSwitch:play()
					mapData.pane = "M"
				elseif swipeLength > 150 and swipeLengthY > 150 and swipeX < 0 then
					--paneSwitch:play()
					if event.yStart > event.y then
						--paneSwitch:play()
						mapData.pane = "U"
					elseif event.yStart < event.y then
						--paneSwitch:play()
						mapData.pane = "D"
					end
				end
			elseif mapData.pane == "U" then
				if event.yStart < event.y and swipeLength < swipeLengthY and swipeLength < 150 then
					--paneSwitch:play()
					mapData.pane = "M"
				elseif swipeLengthY > 150 and swipeLength > 150 and swipeY > 0 then
					--paneSwitch:play()
					if event.xStart < event.x then
						--paneSwitch:play()
						mapData.pane = "R"
					elseif event.xStart > event.x then
						--paneSwitch:play()
						mapData.pane = "L"
					end
				end
			elseif mapData.pane == "D" then
				if event.yStart > event.y and swipeLength < swipeLengthY and swipeLength < 150 then
					--paneSwitch:play()
					mapData.pane = "M"
				elseif swipeLengthY > 150 and swipeLength > 150 and swipeY < 0 then
					if event.xStart < event.x then
						--paneSwitch:play()
						mapData.pane = "R"
					elseif event.xStart > event.x then
						--paneSwitch:play()
						mapData.pane = "L"
					end
				end
			end
			--miniMapMechanic.resetMiniMap(miniMap, mapData, player)
			print("swipe", mapData.pane)
			
		end
	elseif gameData.isShowingMiniMap == true then
		
	end
end
local tempPane2
--------------------------------------------------------------------------------
-- tap mechanic
--------------------------------------------------------------------------------
function tapScreen(event, miniMap, mapData, physics, map, player) 
	-- if tapped twice, show miniMap or if showing, hide it
	if event.numTaps >= 2 and player.movement == "accel" then
		-- show miniMap 
		if gameData.isShowingMiniMap == false then
			miniMapMechanic.updateMiniMap(mapData, miniMap, map, player)
			tempPane2 = mapData.pane
			player.xGrav = 0
			player.yGrav = 0
			print("show", tempPane2)
			--physics.pause()
			gameData.isShowingMiniMap = true
			miniMap.alpha = 0.75
		else
		--hide miniMap
			
			print("hide", tempPane2)
			--physics.start()
			gameData.isShowingMiniMap = false
			miniMap.alpha = 0
			return tempPane2
		end
	else
		if gameData.isShowingMiniMap  == true then
			miniMapMechanic.moveMiniMap(miniMap, mapData, event)
		end
	end
	return mapData.pane
end


local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen
}

return touchMechanic

--end of touch mechanic