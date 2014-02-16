--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameLoop.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Localize (Load in files) - [System Files]
--------------------------------------------------------------------------------
local require = require
local math_abs = math.abs
local physics = require("physics")
local dusk = require("Dusk.Dusk")

--------------------------------------------------------------------------------
-- Load in files/variables from other .lua's
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

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local movementMechanic = require("Accelerometer")
-- Movement based on Accelerometer readings
local movement = require("movement")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("collisionDetection")

--------------------------------------------------------------------------------
-- Local/Global Variables
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
-- Load Map
--------------------------------------------------------------------------------
function loadMap()
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
	ball.name = "player"
	ball:setSequence("move")
	-- add physics to ball
	physics.addBody(ball, {radius = 38, bounce = .25})
	physics.setGravity(0,0)
	ball.linearDamping = 1
	ball.density = .3

	-- Load in map
	gui, miniMap = loadLevel.createLevel(mapData, ball, player1)
	
end

--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
------- tapMechanics
------- speedUp
--------------------------------------------------------------------------------

-- control mechanics
local function controlMovement(event) 
	-- call accelerometer to get data
	if gameData.isShowingMiniMap == false then
		physicsParam = movementMechanic.onAccelerate(event)
		player1.xGrav = physicsParam.xGrav
		player1.yGrav = physicsParam.yGrav
	end
	
end

local function speedUp(event)
	movement.moveAndAnimate(player1)
end

-- swipe mechanic
local function swipeMechanics(event)
	
	-- save temp pane for later check
	local tempPane = mapData.pane

	-- call swipe mechanic and get new Pane
	touch.swipeScreen(event, mapData, player1, miniMap)

	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase and mapData.pane ~= tempPane then

		-- delete everything on map
		map:removeSelf()
		objects.destroy(mapData)
		
		-- Pause physics
		physics.pause()
		---------------------------------------------------
		-- Play "character" teleportation animation here --
		---------------------------------------------------
	
		-- Resume physics
		physics.start()
		
		-- load map
		map = loadLevel.changePane(mapData, player1)
		-- insert objects onto map layer
		gui.back:insert(map)
		map.layer["tiles"]:insert(ball)
		
		-- Reassign game mechanic listeners
		collisionDetection.changeCollision(ball, player1, mapData, gui.back[1], gui.front, physics, miniMap)
	end
end

-- tap mechanic
local function tapMechanic(event)
	if gameData.allowMiniMap then
		-- mechanic to show or hide minimap
		touch.tapScreen(event, miniMap, physics)
	end
end

--------------------------------------------------------------------------------
-- Core Game Loop
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
		collisionDetection.createCollisionDetection(ball, player1, mapData, gui.back[1], gui.front, physics, miniMap)
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
		collisionDetection.destroyCollision(ball)

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
		objects.destroy()

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
			gui.back:removeEventListener("tap", tapMechanic)
			Runtime:removeEventListener("accelerometer", controlMovement)
			Runtime:removeEventListener("enterFrame", speedUp)
			collisionDetection.destroyCollision(ball)

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
			objects.destroy()		

			-- stop physics
			physics.stop()
			gameData.levelRestart = false
			gameData.gameStart = true
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
  			if timeCount % 30 == 1 then 
  				activateWind = true
  				print(activateWind)
  			elseif timeCount % 30 ~= 1 then
  				activateWind = false
  			end
		end
	end
	]]
end

--------------------------------------------------------------------------------
-- Core Menu Loop
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
Runtime:addEventListener("enterFrame", gameLoop)
Runtime:addEventListener("enterFrame", menuLoop)


--Runtime:addEventListener("enterFrame", soundLoop)

local textObject = display.newText("test", 1200, 100, native.systemFont, 32)
textObject:setFillColor(0,1,0)
textObject.alpha= 0

--------------------------------------------------------------------------------
-- Memory Check (http://coronalabs.com/blog/2011/08/15/corona-sdk-memory-leak-prevention-101/)
--------------------------------------------------------------------------------
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

