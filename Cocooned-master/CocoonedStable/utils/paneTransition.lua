--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- paneTransition.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for pane switching transitions
-- miniMap display functions
local miniMapMechanic = require("Mechanics.miniMap")
-- Object variables/files (objects.lua)
local objects = require("Objects.objects")
-- Load level function (loadLevel.lua)
local loadLevel = require("Loading.loadLevel")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("Mechanics.collisionDetection")
-- Generate Objects (generateObjects.lua)
local generate = require("Objects.generateObjects")
local snow = require("utils.snow")
local animation = require("Core.animation")
local gameData = require("Core.gameData")
-- Generate sound
local sound = require("sound")
local waterCol = require("Objects.collision.waterCollision")
local uMath = require("utils.utilMath")

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local paneSheet
local transPic = display.newSprite(animation.sheetOptions.paneSheet, animation.spriteOptions.paneSwitch)

--------------------------------------------------------------------------------
-- turnCollOn - re-enable collision
--------------------------------------------------------------------------------
local function turnCollOn() 
	gameData.collOn = true 
end

--------------------------------------------------------------------------------
-- End Transition - function that ends pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function endTransition(event)
	-- set sequence to stop and remove it
	if transPic then
		transPic:setSequence("stop")
		transPic:removeSelf()
		transPic = nil
	end
	
	gameData.allowTouch = true
	gameData.allowPaneSwitch = true
	print("gameData.allowPaneSwitch", gameData.allowPaneSwitch)
end

--------------------------------------------------------------------------------
-- pWater(event) 
--------------------------------------------------------------------------------
local function pWater(event)
	local params = event.source.params
	-- check if the player has swiped into water
	local playerPos = params.player1.imageObject
	local locationFound = false
	local degree = 0
	local distanceCheck = 70
	local inWater = false
	
	--use raycasting to see the players surroundings
	while locationFound == false do
		for i = 1, 36 do
			local x = playerPos.x + (distanceCheck * math.cos(degree * (math.pi/180)))
			local y = playerPos.y + (distanceCheck * math.sin(degree * (math.pi/180)))
			local hits = physics.rayCast(playerPos.x, playerPos.y, x, y, "sorted")

			if (hits) then
				for i,v in ipairs(hits)	do 
					if v.object ~= nil then
						if v.object.name == "water" then
							locationFound = true
							inWater = true
							break
						elseif v.object.name == "background" then
							locationFound = true
							break
						end
					end
				end
			end
	
			degree = degree + 10
		end	

		if ( distanceCheck > 300 ) then
			locationFound = true
			inWater = false
		end 
		distanceCheck = distanceCheck + 30
		
		--if ( distanceCheck > 300 ) then
		--	print("no water or shore found, you should be fine")
		--	locationFound = true
		--	inWater = false
		--end --else
			--distanceCheck = distanceCheck + 30
			--pWater(event)
		--end
	end

	if inWater then
		gameData.inWater = true
		gameData.onLand = false
		-- Transition player's alpha to 0
		params.player1.sinkTrans = transition.to(params.player1.imageObject, {time=3000, alpha=0})
		-- save this last point
		savePoint = display.newCircle(playerPos.x, playerPos.y , 38)
		savePoint.alpha = 0
		savePoint.name = "paneSavePoint"
		-- set player variables for later calculations
		params.player1.lastSavePoint = savePoint
		params.player1.lastPositionX = savePoint.x
		params.player1.lastPositionY = savePoint.y
		params.player1.lastSavePoint.pane = params.tempPane
		params.player1.miniMap = params.miniMap
		params.player1.lastPositionSaved = true
		-- start the death timer
		params.player1:startDeathTimer(params.mapData, params.gui)
	end
end

local function runReload(event)
	local params = event.source.params
	---------------------------------------------------
	-- Play "character" teleportation animation here --
	---------------------------------------------------
	-- load new map pane
	--params.gui = loadLevel.changePane(params.gui, params.mapData, params.player1, params.miniMap)
	-- Reassign game mechanic listeners	
	--params.gui.front:insert(params.player1.imageObject)
	collisionDetection.changeCollision(params.player1, params.mapData, params.gui, params.map)
	-- delay collision detection for a little while
	local collTimer = timer.performWithDelay(100, turnCollOn)
	-- check if the player has swiped into water
	pWater(event)
	-- Change alpha back to 1 if player was invisible
	if params.player1.imageObject.alpha == 0 then
		params.player1.imageObject.alpha = 1
	end
	-- Run end transition event
	endTransition(event)
end

