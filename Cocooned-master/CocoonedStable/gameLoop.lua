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
local objects = require("Objects.objects")
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
local paneTransition = require("utils.paneTransition")
-- Cut Scene System (cutSceneSystem.lua)
local cutSceneSystem = require("Loading.cutSceneSystem")
-- Player inventory
local inventory = require("Mechanics.inventoryMechanic")
--Array that holds all switch wall and free icebergs
local accelObjects = require("Objects.accelerometerObjects")
-- Timer
local gameTimer = require("utils.timer")
-- Particle effect
local snow = require("utils.snow")
-- generator for objects (generateObjects.lua)
local generate = require("Objects.generateObjects")
-- Win screen loop
local win = require("Core.win")
-- High score
local highScore = require("Core.highScore")
-- Font
local font = require("utils.font")

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
local  physicsParam

-- Initialize map data
local mapData = {
	world = "A",
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


local textObject = display.newText("", 600, 400, font.TEACHERA, 72)

		
local count = 0

local players = {}
local linePts = {}

local camera;
local groupObj;
local shadowCircle;

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
	if gameData.debugMode then
		local tilesX, tilesY = generate.pixelsToTiles(event.x, event.y)
		print("Player Swipe Positions:", "x=" .. tilesX, "y=" .. tilesY)
	end

	if gameData.allowPaneSwitch then
		count = count + 1
		-- save temp pane for later check
		tempPane = mapData.pane

		-- call swipe mechanic and get new Pane
		touch.swipeScreen(event, mapData, miniMap, gui.front)
		
		-- if touch ended then change map if pane is switched
		if "ended" == event.phase and mapData.pane ~= tempPane then
			-- play snow transition effect
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
	if gameData.debugMode then
		local tilesX, tilesY = generate.pixelsToTiles(event.x, event.y)
		print("Tap position:",  "x = " .. tilesX, "y= " .. tilesY)
	end

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
		for i = 1, gui.playerCount do
			-- call accelerometer to get data
			physicsParam = accelerometer.onAccelerate(event, players[i])
			
			-- set player's X and Y gravity times the player's curse
			players[i].xGrav = physicsParam.xGrav
			players[i].yGrav = physicsParam.yGrav
			
			--[[if gameData.debugMode then
				print("players[i].xGrav", players[i].xGrav)
				print("players[i].yGrav", players[i].yGrav)
			end]]--
		end
		
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

		--[[
		accelValueX.text = string.sub(tostring(physicsParam.xGrav),1,4)
		accelValueX.x = display.contentCenterX
		accelValueX.y = 10
		accelValueX:setFillColor(1,0,0)
		accelValueX:toFront()
		accelValueY.text = string.sub(tostring(physicsParam.yGrav),1,4)
		accelValueY.x = display.contentCenterX
		accelValueY.y = 60
		accelValueY:setFillColor(1,0,0)
		accelValueY:toFront()
		]]--
	end
end

--------------------------------------------------------------------------------
-- Speed Up - gives momentum to player movement
--------------------------------------------------------------------------------
-- Updated by: Andrew uncommented move wall code
--------------------------------------------------------------------------------
local function speedUp(event)
	if gameData.isShowingMiniMap == false then

		for i = 1, gui.playerCount do
			if players[i] ~= nil then
			players[i].xGrav = players[i].xGrav*players[i].curse
			players[i].yGrav = players[i].yGrav*players[i].curse
			movement.moveAndAnimate(event, players[i], gui.middle)
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
end

--------------------------------------------------------------------------------
-- Reset mapData to default settings
--------------------------------------------------------------------------------
local function mapDataDefault()
	mapData.world = gameData.mapData.world
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
	if gui then
		gui.back:removeEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
	end
	Runtime:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", speedUp)
end


local function startPhys(event)
	physics.start()
	player1.curse = 1
	player2.curse = 1
end
--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function loadMap(mapData)
	snow.meltSnow()
	
	-- Start physics
	physics.start()
	physics.setScale(45)
	
	-- Initialize player(s)
	player1 = player.create()
	system.setAccelerometerInterval(30)
	player2 = player.create()
	table.insert(players, 1, player1)
	table.insert(players, 2, player2)

	-- Create player/ball object to map
	ball = display.newSprite(animation.sheetOptions.playerSheet, animation.spriteOptions.player)
	ball2 = display.newSprite(animation.sheetOptions.playerSheet, animation.spriteOptions.player)

	-- set name and animation sequence for ball
	ball.name = "player"
	ball:setSequence("move")
	ball2.name = "player"
	ball:setSequence("move")

	-- add physics to ball
	physics.setGravity(0,0)
	physics.addBody(ball, {radius = 38, bounce = .25})
	ball.linearDamping = 1.25
	ball.density = .3
	physics.addBody(ball2, {radius = 38, bounce = .25})
	ball2.linearDamping = 1.25
	ball2.density = .3
	
	player1.imageObject = ball
	player2.imageObject = ball2
		
	-- Load in map
	gui, miniMap, shadowCircle = loadLevel.createLevel(mapData, players)
	-- Start mechanics
	for i = 1, gui.playerCount do
		collisionDetection.createCollisionDetection(players[i].imageObject, player1, mapData, gui, gui.back[1])
	end

	if gui.playerCount == 1 then
		ball2:removeSelf()
		player2.imageObject:removeSelf()
		player2.imageObject = nil
		ball2:removeSelf()
		ball2 = nil
	end

	-- Create in game options button
	menu.ingameOptionsbutton(event, gui)
	
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		if gameData.debugMode then
			print("mapData.levelNum", mapData.levelNum)
		end
		-- pause physics
		physics.pause()
		cutSceneSystem.cutScene(gui, mapData)
		--gameTimer.preGame(gui, mapData)
	end
	physics.pause()
	player1.curse = 0
	player2.curse = 0
	local physicTimer=timer.performWithDelay( 2000, startPhys)
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
	-- clean snow
	snow.meltSnow()		
	-- remove all eventListeners
	removeGameLoopListeners(gui)
	-- clear collision detections
	for i = 1, gui.playerCount do
		collisionDetection.destroyCollision(players[i].imageObject)
	end

	inventory.inventoryInstance:clear()
	
	-- destroy player instance
	table.remove(players)
	player1:resetRune()	
	player1:deleteAura()
	player1.imageObject:removeSelf()
	player1.imageObject = nil
	
	shadowCircle = nil
	
	ball:removeSelf()
	ball = nil
	accelObjects.switchWallAndIceberg = nil
	--miniMap:removeSelf()
	--miniMap = nil
		
	gui:removeSelf()
	gui = nil
		
	playerSheet = nil

	-- call objects-destroy
	objects.destroy(mapData)
end
--------------------------------------------------------------------------------
-- Update (Runtime) - Functions that need to run non-stop during their events
--------------------------------------------------------------------------------
-- Updated by: Derrick 
--------------------------------------------------------------------------------
local function update(event)
	-- Debug Runtime Event.
	if gameData.debugMode then
		-- Memory monitor
		memory.monitorMem()
		-- Water boolean
		memory.inWater()
		-- Show physics bodies
		physics.setDrawMode("hybrid")
	end

	-- Main Menu Runtime Event.
	if gameData.inMainMenu then
		-- Activate snow particle effect if in main menu
		-- Draws snow every second
		snow.makeSnow(event, mapData)
	end
	
	-- Options Menu Runtime Event.
	if gameData.updateOptions then
		menu.update(groupObj)
	end

	-- World Selector Runtime Event.
	if gameData.inWorldSelector == 1 then
		-- Draw shadow under ball
		if shadowCircle and ball then
			shadowCircle.x = ball.x
			shadowCircle.y = ball.y
		end
	end
	
	-- Level Selector Runtime Event.
	if gameData.inLevelSelector == 1 then
		-- Draw shadow under ball
		if shadowCircle and ball then
			shadowCircle.x = ball.x
			shadowCircle.y = ball.y
		end
	end
	
	-- In-Game Runtime Event.
	if gameData.ingame == 1 then
		snow.gameSnow(event, mapData, gui)
		if shadowCircle and ball then
			shadowCircle.x = ball.x
			shadowCircle.y = ball.y
		end
	end
		
	-- In-Water Runtime Event.
	if gameData.inWater then
		-- Turn on pane switching and mini map
		gameData.allowPaneSwitch = false
	end
end

--------------------------------------------------------------------------------
-- Core Game Loop - Runtime:addEventListener called in main.lua
--------------------------------------------------------------------------------
-- Updated by: Derrick 
--------------------------------------------------------------------------------
local function gameLoopEvents(event)
	-- Runtime functions
	update(event)
	
	if gameData.gRune == true and gameData.isShowingMiniMap == false then
		for check = 1, #accelObjects.switchWallAndIceberg do
  			local currObject = accelObjects.switchWallAndIceberg[check]
			if gameData.onIceberg == true or currObject.name == "switchWall" then
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
		
	-----------------------------
	--[[ START WORLD SELECTOR]]--
	if gameData.selectWorld then
	
		if gameData.inLevelSelector == 1 then
			clean(event)
			gameData.inLevelSelector = 0
		elseif gameData.inWorldSelector == -1 then
			gameData.inWorldSelector = 0
			clean(event)
		end		
		
		if gameData.debugMode then
			print("In World Selector")
			print("gameData.mapData.world", gameData.mapData.world)
		end
				
		-- Reset mapData to level select default
		mapData.world = gameData.mapData.world
		mapData.levelNum = "world"
		mapData.pane = "world"
		-- Load map
		loadMap(mapData)
		-- Add game event listeners
		addGameLoopListeners(gui)
		-- Re-evaluate gameData booleans
		gameData.inWater = false
		gameData.allowMiniMap = false
		gameData.allowPaneSwitch = false
		gameData.inWorldSelector = 1
		-- Switch off this loop
		gameData.selectWorld = false
	end
		
	---------------------------
	--[[ START LVL SELECTOR]]--
	if gameData.selectLevel then
		clean(event)
		
		if gameData.debugMode then
			print("In Level Selector")
			print("gameData.mapData.world", gameData.mapData.world)
		end
		
		-- Reset mapData to level select default
		mapData.world = gameData.mapData.world
		mapData.levelNum = "LS"
		mapData.pane = "LS"
		-- Load map
		loadMap(mapData)
		-- Add game event listeners
		addGameLoopListeners(gui)
		-- Re-evaluate gameData booleans
		gameData.inWater = false
		gameData.allowMiniMap = false
		gameData.allowPaneSwitch = false
		gameData.inLevelSelector = 1
		-- Switch off this loop
		gameData.selectLevel = false
	end
	
	-----------------------
	--[[ START GAMEPLAY]]--
	if gameData.gameStart then
		if gameData.debugMode then
			print("start game")
		end
			
		clean(event)
		-- Set mapData to player's gameData mapData
		mapData = gameData.mapData
		mapData.pane = "M"
		-- Load in map with new mapData

		
		loadMap(mapData)
		snow.new()
		-- Re-evaluate gameData booleans
		gameData.inLevelSelector = 0
		gameData.inWater = false
		gameData.preGame = true
		-- Switch off this loop
		gameData.gameStart = false
	end
	
	-------------------------
	--[[ PRE-GAME LOADER ]]--
	if gameData.preGame == false then
		if gameData.debugMode then
			print("In Pre-game")
		end
		
		-- Switch to in game loop
		gameData.ingame = 1
		snow.new()
		-- Turn on pane switching and mini map
		gameData.allowPaneSwitch = true
		gameData.allowMiniMap = true
		-- Clear out pre-game
		gameData.preGame = nil
		-- Add game event listeners
		addGameLoopListeners(gui)
	end
		
	-----------------------
	--[[ Restart level ]]--
	if gameData.levelRestart == true then
		if gameData.debugMode then
			print("Restarting Level...")
		end
	
		-- Clean
		--clean(event)
		inventory.inventoryInstance:clear()
		collisionDetection.resetCollision()
		-- Reset current pane to middle
		gameData.ingame = 0
		inventory.inventoryInstance:clear()
		-- Start game
		gameData.gameStart = true
		-- Switch off game booleans
		gameData.inWater = false
		gameData.onIceberg = false
		-- Switch off this loop
		gameData.levelRestart = false
	end
		
	------------------------
	--[[ LEVEL COMPLETE ]]--
	if gameData.levelComplete then
		if gameData.debugMode then
			print("Level completed...")
		end
	
		-- clean
		--clean(event)
		gameData.ingame = 0
		snow.meltSnow()
		gameTimer.pauseTimer()
		physics.pause()
		-- apply booleans
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		gameData.gameScore = true	
		if gameData.debugMode then
			print("Going to game score...")
		end
		-- Switch off this loop
		gameData.levelComplete = false
	end
	
	--------------------
	--[[ GAME SCORE ]]--
	if gameData.gameScore then
		if gameData.debugMode then
			print("Game score...")
		end
	
		win.init(gui)
		win.showScore(mapData, gui)
		--loadingScreen.deleteLoading()
		-- Turn off pane switching and mini map
		menu.cleanInGameOptions()
		-- Remove object listeners
		removeGameLoopListeners(gui)
		-- Apply booleans
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		gameData.gameScore = false
	end
	
	----------------------
	--[[ END GAMEPLAY ]]--
	if gameData.gameEnd then
		if gameData.debugMode then
			print("Ending game...")
		end
	
		--sound.soundClean()
		-- Switch off game booleans
		if gameData.ingame == -1 then
			inventory.inventoryInstance:clear()
			gameData.ingame = 0
			gameData.inWater = false
			gameData.onIceberg = false
			gameData.gameStart = true
		elseif gameData.inLevelSelector == -1 then
			gameData.inLevelSelector = 0
			gameData.selectLevel = true
		elseif gameData.inWorldSelector == -1 then
			clean(event)
			gameData.inWorldSelector = 0
			gameData.selectWorld = true
		else
			clean(event)
			snow.meltSnow()
			-- Go to menu
			gameData.menuOn = true
		end
		
		-- Switch off this loop
		gameData.gameEnd = false
	end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		if gameData.debugMode then
			print("Main menu on...")
		end		
		
		-- Go to main menu
		menu.clean()
		gameData.updateOptions = false
		gameData.gameTime = 0
		gameData.ingame = 0
		gameData.inLevelSelector = 0
		gameData.inWorldSelector = 0
		snow.new()
		menu.mainMenu(event)
		mapDataDefault()		
		gameTimer.cancelTimer()
		-- Re-evaluate gameData booleans
		gameData.inWater = false
		gameData.onIceberg = false
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		gameData.isShowingMiniMap = false
		-- Run main menu runtime event
		gameData.inMainMenu = true
		-- Switch off this loop
		gameData.menuOn = false
	end
		
	----------------------
	--[[ OPTIONS MENU ]]--	
	if gameData.inOptions then
		if gameData.debugMode then
			print("In options menu...")
		end
	
		-- Clean up snow
		snow.meltSnow()
		-- Go to options menu
		groupObj = menu.options(event)																																																																						
		-- Re-evaluate gameData booleans
		gameData.updateOptions = true
		gameData.inMainMenu = false
		-- Switch off this loop
		gameData.inOptions = false		
	end
	
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	if gameData.inGameOptions then
		if gameData.debugMode then
			print("In game options menu...")
		end
		physics.pause()
		menu.cleanInGameOptions()
		-- Pause gameTimer
		if mapData.levelNum ~= "LS" then
			gameTimer.pauseTimer()
		end
		-- Go to in-game option menu
		groupObj = menu.ingameMenu(event, player1, player2, gui)
		-- Cancel snow timer
		--snow.meltSnow()
		-- Remove object listeners
		removeGameLoopListeners(gui)
		-- Re-evaluate gameData booleans
		--gameData.updateOptions = true
		-- Switch off this loop
		gameData.inGameOptions = false
	end
	
	---------------------
	--[[ RESUME GAME ]]--		
	if gameData.resumeGame then
		if gameData.debugMode then
			print("Resume game...")
			print("gameTimer.loopLoc", gameTimer.loopLoc)	
		end
				
		if gameTimer.loopLoc == 0 or gameTimer.loopLoc == 2 then
			-- Restart physics
			physics.start()		
			-- Add object listeners
			addGameLoopListeners(gui)
		end
		-- Create in game options button
		menu.ingameOptionsbutton(event, gui)
		-- Resume gameTimer
		gameTimer.resumeTimer()	
		-- Switch off this loop
		gameData.resumeGame = false
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
end

local gameLoop = {
	gameLoopEvents = gameLoopEvents,
	addGameLoopListeners = addGameLoopListeners,
	removeGameLoopListeners = removeGameLoopListeners
}

return gameLoop