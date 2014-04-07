--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- paneTransition.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for pane switching transitions
-- miniMap display functions
local miniMapMechanic = require("miniMap")
-- Object variables/files (objects.lua)
local objects = require("objects")
-- Load level function (loadLevel.lua)
local loadLevel = require("loadLevel")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("collisionDetection")

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local paneSheet = graphics.newImageSheet("mapdata/art/animation/snowAnimation.png", 
				 {width = 1440, height = 891, sheetContentWidth = 7200, sheetContentHeight = 4081, numFrames = 20})
local transPic

--------------------------------------------------------------------------------
-- Move Panes - changes current pane to new one
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function movePanes(tempPane, miniMap, gui, player1, player2, mapData, map)
	-- update new miniMap
	miniMapMechanic.updateMiniMap(tempPane, miniMap, gui, player1, player2)

	-- delete everything on map
	objects.destroy(mapData)
	gui.back[1]:removeSelf()
	map = nil
		
	-- Pause physics
	physics.pause()

	---------------------------------------------------
	-- Play "character" teleportation animation here --
	---------------------------------------------------
	-- load new map pane
	map = loadLevel.changePane(mapData, player1, player2, miniMap)

	-- insert objects onto map layer
	gui.back:insert(map)

	map.layer["tiles"]:insert(player1.imageObject)
	
	if player2.isActive then
		map.layer["tiles"]:insert(player2.imageObject)
	end

	-- Resume physics
	physics.start()

	-- Reassign game mechanic listeners	
	collisionDetection.changeCollision(ball, player1, mapData, gui.back[1], gui.front, physics, miniMap)
	if player2.isActive then
		collisionDetection.changeCollision(ball, player2, mapData, gui.back[1], gui.front, physics, miniMap)
	end
end

--------------------------------------------------------------------------------
-- End Transition - function that ends pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function endTransition(event)
	local params = event.source.params

	-- set sequence to stop and remove it
	transPic:setSequence("stop")
	transPic:toBack()
	transPic:removeSelf()
	
	-- switch panes
	movePanes(params.tempPane, params.miniMap, params.gui, params.player1, params.player2, params.mapData, params.map)
end

--------------------------------------------------------------------------------
-- Play Transition -- function that plays pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function playTransition(tempPane, miniMap, mapData, gui, player1, player2, map)

	-- save current pane image
	--tempPic = display.capture(gui)
	--tempPic.x, tempPic.y = 720, 432

	-- play pane switch transition and move to front
	transPic = display.newSprite(paneSheet, spriteOptions.paneSwitch)
	--transPic:scale(1.25, 1.25)
	transPic.x, transPic.y = 720, 432
	transPic:setSequence("move")
	transPic:play()
	--tempPic:toFront()
	transPic:toFront()

	-- declare direction which pane swithc transition should play
	local direction = "None"

	-- if Pane is Main, chose which direction to play transition 
	-- depending on new pane
	if tempPane == "M" then
		if mapData.pane == "R" then direction = "right"
		elseif mapData.pane == "L" then direction = "left"
		elseif mapData.pane == "U" then direction = "up"
		elseif mapData.pane == "D" then direction = "down"
		end
	elseif tempPane == "R" then
		if mapData.pane == "U" then direction = "rightup"
		elseif mapData.pane == "D" then direction = "rightdown"
		else direction = "left"
		end
	elseif tempPane == "L" then
		if mapData.pane == "U" then direction = "leftdown"
		elseif mapData.pane == "D" then direction = "leftup"
		else direction = "right"
		end
	elseif tempPane == "D" then
		if mapData.pane == "L" then direction = "rightup"
		elseif pane == "R" then direction = "leftup"
		else direction = "up"
		end
	elseif tempPane == "U" then
		if mapData.pane == "L" then direction = "rightdown"
		elseif mapData.pane == "R" then direction = "leftdown"
		else direction = "down"
		end
	end
	
	-- depending on which direction, rotate the pane switch transition
	if direction == "right" then
		transPic:scale(2,2)
		transPic.rotation = -90
	elseif direction == "left" then
		transPic:scale(2,2)
		transPic.rotation = 90
	elseif direction == "up" then
		transPic.rotation = 180
	elseif direction == "down" then
		-- do not change anything for down transition
	elseif direction == "rightdown" then
		transPic:scale(1.5,1.5)
		transPic.rotation = 45
	elseif direction == "rightup" then
		transPic:scale(1.5,1.5)
		transPic.rotation = 135
	elseif direction == "leftdown" then
		transPic:scale(1.5,1.5)
		transPic.rotation = -45
	elseif direction == "leftup" then
		transPic:scale(1.5,1.5)
		transPic.rotation = -135
	end

	-- timers for deleting pane image and ending pane switch
	local endTrans = timer.performWithDelay(1000, endTransition)
	endTrans.params = {tempPane = tempPane, 
						miniMap = miniMap, 
							gui = gui, 
						player1 = player1, 
						player2 = player2,
						mapData = mapData,  
							map = map}
end

--------------------------------------------------------------------------------
-- Delete Temp - function that deletes pane image taken before pane switch
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function deleteTemp()
	--tempPic:removeSelf()
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local paneTransition = {
	playTransition = playTransition,
	movePanes = movePanes
}

return paneTransition

-- end of paneTransition.lua