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
-- Goals
local goals = require("Core.goals")
-- Shadows
local shadows = require("utils.shadows")
-- Tutorial
local tutorialLib = require("utils.tutorialLib")
-- touch paricle effect
local particle_lib = require("utils.touchParticles")

--------------------------------------------------------------------------------
-- Local/Global Variables
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local gameLoop = {
	player = {
		[1] = nil,
		[2] = nil
	},
}

-- Arrays 
local playerObj = {}
local players = {}
local linePts = {}

-- Initialize ball
local ball = {
	[1] = nil,
	[2] = nil
}
-- Initialize map data
local mapData = { 
	world = "A",
	levelNum = 1,
	pane = "M",
	version = 0
}
 -- Initialize sprite array for loops
local sprite = {
	[1] = animation.sheetOptions.playerSheet,
	[2] = animation.sheetOptions.playerSheet2
}

-- Initialize ball
local playerAmount = 2
local map
local gui
local physicsParam
local tempPane -- variable that holds current pane player is in for later use
local camera;
local groupObj;
local shadowCircle;

-- Emitter things
local duration = 1000
local speed = 10
local density = 1
local range = 50
local thickness = 200
local touchEmitter = touchEmitterLib:createEmitter(range, thickness, duration, 1, 0, nil, nil, nil)

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

	-- emit particles when you touch the screen
	touchEmitter:emit(gui.front, event.x, event.y)

	if gameData.allowPaneSwitch then
		-- save temp pane for later check
		tempPane = mapData.pane

		-- call swipe mechanic and get new Pane
		touch.swipeScreen(event, mapData, miniMap, gui.front)
		
		-- if touch ended then change map if pane is switched
		if "ended" == event.phase and mapData.pane ~= tempPane then
			-- play snow transition effect
			paneTransition.playTransition(tempPane, miniMap, mapData, gui, gameLoop.player[1]) --player1)
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
		touch.tapScreen(event, miniMap, mapData, physics, gui, gameLoop.player[1]) --player1)

		-- check if pane is different from current one, if so, switch panes
		if mapData.pane ~= tempPane and gameData.isShowingMiniMap ~= true then
			-- play snow transition effect
			if gameData.allowPaneSwitch then
				paneTransition.playTransition(tempPane, miniMap, mapData, gui, gameLoop.player[1]) --player1)
			end
		end
		
		--ball.x, ball.y = event.x, event.y
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
			physicsParam = accelerometer.onAccelerate(event, players[i], mapData)
			-- set player's X and Y gravity times the player's curse
			players[i].xGrav = physicsParam.xGrav
			players[i].yGrav = physicsParam.yGrav
			
			--[[if gameData.debugMode then
				print("players[i].xGrav", players[i].xGrav)
				print("players[i].yGrav", players[i].yGrav)
			end]]--
		end
		
	end
	
	--if gameData.debugMode then
		--if event.isShake then
		--	print("DEVICE IS SHAKING!!!!")
		--end

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
	--end
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
			end
		end
	end
	
	--[[
	-- OLD TRAIL CODE
	local ballPt = {}
	ballPt.x = player1.imageObject.x
	ballPt.y = player1.imageObject.y
	table.insert(linePts, ballPt);
	trails.drawTrail(event)
	table.remove(linePts, 1);
	]]--
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
	gui.back:removeEventListener("touch", swipeMechanics)
	gui.back:removeEventListener("tap", tapMechanic)
	Runtime:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", speedUp)
end

--------------------------------------------------------------------------------
-- Restart physics and remove curse by +1
--------------------------------------------------------------------------------
local function startPhys(event)
	-- Start physics
	physics.start()
	-- Reapply regular movement
	gameLoop.player[1].curse = 1 --player1.curse = 1
	gameLoop.player[2].curse = 1 --player2.curse = 1
	-- print
	print("START PHYSICS FOR: ", mapData.levelNum)
end

