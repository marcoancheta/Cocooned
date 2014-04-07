--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameLoop.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Localize (Load in files) - [System Files]
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local require = require
local math_abs = math.abs
local physics = require("physics")
local dusk = require("Dusk.Dusk")
--local GA = require("plugin.gameanalytics")
	  
--------------------------------------------------------------------------------
-- Load in files/variables from other .lua's
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- Load level function (loadLevel.lua)
local loadLevel = require("loadLevel")
-- Animation variables/data (animation.lua)
local animation = require("animation")
-- Menu variables/objects (menu.lua)
local menu = require("menu")
-- Sound files/variables (sound.lua)
local sound = require("sound")
-- Player variables/files (player.lua)
local player = require("player")
-- Object variables/files (objects.lua)
local objects = require("objects")
-- miniMap display functions
local miniMapMechanic = require("miniMap")
-- memory checker (memory.lua)
local memory = require("memory")

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local movementMechanic = require("Accelerometer")
-- Movement based on Accelerometer readings
local movement = require("movement")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("collisionDetection")
-- Spirits mechanics (spirits.lua)
local spirits = require("spirits")
-- Pane Transitions (paneTransition.lua)
local paneTransition = require("paneTransition")


--------------------------------------------------------------------------------
-- Local/Global Variables
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------

-- Initialize ball
local ball
local mapPanes
local t = 1
local timeCheck = 1
local timeCount = 0

-- Initialize map data
local mapData = {
	levelNum = 1,
	pane = "M",
	version = 0
}

local miniMap
local map, ball
local gui
local player1, player2 -- create player variables
local tempPane -- variable that holds current pane player is in for later use


--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
------- tapMechanics
------- speedUp
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Swipe Mechanics - function that is called when player swipes
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function swipeMechanics(event)

	if player1.movement == "accel" and player2.movement == "accel" then
		-- save temp pane for later check
		tempPane = mapData.pane

		-- call swipe mechanic and get new Pane
		--TODO: ask why player1 is passed in
		touch.swipeScreen(event, mapData, player1, miniMap, gui.back[1])
		
		-- if touch ended then change map if pane is switched
		if "ended" == event.phase and mapData.pane ~= tempPane then
			-- play snow transition effect
			--TODO: does player need to be pased in?
			paneTransition.playTransition(tempPane, miniMap, mapData, gui, player1, player2, map)
		end

	end
end

--------------------------------------------------------------------------------
-- Tap Mechanics - function that is called when player taps
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function tapMechanic(event)
	if gameData.allowMiniMap then

		-- save current pane for later use
		tempPane = mapData.pane

		-- call function for tap screen
		touch.tapScreen(event, miniMap, mapData, physics, gui, player1, player2, map)

		-- check if pane is different from current one, if so, switch panes
		if mapData.pane ~= tempPane and gameData.isShowingMiniMap ~= true then
			-- play snow transition effect
			paneTransition.playTransition(tempPane, miniMap, mapData, gui, player1, player2, map)
		end
	end
end

--------------------------------------------------------------------------------
-- Control Mechanics - controls movement for player
--------------------------------------------------------------------------------
-- Updated by: Andrew moved curse to speedUp so we can use the player's physics params
--------------------------------------------------------------------------------
local function controlMovement(event) 
	
	-- if miniMap isn't showing, move player
	if gameData.isShowingMiniMap == false and gameData.gameEnd == false then
		-- call accelerometer to get data
		physicsParam = movementMechanic.onAccelerate(event, player1, player2, gui.back[1])
	
		-- set player's X and Y gravity times the player's curse
		player1.xGrav = physicsParam.xGrav
		player1.yGrav = physicsParam.yGrav
		if player2.isActive then
			player2.xGrav = physicsParam.xGrav
			player2.yGrav = physicsParam.yGrav
		end
	end
end

