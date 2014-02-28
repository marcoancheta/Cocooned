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

--------------------------------------------------------------------------------
-- Load in files/variables from other .lua's
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- Select level function (loadLevel.lua)
local selectLevel = require("selectLevel")
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
-- Save/Load Game Data Functions
local save = require("GGData")
-- miniMap display functions
local miniMapMechanic = require("miniMap")

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
-- Updated by: Marco
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

-- create player variables
local player1, player2


--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function loadMap()
	-- pause physics
	physics.pause()
	physics.setScale(45)
	-- Initialize player(s)
	player1 = player.create()
	--player2 = player.create()
	system.setAccelerometerInterval(30)

	-- Create player sprite sheet
	local playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", 
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
	gui, miniMap = loadLevel.createLevel(mapData, ball, player1)

	--start physics when everything is finished loading
	physics.start()
end

--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
------- tapMechanics
------- speedUp
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Control Mechanics - controls movement for player
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function controlMovement(event) 
	
	-- if miniMap isn't showing, move player
	if gameData.isShowingMiniMap == false then
		-- call accelerometer to get data
		physicsParam = movementMechanic.onAccelerate(event, player1)

		-- set player's X and Y gravity times the player's curse
		player1.xGrav = physicsParam.xGrav*player1.curse
		player1.yGrav = physicsParam.yGrav*player1.curse
	end
end

--------------------------------------------------------------------------------
-- Speed Up - gives momentum to player movement
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function speedUp(event)
	if gameData.isShowingMiniMap == false then
	--[[
		for check = 1, map.layer["tiles"].numChildren do
			currObject = map.layer["tiles"][check]
			if currObject.accel == true and gameData.greenG == true then
				local vel = 40
				if player1.yGrav<0 then
					vel = -40
				elseif player1.yGrav == 0 then
					vel = 0
				end
				if string.sub(currObject.name,1,10) == "switchWall"then
					currObject:setLinearVelocity(0, vel)
				end
			end
		end
	]]--
		
		player1.xGrav = player1.xGrav*player1.curse
		player1.yGrav = player1.yGrav*player1.curse

		movement.moveAndAnimate(player1)
	end
end

-- variable that holds current pane player is in for later use
local tempPane

--------------------------------------------------------------------------------
-- Swipe Mechanics - function that is called when player swipes
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function swipeMechanics(event)

	if player1.movement == "accel" then
		-- save temp pane for later check
		tempPane = mapData.pane

		-- call swipe mechanic and get new Pane
		touch.swipeScreen(event, mapData, player1, miniMap, gui.back[1])
		-- if touch ended then change map if pane is switched
		if "ended" == event.phase and mapData.pane ~= tempPane then

			-- play snow transition effect
			paneTransition.playTransition(tempPane, mapData.pane, gui.back[1], player1)
			
			-- switch panes
			movePanes()
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
		local tempPane = mapData.pane

		-- call function for tap screen
		tempPane = touch.tapScreen(event, miniMap, mapData, physics, gui.back[1], player1)

		-- check if pane is different from current one, if so, switch panes
		if mapData.pane ~= tempPane and gameData.isShowingMiniMap ~= true then

			-- play snow transition effect
			paneTransition.playTransition(tempPane, mapData.pane, gui.back[1], player1)

			-- switch panes
			movePanes()
		end
	end
end

--------------------------------------------------------------------------------
-- Move Panes - changes current pane to new one
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function movePanes()

	-- update new miniMap
	miniMapMechanic.updateMiniMap(tempPane, miniMap, gui.back[1], player1)

	-- delete everything on map
	map:removeSelf()
	objects.destroy(mapData)
		
	-- Pause physics
	physics.pause()

	---------------------------------------------------
	-- Play "character" teleportation animation here --
	---------------------------------------------------
		
	-- load new map pane
	map = loadLevel.changePane(mapData, player1, miniMap)

	-- insert objects onto map layer
	gui.back:insert(map)
	map.layer["tiles"]:insert(player1.imageObject)

	-- Resume physics
	physics.start()

	-- Reassign game mechanic listeners
	collisionDetection.changeCollision(ball, player1, mapData, gui.back[1], gui.front, physics, miniMap)
end


