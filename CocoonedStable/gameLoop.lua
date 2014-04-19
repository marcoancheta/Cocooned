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
local gameData = require("Core.gameData")
-- Load level function (loadLevel.lua)
local loadLevel = require("Loading.loadLevel")
-- Animation variables/data (animation.lua)
local animation = require("Core.animation")
-- Menu variables/objects (menu.lua)
local menu = require("Core.menu")
-- Sound files/variables (sound.lua)
local sound = require("sounds.sound")
-- Player variables/files (player.lua)
local player = require("Mechanics.player")
-- Object variables/files (objects.lua)
local objects = require("Loading.objects")
-- miniMap display functions
--local miniMapMechanic = require("Mechanics.miniMap")
-- memory checker (memory.lua)
local memory = require("memory")

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("Mechanics.touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local movementMechanic = require("Mechanics.Accelerometer")
-- Movement based on Accelerometer readings
local movement = require("Mechanics.movement")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("Mechanics.collisionDetection")
-- Pane Transitions (paneTransition.lua)
local paneTransition = require("Loading.paneTransition")

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
local count = 0

local players = {}
local linePts = {}

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
		touch.swipeScreen(event, mapData, miniMap, gui.back[1])
		
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
		physicsParam = movementMechanic.onAccelerate(event, player1, player2, gui.back[1])
	
		-- set player's X and Y gravity times the player's curse
		player1.xGrav = physicsParam.xGrav
		player1.yGrav = physicsParam.yGrav
	end
end

--------------------------------------------------------------------------------
-- Create Trail - Draws trail behind player
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function drawTrail(event)
	if gui then
		if line then
			line:removeSelf()
		end
		
		print("starting")
		
		if #linePts >= 2 then
			print("drawing")
			line = display.newLine(linePts[1].x, linePts[1].y, linePts[2].x, linePts[2].y)
			line:setStrokeColor(236*0.003921568627451, 228*0.003921568627451, 243*0.003921568627451)
			line.strokeWidth = 50
			
			gui.back:insert(line)
			
			for i = 3, #linePts, 1 do 
				line:append(linePts[i].x,linePts[i].y);
			end 
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
					
			local ballPt = {}
			ballPt.x = player1.imageObject.x
			ballPt.y = player1.imageObject.y
			print(ballPt.x, ballPt.y)
				
			table.insert(linePts, ballPt);
		end
	end
	
	drawTrail(event)
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function loadMap(mapData)
	-- Start physics
	physics.start()
	--physics.setDrawMode("hybrid")
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

	gui:addEventListener("touch", swipeMechanics)
	gui:addEventListener("tap", tapMechanic)
	Runtime:addEventListener("accelerometer", controlMovement)
	Runtime:addEventListener("enterFrame", speedUp)
end

--------------------------------------------------------------------------------
-- Clean - clean level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function clean(event)
	-- remove all eventListeners
	gui:removeEventListener("touch", swipeMechanics)
	gui:removeEventListener("tap", tapMechanic)	
	Runtime:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", speedUp)
		
	collisionDetection.destroyCollision(player1.imageObject)

	--if mapData.levelNum == "LS" then
	--	gui[1][1].destroy()
	--end
	
	ball:removeSelf()
	ball = nil
	
	--gui:removeSelf()
	--gui = nil
	
	--miniMap:removeSelf()
	--miniMap = nil

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
-- Updated by: Derrick 
--------------------------------------------------------------------------------
local function gameLoopEvents(event)
	-- Run monitorMemory from open to close.
	memory.monitorMem()
	
	--[[	
	if mapData.levelNum == "LS" then
		if gui.back[1] then
			-- Set Camera to Ball
			gui.back[1].setCameraFocus(ball)
			gui.back[1].setTrackingLevel(0.1)
		end
	end
	]]--
	
	---------------------------------
	--[[ START LVL SELECTOR LOOP ]]--
	-- If select level do:
	if gameData.selectLevel then
		mapData.levelNum = "LS"
		mapData.pane = "LS"
		
		loadMap(mapData)
		menu.ingameOptionsbutton(event, gui)
				
		-- Re-evaluate gameData booleans
		gameData.selectLevel = false
	end
	
	-----------------------------
	--[[ START GAMEPLAY LOOP ]]--
	-- If game has started do:
	if gameData.gameStart then
		print("start game")
		clean(event)
		
		mapData = gameData.mapData
		loadMap(mapData)
		menu.ingameOptionsbutton(event, map)
		
		-- Re-evaluate gameData booleans
		gameData.allowPaneSwitch = true
		gameData.allowMiniMap = true
		gameData.gameStart = false
	end
		
	-----------------------------
	--[[ END GAMEPLAY LOOP ]]--
	-- If game has ended do:
	if gameData.gameEnd then
		clean(event)
	
		-- set booleans
		gameData.menuOn = true
		gameData.gameEnd = false
	elseif gameData.levelRestart == true then
		clean(event)
		
		if gameData.menuOn ~= true then
			gameData.selectLevel = true
		else
			-- reset pane to middle pane
			mapData.pane = 'M'
			gameData.gameStart = true
		end
		
		gameData.levelRestart = false
	end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		-- Go to main menu
		menu.mainMenu(event)
		
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
		-- Go to options menu
		menu.options(event)																																																																						
		-- Re-evaluate gameData booleans
		gameData.inOptions = false		
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	elseif gameData.inGameOptions then
		-- Go to in-game option menu
		menu.ingameMenu(event, player1, player2, gui)
		
		-- Remove object listeners
		gui.back:removeEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
		Runtime:removeEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)

		-- Re-evaluate gameData booleans
		--gameData.ingame = false
		gameData.allowMiniMap = false
		gameData.showMiniMap = false
		gameData.isShowingMiniMap = false
		gameData.inGameOptions = false
	--------------------------
	--[[ RESUME GAME LOOP ]]--		
	elseif gameData.resumeGame then
		-- Restart physics
		physics.start()		
		-- Re-add in game options button
		menu.ingameOptionsbutton(event, map)

		-- Add object listeners
		gui:addEventListener("touch", swipeMechanics)
		gui:addEventListener("tap", tapMechanic)
		Runtime:addEventListener("accelerometer", controlMovement)
		Runtime:addEventListener("enterFrame", speedUp)
		
		-- Re-evaluate gameData booleans
		gameData.inGameOptions = false
		gameData.allowMiniMap = true
		gameData.showMiniMap = true
		gameData.resumeGame = false
	end	
end

local gameLoop = {
	gameLoopEvents = gameLoopEvents
}

return gameLoop