--------------------------------------------------------------------------------
-- Speed Up - gives momentum to player movement
--------------------------------------------------------------------------------
-- Updated by: Andrew uncommented move wall code
--------------------------------------------------------------------------------
local function speedUp(event)
	if gameData.isShowingMiniMap == false then
		if gameData.greenG == true then
			for check = 1, map.layer["tiles"].numChildren do
			currObject = map.layer["tiles"][check]
				if currObject.accel == true then
					local vel = 40
					if player1.yGrav<0 then
						vel = -40
					elseif player1.yGrav == 0 then
						vel = 0
					end
					--print(string.sub(currObject.name,1,10))
					if string.sub(currObject.name,1,10) == "switchWall"then
						currObject.x = currObject.defX
						currObject:setLinearVelocity(0, vel)
					end
				end
			end
		end
		
		if player1 ~= nil then
			player1.xGrav = player1.xGrav*player1.curse
			player1.yGrav = player1.yGrav*player1.curse
			
			if player2.isActive then
					player2.xGrav = player2.xGrav*player2.curse
					player2.yGrav = player2.yGrav*player2.curse
					--print(player2.imageObject)
					movement.moveAndAnimate(event, player2)
			end
			
			movement.moveAndAnimate(event, player1)
		end
	end
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function loadMap(mapData)
	-- Start physics
	physics.start()
	
	--TODO: move player creation into create level?
	-- pause physics
	physics.pause()
	physics.setScale(45)
	-- Initialize player(s)
	player1 = player.create()
	system.setAccelerometerInterval(30)

	-- Create player sprite sheet
	local playerSheet = graphics.newImageSheet("mapdata/art/animation/AnimationRollSprite.png", 
			   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	
	-- Create player/ball object to map
	player1.imageObject = display.newSprite(playerSheet, spriteOptions.player)
	ball = player1.imageObject

	-- set name and animation sequence for ball
	ball.name = "player"
	ball:setSequence("move")

	-- add physics to ball
	physics.addBody(ball, {radius = 38, bounce = .25})
	physics.setGravity(0,0)
	ball.linearDamping = 1.25
	ball.density = .3

	-- Load in map
	gui, miniMap, player2Params, map = loadLevel.createLevel(mapData, player1, player2)
	
	-- fix offset, because Dusk Engine is offsetting during render
	gui.x = gui.x
	gui.y = gui.y
	
	--print("params=",player2Params.isActive, player2Params.x, player2Params.y)
	if player2Params.isActive == true then
		player2 = player.create()
		-- Create player sprite sheet
		local playerSheet2 = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite2.png", 
			   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
		
		-- Create player/ball object to map
		player2.imageObject = display.newSprite(playerSheet2, spriteOptions.player2)
		ball2 = player2.imageObject
		--print(player2.imageObject)
		-- set name and animation sequence for ball
		ball2.name = "player2"
		ball2:setSequence("move")
		player2.isActive = true
		player2.imageObject.x, player2.imageObject.y = player2Params.x, player2Params.y
		map.layer["tiles"]:insert(player2.imageObject)
		-- add physics to secondball
		physics.addBody(player2.imageObject, {radius = 38, bounce = .25})
		player2.imageObject.linearDamping = 1.25
		player2.imageObject.density = .3
	else
		player2 ={
			isActive = false,
			movement = "accel"
		}
	end

	--start physics when everything is finished loading
	physics.start()
	
	-- Start mechanics
	collisionDetection.createCollisionDetection(player1.imageObject, player1, mapData, gui.back[1], gui.front, physics, miniMap)
	
	if player2.isActive then
		collisionDetection.createCollisionDetection(player2.imageObject, player2, mapData, gui.back[1], gui.front,physics, miniMap)
	end
		
	map:addEventListener("touch", swipeMechanics)
	map:addEventListener("tap", tapMechanic)
	Runtime:addEventListener("accelerometer", controlMovement)
	Runtime:addEventListener("enterFrame", speedUp)
		
	menu.ingameOptionsbutton(event, map)
end

local function clean(event)
	-- remove all eventListeners
	map:removeEventListener("touch", swipeMechanics)
	map:removeEventListener("tap", tapMechanic)
	ball:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", speedUp)
		
	collisionDetection.destroyCollision(player1.imageObject)
		
	if player2.isActive == true then
		collisionDetection.destroyCollision(player2.imageObject)
		player2.imageObject:removeSelf()
		player2.imageObject = nil
		player2:destroy()
		player2 = nil
	end
		
	-- destroy and remove all data
	map:removeSelf()
	map = nil
	
	ball:removeSelf()
	ball = nil
	
	display.remove(gui)
	gui = nil
	
	miniMap:removeSelf()
	miniMap = nil

	-- destroy player instance
	player1:destroy()
	player1 = nil
	playerSheet = nil
			
	--TODO: move player 2 sheet into gameloop?
	-- call objects-destroy
	objects.destroy(mapData)

	-- stop physics
	physics.stop()
end

--------------------------------------------------------------------------------
-- Core Game Loop
--------------------------------------------------------------------------------
-- Updated by: Marco - added selectLevel.clean in gameStart if statement 
--------------------------------------------------------------------------------
local function gameLoop(event)
	-- Run monitorMemory from open to close.
	memory.monitorMem()
				
	if mapData.levelNum == "LS" then
		-- Set Camera to Ball
		map.setCameraFocus(ball)
		map.setTrackingLevel(0.1)
	end
	
	---------------------------------
	--[[ START LVL SELECTOR LOOP ]]--
	-- If select level do:
	if gameData.selectLevel then
		--selectLevel.selectLoop(event)	
		mapData.levelNum = "LS"
		mapData.pane = "LS"
		
		loadMap(mapData)
				
		-- Re-evaluate gameData booleans	
		gameData.selectLevel = false
	end
	
	-----------------------------
	--[[ START GAMEPLAY LOOP ]]--
	-- If game has started do:
	if gameData.gameStart then
		print("start game")
		
		mapData = gameData.mapData
		loadMap(mapData)
				
		-- Re-evaluate gameData booleans
		gameData.menuOn = false
		gameData.ingame = true
		gameData.allowPaneSwitch = true
		gameData.allowMiniMap = true
		gameData.showMiniMap = true
		gameData.gameStart = false
	end

	-----------------------------
	--[[ END GAMEPLAY LOOP ]]--
	-- If game has ended do:
	if gameData.gameEnd then
		clean(event)
	
		-- set booleans
		gameData.gameEnd = false
		
		if gameData.menuOn ~= true then
			gameData.selectLevel = true
		end
	elseif gameData.levelRestart == true then
		clean(event)
		
		-- set booleans
		gameData.levelRestart = false
		gameData.gameStart = true

		-- reset pane to middle pane
		mapData.pane = 'M'
	end
	
	----------------------
	--[[ IN-GAME LOOP ]]--
	-- If ingame has started do:
	--if gameData.ingame then
	
		--[[
		local time = os.time() 
		if ( time ~= timeCheck ) then
  			print("Time:", time)
  			timeCount = timeCount + 1
  			timeCheck = time
  			if timeCount % 5 == 1 then 
  				activateWind = true
				--player:changeColor('white')
  				print(activateWind)
  			elseif timeCount % 5 ~= 1 then
  				activateWind = false
  			end
		end
		]]--
	--end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		-- Go to main menu
		menu.MainMenu(event)
		
		-- Start BGM
		--sound.playBGM(event, sound.gameSound)
		
		-- reset mapData variables
		if mapData.pane ~= "M" then
			mapData.pane = "M"
			mapData.version = 0
		end

		-- Re-evaluate gameData booleans
		gameData.menuOn = false
	----------------------
	--[[ OPTIONS MENU ]]--	
	elseif gameData.inOptions then
		-- If in options do:
		-- Go to options menu
		menu.Options(event)
		--menu.soundOptions(event)
																																																																						
		-- Re-evaluate gameData booleans
		gameData.inOptions = false		
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	elseif gameData.inGameOptions then
		-- If in game options do:
		-- Go to in-game option menu
		menu.ingameMenu(event, player1, player2, gui)
		
		-- Remove object listeners
		gui.back:removeEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
		gui.back:addEventListener("tap", tapMechanic)
		Runtime:removeEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)

		-- Re-evaluate gameData booleans
		gameData.ingame = false
		gameData.allowMiniMap = false
		gameData.showMiniMap = false
		gameData.isShowingMiniMap = false
		gameData.inGameOptions = false		
	--------------------------
	--[[ RESUME GAME LOOP ]]--		
	elseif gameData.resumeGame then 
		-- If resumeGame from game options then do:
		
		-- Re-add in game options button
		menu.ingameOptionsbutton(event, map)

		-- Add object listeners
		map:addEventListener("touch", swipeMechanics)
		map:addEventListener("tap", tapMechanic)
		Runtime:addEventListener("accelerometer", controlMovement)
		Runtime:addEventListener("enterFrame", speedUp)
		
		-- Re-evaluate gameData booleans
		gameData.inGameOptions = false
		gameData.allowMiniMap = true
		gameData.showMiniMap = true
		gameData.resumeGame = false
	end	
end

--------------------------------------------------------------------------------
-- Call gameLoop && menuLoop every 30 fps
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
Runtime:addEventListener("enterFrame", gameLoop)
