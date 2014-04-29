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
--local GA = require("plugin.gameanalytics")
	  
--------------------------------------------------------------------------------
-- Load in files/variables from other .lua's
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")
-- Load level function (loadLevel.lua)
local loadLevel = require("Loading.loadLevel")
-- Animation variables/data (animation.lua)
local animation = require("Core.animation")
-- Menu variables/objects (menu.lua)
local menu = require("Core.menu")
-- Sound files/variables (sound.lua)
local sound = require("sound")
-- Player variables/files (player.lua)
local player = require("Mechanics.player")
-- Object variables/files (objects.lua)
local objects = require("Loading.objects")
-- miniMap display functions
--local miniMapMechanic = require("Mechanics.miniMap")
-- memory checker (memory.lua)
local memory = require("memory")
-- Loading Screen (loadingScreen.lua)
local loadingScreen = require("Loading.loadingScreen")
-- Custom Camera (camera.lua)
local cameraMechanic = require("camera")

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("Mechanics.touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local accelerometer = require("Mechanics.Accelerometer")
-- Movement based on Accelerometer readings
local movement = require("Mechanics.movement")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("Mechanics.collisionDetection")
-- Pane Transitions (paneTransition.lua)
local paneTransition = require("Loading.paneTransition")
-- Cut Scene System (cutSceneSystem.lua)
local cutSceneSystem = require("Loading.cutSceneSystem")

-- Particle effect
local snow = require("Mechanics.snow")

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

--local miniMap
local map, ball
local gui
local line
local player1, player2 -- create player variables
local tempPane -- variable that holds current pane player is in for later use

local textObject = display.newText("", 600, 400, native.systemFont, 72)
		
local count = 0

local players = {}
local linePts = {}

local camera;

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
	if gameData.allowMiniMap then
		count = count + 1
		-- save temp pane for later check
		tempPane = mapData.pane

		-- call swipe mechanic and get new Pane
		--TODO: ask why player1 is passed in
		touch.swipeScreen(event, mapData, miniMap, gui.front)
		
		-- if touch ended then change map if pane is switched
		if "ended" == event.phase and mapData.pane ~= tempPane then
			-- play snow transition effect
			--TODO: does player need to be pased in?
			paneTransition.playTransition(tempPane, miniMap, mapData, gui, player1)
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
		touch.tapScreen(event, miniMap, mapData, physics, gui, player1)

		-- check if pane is different from current one, if so, switch panes
		if mapData.pane ~= tempPane and gameData.isShowingMiniMap ~= true then
			-- play snow transition effect
			paneTransition.playTransition(tempPane, miniMap, mapData, gui, player1)
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
		physicsParam = accelerometer.onAccelerate(event, player1)
		
		-- set player's X and Y gravity times the player's curse
		player1.xGrav = physicsParam.xGrav
		player1.yGrav = physicsParam.yGrav
		
		print(player1.xGrav)
		print(player1.yGrav)
	end
	
	if gameData.debugMode then
		if event.isShake then
			textObject.text = "Device Shaking!"
			textObject.x = display.contentCenterX
			textObject.y = display.contentCenterY
			textObject:setFillColor(1,0,0)
			textObject:toFront()
		else
			textObject:toBack()
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
		if player1 ~= nil then
			player1.xGrav = player1.xGrav*player1.curse
			player1.yGrav = player1.yGrav*player1.curse
			movement.moveAndAnimate(event, player1)

			if gameData.gRune == true then
				for check = 1, gui.front.numChildren do
		  			local currObject = gui.front[check]
		  			local length = string.len(currObject.name)
		  			local name = string.sub(currObject.name, 1, length - 1)
		  			if name == "switchWall" or (name == "fixedIceberg" and currObject.movement == "free") then
		  				if gameData.onIceberg == true then
			  				local velY = 0
			  				local velX = 0
			  				if player1.yGrav<0 then
			  					velY = -40
			  				elseif player1.yGrav > 0 then
			  					velY = 40
			  				end
			  				if player1.xGrav<0 then
			  					velX = -40
			  				elseif player1.xGrav > 0 then
			  					velX = 40
			  				end
	  						
	  						currObject:setLinearVelocity(velX, velY)
	  						--currObject:setLinearVelocity(player1.xGrav*player1.speedConst, player1.yGrav*player1.speedConst)
	  					else
	  						currObject:setLinearVelocity(0, 0)
	  					end

		  			end
	  			end
	  		end

			--[[
			local ballPt = {}
			ballPt.x = player1.imageObject.x
			ballPt.y = player1.imageObject.y
					
			table.insert(linePts, ballPt);
			trails.drawTrail(event)
			--table.remove(linePts, 1);
			]]--
		end
	end
end

--------------------------------------------------------------------------------
-- Reset mapData to default settings
--------------------------------------------------------------------------------
local function mapDataDefault()
	mapData.levelNum = 1
	mapData.pane = "M"
	mapData.version = 0
end

--------------------------------------------------------------------------------
-- Add gameLoop game listeners
--------------------------------------------------------------------------------
local function addGameLoopListeners(gui)
	-- Add object listeners
	gui.back:addEventListener("touch", swipeMechanics)
	gui.back:addEventListener("tap", tapMechanic)
	Runtime:addEventListener("accelerometer", controlMovement)
	Runtime:addEventListener("enterFrame", speedUp)
end

--------------------------------------------------------------------------------
-- Remove gameLoop game listeners
--------------------------------------------------------------------------------
local function removeGameLoopListeners(gui)
	-- Remove object listeners
	gui.back:removeEventListener("touch", swipeMechanics)
	gui.back:removeEventListener("tap", tapMechanic)
	Runtime:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", speedUp)
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function loadMap(mapData)
	-- Turn off main menu boolean to turn off snow particles
	gameData.inMainMenu = false
	sound.stopChannel3()
	sound.loadGameSounds()
	
	-- Start physics
	physics.start()
	physics.setScale(45)
	
	-- Initialize player(s)
	player1 = player.create()
	system.setAccelerometerInterval(30)

	-- Create player/ball object to map
	ball = display.newSprite(sheetOptions.playerSheet, spriteOptions.player)

	-- set name and animation sequence for ball
	ball.name = "player"
	ball:setSequence("move")

	-- add physics to ball
	physics.addBody(ball, {radius = 38, bounce = .25})
	physics.setGravity(0,0)
	ball.linearDamping = 1.25
	ball.density = .3
	
	player1.imageObject = ball
		
	-- Load in map
	gui, miniMap = loadLevel.createLevel(mapData, player1)
	-- Start mechanics
	collisionDetection.createCollisionDetection(player1.imageObject, player1, mapData, gui, gui.back[1])
	-- Create in game options button
	menu.ingameOptionsbutton(event, gui)
	-- Add game event listeners
	addGameLoopListeners(gui)
	sound.stop()
	sound.playBGM(sound.backgroundMusic)
	
	snow.levelSnow(mapData)
	
	return player1
end


--------------------------------------------------------------------------------
-- Clean - clean level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function clean(event)
	-- stop physics
	physics.stop()
	-- clean out currently loaded sound files
	sound.soundClean()	
	-- remove all eventListeners
	removeGameLoopListeners(gui)
	-- clear collision detections
	collisionDetection.destroyCollision(player1.imageObject)

	player1:resetRune()

	--[[
	if linePts then
		linePts = nil
		linePts = {}
	end
	]]--
	
	-- destroy player instance
	player1.imageObject:removeSelf()
	player1.imageObject = nil
	
	ball:removeSelf()
	ball = nil
	
	--miniMap:removeSelf()
	--miniMap = nil
		
	gui:removeSelf()
	gui = nil
		
	playerSheet = nil

	--TODO: move player 2 sheet into gameloop?
	-- call objects-destroy
	objects.destroy(mapData)
end

--------------------------------------------------------------------------------
-- Core Game Loop - Runtime:addEventListener called in main.lua
--------------------------------------------------------------------------------
-- Updated by: Derrick 
--------------------------------------------------------------------------------
local function gameLoopEvents(event)
	-- Run monitorMemory from open to close.
	if gameData.debugMode then
		memory.monitorMem()
		memory.inWater()
		physics.setDrawMode("hybrid")
	end

	-- Activate snow particle effect if in main menu
	if gameData.inMainMenu then
		snow.makeSnow(event)
	end
		
	--[[	
	if mapData.levelNum == "LS" then
		if gui.back[1] then
			-- Set Camera to Ball
			gui.back[1].setCameraFocus(ball)
			gui.back[1].setTrackingLevel(0.1)
		end
	end
	]]--
		
	---------------------------
	--[[ START LVL SELECTOR]]--
	if gameData.selectLevel then
		mapData.levelNum = "LS"
		mapData.pane = "LS"
		
		loadMap(mapData)		
		-- Re-evaluate gameData booleans
		gameData.selectLevel = false
	end
	
	-----------------------
	--[[ START GAMEPLAY]]--
	if gameData.gameStart then
		print("start game")
		clean(event)
		mapData = gameData.mapData
		loadMap(mapData)
		--cutSceneSystem.cutScene("1", gui)
		
		-- Re-evaluate gameData booleans
		gameData.allowPaneSwitch = true
		gameData.allowMiniMap = true
		gameData.gameStart = false
	end
		
	----------------------
	--[[ END GAMEPLAY ]]--
	if gameData.gameEnd then
		--sound.soundClean()
		clean(event)	
		-- set booleans
		gameData.menuOn = true
		gameData.gameEnd = false
	end
	
	-----------------------
	--[[ Restart level ]]--
	if gameData.levelRestart == true then
		-- Clean
		clean(event)
		-- Reset current pane to middle
		mapData.pane = "M"
		-- Apply booleans
		gameData.gameStart = true
		gameData.levelRestart = false
	end
		
	------------------------
	--[[ LEVEL COMPLETE ]]--
	if gameData.levelComplete then
		-- clean
		loadingScreen.deleteLoading()
		clean(event)
		-- apply booleans
		gameData.selectLevel = true
		gameData.levelComplete = false
	end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		-- Go to main menu
		menu.mainMenu(event)
		mapDataDefault()
		-- Re-evaluate gameData booleans
		gameData.inMainMenu = true
		gameData.menuOn = false
	end
	
	----------------------
	--[[ OPTIONS MENU ]]--	
	if gameData.inOptions then
		sound.stopChannel3()
		-- Go to options menu
		menu.options(event)																																																																						
		-- Re-evaluate gameData booleans
		gameData.inMainMenu = false
		gameData.inOptions = false		
	end
	
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	if gameData.inGameOptions then
		physics.pause()
		-- Go to in-game option menu
		menu.ingameMenu(event, player1, player2, gui)
		-- Remove object listeners
		removeGameLoopListeners(gui)
		-- Re-evaluate gameData booleans
		gameData.allowMiniMap = false
		gameData.inGameOptions = false
	end
	
	---------------------
	--[[ RESUME GAME ]]--		
	if gameData.resumeGame then
		-- Restart physics
		physics.start()		
		-- Add object listeners
		addGameLoopListeners(gui)		
		-- Re-evaluate gameData booleans
		gameData.allowMiniMap = true
		gameData.resumeGame = false
	end
end

local gameLoop = {
	gameLoopEvents = gameLoopEvents
}

return gameLoop