--------------------------------------------------------------------------------
-- loadPlayer - Create ball and physics value for player
--------------------------------------------------------------------------------
local function loadPlayer(value, mapData)
	local vBall = nil
	local tSprite = sprite[value]
	
	vBall = display.newSprite(tSprite, animation.spriteOptions.player)
	vBall.name = "player"
	
	physics.addBody(vBall, {radius = 38, bounce = .25})
	
	vBall.density = 0.3
	vBall.linearDamping = 1.25
	vBall.alpha = 0
	
	return vBall
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function loadMap(mapData)
	-- Increase accelerometer response interval
	system.setAccelerometerInterval(30)
	-- Clear snow
	snow.meltSnow()	
	-- Start physics
	physics.start()
	physics.setScale(45)	
	physics.setGravity(0,0)
	
	for i=1, playerAmount do
		-- Initialize player(s)
		gameLoop.player[i] = player.create()
		players[i] = gameLoop.player[i]
		ball[i] = loadPlayer(i, mapData)
		-- Assign balls to their respected player imageObjects
		gameLoop.player[i].imageObject = ball[i]
		-- Assign players paneTransition mechanic if needed
		gameLoop.player[i].switchPanes = paneTransition
		gameLoop.player[i].curse = 0		
	end
	
	-- Load in map
	gui, miniMap, shadowCircle = loadLevel.createLevel(mapData, players)

	-- Start mechanics
	for i = 1, gui.playerCount do		
		-- Create collision
		collisionDetection.createCollisionDetection(players[i].imageObject, gameLoop.player[1], mapData, gui, gui.back[1])
		-- Create rune inventory for player
		players[1].inventory.runes = {
			["M"] = {},
			["D"] = {},
			["L"] = {},
			["R"] = {},
			["U"] = {},
		}
		-- If playerCount is only set to 1, destroy player 2
		if gui.playerCount == 1 then
			gameLoop.player[2].imageObject:removeSelf() --player2.imageObject:removeSelf()
			gameLoop.player[2].imageObject = nil --player2.imageObject = nil
			ball[2]:removeSelf() --ball2:removeSelf()
			ball[2] = nil --ball2 = nil
		end
	end
	
	-- Create in game options button
	menu.ingameOptionsbutton(event, gui)
	-- Pause physics
	physics.pause()
	-- Outside of Level Selector and World Selector
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		-- Run cut scene algorithm
		cutSceneSystem.cutScene(gui, mapData)
	end		
	-- Delay physics restart
	local delay = 3500
	-- Alpha transition to 1 (9 milliseconds)
	local alphaTrans = transition.to(ball[1], {time=delay, alpha=1, onComplete=startPhys}) --ball, {time=delay+1000, alpha=1})	
	
	-- Debug print
	for i=1, playerAmount do
		if gameLoop.player[i] then
			print("gameLoop.player["..i.."]", gameLoop.player[i].name)
		end
		if players[i] then
			print("players["..i.."]", players[i].name)
		end
		if ball[i] then
			print("ball["..i.."]", ball[i].name)
		end
	end
		
	-- Initialize player(s)
	--gameLoop.player[1] = player.create()
	--gameLoop.player[2] = player.create()
	--players[1] = gameLoop.player[1]
	--players[2] = gameLoop.player[2]		
	--ball[1], ball[2] = loadPlayer(mapData)		
	-- Assign balls to their respected player imageObjects
	--gameLoop.player[1].imageObject = ball[1]  --player1.imageObject = ball
	--gameLoop.player[2].imageObject = ball[2] --player2.imageObject = ball2
	-- Assign players paneTransition mechanic if needed
	--gameLoop.player[1].switchPanes = paneTransition --player1.switchPanes = paneTransition
	--gameLoop.player[2].switchPanes = paneTransition --player2.switchPanes = paneTransition
	-- Make players stop moving
	--gameLoop.player[1].curse = 0 --player1.curse = 0
	--gameLoop.player[2].curse = 0 --player2.curse = 0	
	-- Start physics timer
	--local physicTimer = timer.performWithDelay(delay, startPhys)	
	--return player1
