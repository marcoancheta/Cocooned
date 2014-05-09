--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- touchMechanic.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")
-- miniMap Mechanic (miniMap.lua)
local miniMapMechanic = require("Mechanics.miniMap")
-- variable for miniMap mechanic for previous tap time
local particle_lib = require("Mechanics.touchParticles")

local tapTime = 0
local canSwipe = true
local tempPane, tempPane2

local duration = 500
local speed = 10
local density = 1
local range = 50
local thickness = 100

local touchEmitter = touchEmitterLib:createEmitter(range, thickness, duration, 1, 0, nil, nil, nil)

local levelGroup = display.newGroup()
--------------------------------------------------------------------------------
-- Check Pane - function that checks if pane is valid
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function checkPane(map, pane, tempPane, index)
	-- if pane is valid, return new pane
	if map.panes[index] == true then
		return pane
	-- else return previous pane
	else 
		return tempPane
	end
end

--------------------------------------------------------------------------------
-- Swipe Screen - functionality of swiping mechanic
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function swipeScreen(event, mapData, miniMap, map)	
	-- phase name
	local phase = event.phase

	-- save current pane for later use
	tempPane = mapData.pane

	touchEmitter:emit(levelGroup, event.x, event.y)

	--------------------------------------------------------------------------------
	-- swipe mechanic
	--------------------------------------------------------------------------------
	--get swipe length for x and y
	local swipeLength = math.abs(event.x - event.xStart)
	local swipeLengthY = math.abs(event.y - event.yStart)

	-- move real length for x and y
	local swipeX = event.x - event.xStart
	local swipeY = event.y - event.yStart

	if gameData.isShowingMiniMap ~= true then
		-- if event touch is ended, check which way was swiped 
		-- change pane is possible'
		--print(mapData.pane)
		if "ended" == phase or "cancelled" == phase then
			-- check which pane player is in and do that functionality
			if mapData.pane == "M" then
				if event.xStart < event.x and swipeLength > swipeLengthY and swipeLength > 150 then
					-- if player swiped left, check if pane is valid
					-- return new pane if switched
					mapData.pane = checkPane(map, "L", tempPane, 5) 
				elseif event.xStart > event.x and swipeLength > swipeLengthY and swipeLength > 150 then
					mapData.pane = checkPane(map, "R", tempPane, 4) 
				elseif event.yStart > event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
					mapData.pane = checkPane(map, "U", tempPane, 2) 
				elseif event.yStart < event.y and swipeLength < swipeLengthY and swipeLengthY > 150 then
					mapData.pane = checkPane(map, "D", tempPane, 3) 
				end
			elseif mapData.pane == "L" then
				if event.xStart > event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
					mapData.pane = "M"
				elseif swipeLength > 150 and swipeLengthY > 150 and swipeX > 0 then
					if event.yStart > event.y then
						mapData.pane = checkPane(map, "U", tempPane, 2) 
					elseif event.yStart < event.y then
						mapData.pane = checkPane(map, "D", tempPane, 3) 
					end
				end
			elseif mapData.pane == "R" then
				if event.xStart < event.x and swipeLength > swipeLengthY and swipeLengthY < 150 then
					mapData.pane = "M"
				elseif swipeLength > 150 and swipeLengthY > 150 and swipeX < 0 then
					if event.yStart > event.y then
						mapData.pane = checkPane(map, "U", tempPane, 2) 
					elseif event.yStart < event.y then
						mapData.pane = checkPane(map, "D", tempPane, 3) 
					end
				end
			elseif mapData.pane == "U" then
				if event.yStart < event.y and swipeLength < swipeLengthY and swipeLength < 150 then
					mapData.pane = "M"
				elseif swipeLengthY > 150 and swipeLength > 150 and swipeY > 0 then
					if event.xStart < event.x then
						mapData.pane = checkPane(map, "R", tempPane, 4) 
					elseif event.xStart > event.x then
						mapData.pane = checkPane(map, "L", tempPane, 5) 
					end
				end
			elseif mapData.pane == "D" then
				if event.yStart > event.y and swipeLength < swipeLengthY and swipeLength < 150 then
					mapData.pane = "M"
				elseif swipeLengthY > 150 and swipeLength > 150 and swipeY < 0 then
					if event.xStart < event.x then
						mapData.pane = checkPane(map, "R", tempPane, 4) 
					elseif event.xStart > event.x then
						mapData.pane = checkPane(map, "L", tempPane, 5) 
					end
				end
			end

			-- debug for which way player swiped
			print("swipe to", mapData.pane)
		end
	end
end

--------------------------------------------------------------------------------
-- Tap Screen - functionality of tapping mechanic
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function tapScreen(event, miniMap, mapData, physics, gui, player) 
	-- if tapped twice, show miniMap or if showing, hide it
	if event.numTaps >= 2 then
		-- show miniMap 
		if gameData.isShowingMiniMap == false then
			-- pause physics when miniMap is shown
			physics.pause()

			-- update minimap pane images
			--miniMapMechanic.updateMiniMap(mapData.pane, miniMap, gui, player, player2)

			-- save current pane for later check
			tempPane2 = mapData.pane

			-- set miniMap display to visible
			gameData.isShowingMiniMap = true
			miniMap.alpha = 0.75

		-- else, tapped once, do funationality for miniMap if it is showing
		elseif gameData.isShowingMiniMap == true then
			-- call miniMap move function
			miniMapMechanic.moveMiniMap(miniMap, mapData, gui, event)
			
			-- start physics
			physics.start()

			-- set miniMap display to invisible
			gameData.isShowingMiniMap = false
			miniMap.alpha = 0

			-- return saved tempPane2
			return tempPane2
		end
	-- else, tapped once, do funationality for miniMap if it is showing
	else
		if gameData.isShowingMiniMap  == true then
			-- call miniMap move function
			mapData.pane = miniMapMechanic.moveMiniMap(miniMap, mapData, gui, event)
		end
	end

	-- return new MapData.pane
	return mapData.pane
	--gameData.mapData = mapData
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen,
}

return touchMechanic
--end of touchMechanic.lua