--------------------------------------------------------------------------------
-- Move Panes - changes current pane to new one
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function movePanes(event)
	local params = event.source.params

	-- update new miniMap
	--miniMapMechanic.updateMiniMap(params.tempPane, params.miniMap, params.gui, params.player1)
	--print("nameB: " .. params.gui.back.numChildren)
	--print("nameM: " .. params.gui.middle.numChildren)


	-- delete everything on map
	objects.destroy(params.mapData)
	
	if params.gui then
		if params.gui.back ~= nil then
			for i = params.gui.back.numChildren,1, -1 do
				print("destroyed")
				params.gui.back[i]:removeSelf()
				params.gui.back[i] = nil
			end
		end
		if params.gui.middle ~= nil then
			for i = params.gui.middle.numChildren, 1, -1 do
				if params.gui.middle[i].name ~= "shadowCirc" then
					params.gui.middle[i]:removeSelf()
					params.gui.middle[i] = nil
				end
			end
		end
		if params.gui.front ~= nil then
			for i = params.gui.front.numChildren, 1, -1 do
				
				if params.gui.front[i].name ~= "player" and params.gui.front[i].name ~= "auraParticle" and 
				params.gui.front[i].name ~= "timer" and params.gui.front[i].name ~= "inGameOptionsBTN" then
					params.gui.front[i]:removeSelf()
					params.gui.front[i] = nil
				end
			end
		end
	end
	
	-- Clean snow on screen
	snow.meltSnow()
	-- Re-initialize snow
	snow.new()
	-- Re-initialize player values
	if params.player1.small == true then
		params.player1:unshrink()
		params.player1.small = false
	end
	if params.player1.breakable == true then
		params.player1.breakable = false
	end
	if params.player1.large == true then
		params.player1:shrink()	
		params.player1.large = false	
	end
	-- load new map pane
	params.gui = loadLevel.changePane(params.gui, params.mapData, params.player1, params.miniMap)
	local delayer = timer.performWithDelay(100, runReload)
	delayer.params = params
	
	--[[
	---------------------------------------------------
	-- Play "character" teleportation animation here --
	---------------------------------------------------
	-- load new map pane
	params.gui = loadLevel.changePane(params.gui, params.mapData, params.player1, params.miniMap)
	print("player Check 8 " .. params.player1.imageObject.x)
	-- Reassign game mechanic listeners	
	--params.gui.front:insert(params.player1.imageObject)
	collisionDetection.changeCollision(params.player1, params.mapData, params.gui, params.map)
	print("player Check 9 " .. params.player1.imageObject.x)
	-- delay collision detection for a little while
	local collTimer = timer.performWithDelay(100, turnCollOn)
	-- check if the player has swiped into water
	pWater(event)
	-- Change alpha back to 1 if player was invisible
	if params.player1.imageObject.alpha == 0 then
		params.player1.imageObject.alpha = 1
	end
	-- Run end transition event
	endTransition(event)
		]]--
	--[[
	-- check if the player has swiped into water
	local playerPos = params.player1.imageObject
	local locationFound = false
	local degree = 0
	local distanceCheck = 70
	local inWater = false
	
	--use raycasting to see the players surroundings
	while locationFound == false do
		for i = 1, 36 do
			local x = playerPos.x + (distanceCheck * math.cos(degree * (math.pi/180)))
			local y = playerPos.y + (distanceCheck * math.sin(degree * (math.pi/180)))
			local hits = physics.rayCast(playerPos.x, playerPos.y, x, y, "sorted")

			if (hits) then
				for i,v in ipairs(hits)	do 
					if v.object ~= nil then
						if v.object.name == "water" then
							locationFound = true
							inWater = true
							break
						elseif v.object.name == "background" then
							locationFound = true
							break
						end
					end
				end
			end
				
			degree = degree + 10
		end
					
		if ( distanceCheck > 300 ) then
			print("no water or shore found, you should be fine")
			locationFound = true
			inWater = false
		end
			
		distanceCheck = distanceCheck + 30
	end

	-- this calc doesnt work for some reason...
	-- local nameCheck = {"water", "background"}
	-- local paneSwitchCheck = uMath.rayCastCircle(params.player1.imageObject, nil, 50, 300, nameCheck)
	-- print("paneSwitchCheck " .. paneSwitchCheck.numChildren)
	-- for i = 1, paneSwitchCheck.numChildren do
	-- 	print("Found shore at " .. paneSwitchCheck[i].name .. " : " .. paneSwitchCheck[i].x .. ", " .. paneSwitchCheck[i].y)
	-- end

	if inWater then
		gameData.inWater = true
		gameData.onLand = false
		
		-- Transition player's alpha to 0
		params.player1.sinkTrans = transition.to(params.player1.imageObject, {time=3000, alpha=0})
		
		-- save this last point
		savePoint = display.newCircle(playerPos.x, playerPos.y , 38)
		savePoint.alpha = 0
		savePoint.name = "paneSavePoint"
			
		-- set player variables for later calculations
		params.player1.lastSavePoint = savePoint
		params.player1.lastPositionX = savePoint.x
		params.player1.lastPositionY = savePoint.y
		params.player1.lastSavePoint.pane = params.tempPane
		params.player1.miniMap = params.miniMap
		params.player1.lastPositionSaved = true

		-- start the death timer
		params.player1:startDeathTimer(params.mapData, params.gui)
	--else
		-- print("IM ON LAND!!!")
		-- else the player is safe and on land
	end
	]]--
	--end
end

--------------------------------------------------------------------------------
-- Play Transition -- function that plays pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function playTransition(tempPane, miniMap, mapData, gui, player1)
	gameData.allowPaneSwitch = false
	gameData.allowTouch = false
	gameData.collOn = false
	
	sound.stopChannel(1)
	sound.playSound(sound.soundEffects[3])
	
	if transPic then
		transPic:setSequence("stop")
		transPic:removeSelf()
		transPic = nil
	end
	
	print("playing transition")
	-- play pane switch transition and move to front
	if transPic == nil then
		transPic = display.newSprite(animation.sheetOptions.paneSheet, animation.spriteOptions.paneSwitch)
	end
	--transPic:scale(1.25, 1.25)
	transPic.x, transPic.y = generate.tilesToPixels(21, 10)
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
		transPic.rotation = 90
	elseif direction == "left" then
		transPic:scale(2,2)
		transPic.rotation = -90
	elseif direction == "up" then
		transPic:scale(1.5,1.5)
	elseif direction == "down" then
		transPic.rotation = 180
		transPic:scale(1.5,1.5)
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
	--local endTrans = timer.performWithDelay(1000, endTransition)
		
	local moveTrans = timer.performWithDelay(600, movePanes)
		  moveTrans.params = { tempPane = tempPane, 
								miniMap = miniMap, 
									gui = gui, 
								player1 = player1, 
								mapData = mapData  }
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