end

--------------------------------------------------------------------------------
-- shadowsPos - position shadows
--------------------------------------------------------------------------------
local function shadowsPos(event)
	for i=1, #ball do
		-- Draw shadow under ball
		if shadowCircle and ball[i] then --ball then
			shadowCircle.x = (ball[i].x + shadows.x) --(ball.x + shadows.x)
			shadowCircle.y = (ball[i].y + shadows.y) --(ball.y + shadows.y)
		end
	end
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
	-- Clear inventory
	inventory.inventoryInstance:clear()
	-- call objects-destroy
	objects.destroy(mapData)
	-- remove all eventListeners
	removeGameLoopListeners(gui)
	
	-- clear collision detections
	for i = 1, gui.playerCount do
		collisionDetection.destroyCollision(players[i].imageObject)
	end
	-- destroy player instance
	table.remove(players)
	
	-- destroy gameLoop.player instance
	for i=1, #gameLoop.player do
		if gameLoop.player[i] ~= nil then
			gameLoop.player[i]:resetRune() --player1:resetRune()	
			gameLoop.player[i]:deleteAura() --player1:deleteAura()
			--gameLoop.player[i].imageObject:removeSelf() --player1.imageObject:removeSelf()
			gameLoop.player[i].imageObject = nil --player1.imageObject = nil
		end
	end
	-- destroy ball instance
	for i=1, #ball do
		if ball[i] ~= nil then
			ball[i]:removeSelf() --ball:removeSelf()
			ball[i] = nil --ball = nil
		end
	end
	
	shadowCircle = nil
	accelObjects.switchWallAndIceberg = nil	
	playerSheet = nil
	gui:removeSelf()
	gui = nil
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

	-- In-Water Runtime Event.
	if gameData.inWater then
		-- Turn on pane switching and mini map
		gameData.allowPaneSwitch = false
	end
	
	-- Main Menu Runtime Event & Winning Runtime Event.
	if gameData.inMainMenu or gameData.winning then
		-- Activate snow particle effect if in main menu
		-- Draws snow every second
		snow.makeSnow(event, mapData)
	end
	
	-- Options Menu Runtime Event.
	if gameData.updateOptions then
		menu.update(groupObj)
	end

	-- World Selector Runtime Event or Level Selector Runtime Event.
	if gameData.inWorldSelector == 1 or gameData.inLevelSelector == 1 then
		-- Positions shadows under ball
		shadowsPos(event)
	end
		
	-- In-Game Runtime Event.
	if gameData.ingame == 1 then
		snow.gameSnow(event, mapData, gui)
		-- Positions shadows under ball
		shadowsPos(event)
	end
	
	-- Level Selector Runtime Event.
	--if gameData.inLevelSelector == 1 then
		-- Positions shadows under ball
	--	shadowsPos(event)
	--end
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
			if string.find(currObject.name, "fixedIceberg") or string.find(currObject.name, "switchWall")then
				print("MOVING SWITCHWALL!!!!!")
  				local velY = 0
  				local velX = 0
  				-- Change speed of moving object
  				if gameLoop.player[1].yGrav < 0 then --if player1.yGrav<0 then
  					velY = -100
  				elseif gameLoop.player[1].yGrav > 0 then --elseif player1.yGrav > 0 then
  					velY = 100
  				end
  				if gameLoop.player[1].xGrav < 0 then --if player1.xGrav<0 then
  					velX = -100
  				elseif gameLoop.player[1].xGrav > 0 then --elseif player1.xGrav > 0 then
  					velX = 100
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
		if mapData.levelNum ~= "T" then
			gameData.allowMiniMap = false
		end
		gameData.allowPaneSwitch = false
		gameData.inWorldSelector = 1
		print ("Setting World Selector!!!!!!!!!!!!!!!!!!")
		-- Switch off this loop
		gameData.selectWorld = false
		if gameData.debugMode then			
			gameData:printData()
		end		
	end
		
	---------------------------
	--[[ START LVL SELECTOR]]--
	if gameData.selectLevel then
		loadingScreen.loadingInit(gui)
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
		loadingScreen.deleteLoading()
		if gameData.debugMode then			
			gameData:printData()
		end		
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
		-- Re-evaluate gameData booleans
		gameData.deaths = 0
		goals.destroyGoals()
		gameData.inLevelSelector = 0
		gameData.inWater = false
		gameData.preGame = true
		-- Switch off this loop
		gameData.gameStart = false
		if gameData.debugMode then			
			gameData:printData()
		end		
	end
	
	-------------------------
	--[[ PRE-GAME LOADER ]]--
	if gameData.preGame == false then
		if gameData.debugMode then
			print("In Pre-game")
		end
		
		snow.new()
		-- Switch to in game loop
		gameData.ingame = 1
		-- Initialize tutorial objects if in tutorial level only
		if mapData.levelNum == "T" then
			tutorialLib:init()
		end
		-- Turn on pane switching and mini map
		gameData.allowPaneSwitch = true
		if mapData.levelNum ~= "T" then
			gameData.allowMiniMap = true
		elseif gameData.mapData.levelNum == "T" then
			if tutorialLib.tutorialStatus == 0 then
				--set up tiltip if in tutorial level
				tutorialLib:showTipBox("tiltTip", 2, gui, player)
			end
		end	
		-- Clear out pre-game
		gameData.preGame = nil
		-- Add game event listeners
		addGameLoopListeners(gui)
		if gameData.debugMode then			
			gameData:printData()
		end		
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
		for i = 1, gui.playerCount do
			players[i]:stopDeathTimer()
		end
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
		if gameData.debugMode then			
			gameData:printData()
		end		
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
		if gameData.debugMode then			
			gameData:printData()
		end		
	end
	
	--------------------
	--[[ GAME SCORE ]]--
	if gameData.gameScore then
		if gameData.debugMode then
			print("Game score...")
		end
	
		win.init(gui)
		win.showScore(mapData, gui)
		snow.new()
		--loadingScreen.deleteLoading()
		-- Turn off pane switching and mini map
		menu.cleanInGameOptions()
		-- Remove object listeners
		removeGameLoopListeners(gui)
		-- Apply booleans
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		gameData.gameScore = false
		if gameData.debugMode then			
			gameData:printData()
		end		
	end
	
	----------------------
	--[[ END GAMEPLAY ]]--
	if gameData.gameEnd then
		if gameData.debugMode then
			print("Ending game...")
		end
		menu.cleanInGameOptions()
		--sound.soundClean()
		-- Switch off game booleans
		if gameData.ingame == -1 then
			miniMap.clean()
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
		if gameData.debugMode then			
			gameData:printData()
		end		
	end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		if gameData.debugMode then
			print("Main menu on...")
		end		
				
		-- Go to main menu
		menu.clean()
		
		if gameLoop.player[1] then
			gameLoop.player[1]:stopDeathTimer()
		end
		
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
		
		if gameData.debugMode then			
			gameData:printData()
		end		
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

		if gameData.debugMode then			
			gameData:printData()
		end				
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
		groupObj = menu.ingameMenu(event, gui)
		-- Remove object listeners
		removeGameLoopListeners(gui)
		-- Switch off this loop
		gameData.inGameOptions = false
		
		if gameData.debugMode then			
			gameData:printData()
		end		
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
		
		if gameData.debugMode then			
			gameData:printData()
		end		
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

gameLoop.gameLoopEvents = gameLoopEvents
gameLoop.addGameLoopListeners = addGameLoopListeners
gameLoop.removeGameLoopListeners = removeGameLoopListeners

return gameLoop