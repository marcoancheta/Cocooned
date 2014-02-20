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
	-- if switching panes, move miniMap cursor to that pane and set alpha to 0
	if tempPane ~= mapData.pane then
		--print("direction:", direction)
		miniMapMechanic.setMiniMap(miniMap, mapData.pane)
	end
end
local tempPane2
--------------------------------------------------------------------------------
-- tap mechanic
--------------------------------------------------------------------------------
function tapScreen(event, miniMap, mapData, physics, player) 
	-- if tapped twice, show miniMap or if showing, hide it
	if event.numTaps >= 2 and player.movement == "accel" then
		-- show miniMap 
		if gameData.isShowingMiniMap == false then
			tempPane2 = mapData.pane
			player.xGrav = 0
			player.yGrav = 0
			print("show", tempPane2)
			physics.pause()
			gameData.isShowingMiniMap = true
			miniMap.alpha = 0.75
		else
		--hide miniMap
			
			print("hide", tempPane2)
			physics.start()
			gameData.isShowingMiniMap = false
			miniMap.alpha = 0
			return tempPane2
		end
	else
		if gameData.isShowingMiniMap  == true then
			miniMapMechanic.moveMiniMap(miniMap, mapData, event)
		end
	end

	--[[
	if player.movement == "inWater" then
		if player.numOfTaps == 0 then
			timer.performWithDelay(500, function() player.numOfTaps=0 end)
		end
		player.numOfTaps = player.numOfTaps + event.numTaps
		if player.numOfTaps >= 5 then
			local xDirection = .5
			local yDirection = .5
			if event.x - player.imageObject.x < 0 then
				xDirection = -.5 
			end
			if event.y - player.imageObject.y < 0 then
				yDirection = -.5
			end
			player.imageObject:applyLinearImpulse(xDirection*player.curse,yDirection*player.curse,player.imageObject.x,player.imageObject.y)
			player.speedConst = 5
			player.imageObject.linearDamping = 1
			player:changeColor("white")
			accelTimer = timer.performWithDelay(500, function() player.movement = "accel" player.imageObject.linearDamping = 1 end)
			speedTmer= timer.performWithDelay(5000, function() player.speedConst = 10 end)
		end
	end

	if gameData.isShowingMiniMap then
		print("touched", event.target.name)
	end]]

	return mapData.pane
end


local touchMechanic = {
	swipeScreen = swipeScreen,
	tapScreen = tapScreen
}

return touchMechanic

--end of touch mechanic