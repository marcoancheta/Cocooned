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
local transPic
local paneSheet

--------------------------------------------------------------------------------
-- Move Panes - changes current pane to new one
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function movePanes(event)
	local params = event.source.params

	-- update new miniMap
	miniMapMechanic.updateMiniMap(params.tempPane, params.miniMap, params.gui, params.player1, params.player2)

	-- delete everything on map
	objects.destroy(params.mapData)
	params.map = nil

	---------------------------------------------------
	-- Play "character" teleportation animation here --
	---------------------------------------------------
	-- load new map pane
	params.map = loadLevel.changePane(params.mapData, params.player1, params.player2, params.miniMap)

	-- insert objects onto map layer
	params.gui.back:insert(params.map)

	print(ball.name)
	-- Reassign game mechanic listeners	
	params.map:insert(params.player1.imageObject)
	collisionDetection.changeCollision(params.player1, params.mapData, params.map)
	
	if params.player2.isActive then
		params.map.layer["tiles"]:insert(params.player2.imageObject)
		collisionDetection.changeCollision(params.player2, params.mapData, params.map)
	end
end

--------------------------------------------------------------------------------
-- End Transition - function that ends pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function endTransition(event)
	-- set sequence to stop and remove it
	transPic:setSequence("stop")
	transPic:removeSelf()
	transPic = nil
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
	
	--[[
	print("playing transition")
	-- play pane switch transition and move to front
	transPic = display.newSprite(sheetOptions.paneSheet, spriteOptions.paneSwitch)
	--transPic:scale(1.25, 1.25)
	transPic.x, transPic.y = map.tilesToPixels(21, 10)
	transPic:setSequence("move")
	transPic:play()
	

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
	]]--
	
	local moveTrans = timer.performWithDelay(400, movePanes)
	moveTrans.params = {tempPane = tempPane, 
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
--local function deleteTemp()
	--tempPic:removeSelf()
--end

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