--------------------------------------------------------------------------------
-- Core Game Loop
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function gameLoop(event)
	---------------------------------
	--[[ START LVL SELECTOR LOOP ]]--
	-- If select level do:
	if gameData.selectLevel then
		sound.playEventSound(event, sound.selectMapSound)	
		selectLevel.selectLoop(event)	
		gameData.inLevelSelector = true
		gameData.selectLevel = false
	end

	if gameData.inLevelSelector then
		mapData.levelNum = selectLevel.levelNum
		mapData.pane = selectLevel.pane
		mapData.version = selectLevel.version
		Runtime:removeEventListener("enterFrame", selectLevel.setCameratoPlayer)
		gameData.inLevelSelector = false
	end

	-----------------------------
	--[[ START GAMEPLAY LOOP ]]--
	-- If game has started do:
	if gameData.gameStart then	
		-- Stop BGM
		--sound.stopBGM(event, sound.mainmenuSound)
		-- Start physics
		physics.start()
		-- Load Map
		loadMap()

		print("Game Start!")
	
		-- Start mechanics
		collisionDetection.createCollisionDetection(player1.imageObject, player1, mapData, gui.back[1], gui.front, physics, miniMap)
		Runtime:addEventListener("enterFrame", speedUp)
		Runtime:addEventListener("accelerometer", controlMovement)
		gui.back:addEventListener("touch", swipeMechanics)
		gui.back:addEventListener("tap", tapMechanic)
		menu.ingameOptionsbutton(event)
		
		-- Re-evaluate gameData booleans
		gameData.BGM = 2
		gameData.menuOn = false
		gameData.BGM = false
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

		-- remove all eventListeners
		gui.back:removeEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
		Runtime:removeEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)
		collisionDetection.destroyCollision(player1.imageObject)

		-- destroy and remove all data
		map.destroy()
		map = nil
		ball:removeSelf()
		ball = nil
		display.remove(gui)
		gui = nil

		--for i=1, 7 do
		--display.remove(miniMap[i])
		--end
		miniMap:removeSelf()
		miniMap = nil

		-- destroy player instance
		player1:destroy()
		player1 = nil
		playerSheet = nil
		
		-- call objects-destroy
		objects.destroy(mapData)

		-- stop physics
		physics.stop()
		
		-- set boolean variables
		gameData.gameEnd = false
		if gameData.menuOn ~= true then
			gameData.selectLevel = true
		end
	elseif gameData.levelRestart == true then
		-- remove all eventListeners
		gui.back:removeEventListener("touch", swipeMechanics)
		miniMap:removeEventListener("tap", tapMechanic)
		Runtime:removeEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)
		collisionDetection.destroyCollision(player1.imageObject)

		-- destroy and remove all data
		map.destroy()
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
			
		-- call objects-destroy
		objects.destroy(mapData)		

		-- stop physics
		physics.stop()
		gameData.levelRestart = false
		gameData.gameStart = true

		-- reset pane to middle pane
		mapData.pane = 'M'
	end
	
	----------------------
	--[[ IN-GAME LOOP ]]--
	-- If ingame has started do:
	--[[
	if gameData.ingame then
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
	end
	]]
	
end

--------------------------------------------------------------------------------
-- Core Menu Loop
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function menuLoop(event)
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		-- If in main menu do:
		print("In Main Menu")
		-- Go to main menu
		menu.MainMenu(event)
		
		if not sound.isChannel2Active then
			-- Start BGM
			--sound.playBGM(event, sound.mainmenuSound)
		end
		
		-- reset mapData variables
		mapData.pane = "M"
		mapData.version = 0

		-- Re-evaluate gameData booleans
		gameData.gameStart = false
		gameData.ingame = false
		gameData.showMiniMap = false
		gameData.menuOn = false


	
	----------------------
	--[[ OPTIONS MENU ]]--	
	elseif gameData.inOptions then
		-- If in options do:
		print("In Main Menu")
		-- Go to options menu
		menu.Options(event)
		--menu.soundOptions(event)
		-- Re-evaluate gameData booleans
		gameData.menuOn = false
		gameData.inOptions = false
		
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	elseif gameData.inGameOptions then
		-- If in game options do:
		-- Clear on screen objects
		--gui:removeSelf()
		-- Go to in-game option menu
		menu.ingameMenu(event)
		
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
		menu.ingameOptionsbutton(event)

		-- Add object listeners
		gui.back:addEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
		gui.back:addEventListener("tap", tapMechanic)
		Runtime:addEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)
		
		-- Re-evaluate gameData booleans
		gameData.inGameOptions = false
		gameData.allowMiniMap = true
		gameData.showMiniMap = true
		gameData.resumeGame = false
	end
end

--------------------------------------------------------------------------------
-- Core Sound Loop
--------------------------------------------------------------------------------
--[[
function soundLoop(event)
	--------------
	-- BGM LOOP --
	--------------
	if gameData.BGM ~= 0 then
		if gameData.BGM == 1 then
			-- Play BGM
			sound.playBGM(event, sound.mainmenuSound)
		end 
		
		if gameData.BGM == 2 then
			-- Stop BGM
			sound.stopBGM(event)
		end
		
		gameData.BGM = 0
	end 
end
]]--

--------------------------------------------------------------------------------
-- Call gameLoop && menuLoop every 30 fps
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
Runtime:addEventListener("enterFrame", gameLoop)
Runtime:addEventListener("enterFrame", menuLoop)

--Runtime:addEventListener("enterFrame", soundLoop)


--------------------------------------------------------------------------------
-- Memory Check (http://coronalabs.com/blog/2011/08/15/corona-sdk-memory-leak-prevention-101/)
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------

-- debug text object
local textObject = display.newText("test", 1200, 100, native.systemFont, 48)
textObject:setFillColor(0,1,0)

local prevTextMem = 0
local prevMemCount = 0
local monitorMem = function()
collectgarbage("collect")

local memCount = collectgarbage("count")
	if (prevMemCount ~= memCount) then
		--print( "MemUsage: " .. memCount)
		textObject.text = memCount
		textObject:toFront()
		prevMemCount = memCount
	end
	
	local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
	
	if (prevTextMem ~= textMem) then
		prevTextMem = textMem
	end
	
	-- Display fps
	--print(display.fps)
end

Runtime:addEventListener( "enterFrame", monitorMem )
--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------

