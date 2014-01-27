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
-- Save/Load Game Data Functions
local save = require("GGData")

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local movementMechanic = require("Accelerometer")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("collisionDetection")
-- Magnetism mechanics (magnetism.lua)
--local magnetismMechanic = require("magnetism")

--------------------------------------------------------------------------------
-- Local/Global Variables
--------------------------------------------------------------------------------
-- Initialize ball
local ball
local mapPanes

-- Initialize map data
local mapData = {
	levelNum = 1,
	pane = "M",
	version = 0
}

-- Initialize player(s)
local player1 = player.create()
local player2 = player.create()

-- Player print testing
--[[
	print("player1 name =", player1.name)
	print("player1 color =", player1.color)
	print("player2 name =", player1.name)
	print("player2 color =", player1.color)
]]--

-- Create onScreen text object
local textObject = display.newText("Testing", 350, 100, native.Systemfont, 40)
textObject:setFillColor(0, 0, 0)
	
--------------------------------------------------------------------------------
-- Load Map
--------------------------------------------------------------------------------
function loadMap()

	
	system.setAccelerometerInterval( 50)
	-- Create player sprite sheet
	local playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", 
			   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	
	-- Create player/ball object to map
	player1.imageObject = display.newSprite(playerSheet, spriteOptions.player)
	ball = player1.imageObject
	ball.name = "player"
	ball:setSequence("move")
	ball:play()
	
	-- add physics to ball
	physics.addBody(ball, {radius = 38, bounce = .25})
	ball.linearDamping = 3
	-- Load in map
	gui = loadLevel.createLevel(mapData, ball)
	
	gui.front:insert(textObject)
end

--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
--------------------------------------------------------------------------------

-- control mechanic
local function controlMovement(event) 
	print("controlMovement(event)")
	
	-- call accelerometer to get data
	if gameData.isShowingMiniMap == false then
		physicsParam = movementMechanic.onAccelerate(event)
		ball:pause()
		if(physicsParam.xGrav ~= 0 or physicsParam.yGrav ~= 0) then
			player1:rotate(physicsParam.xGrav, physicsParam.yGrav)
			ball:play()
		end
		--[[
		print('xRot=', physicsParam.xRot)
		print('yRot=', physicsParam.yRot)
		--scale for speed of animation will move later
		if physicsParam.xRot >= physicsParam.yRot then
			scale = physicsParam.xRot
		else
			scale = physicsParam.yRot
		end
		if scale >= .05 then
			ball.timeScale = 1-scale
			print("scale=",1-scale)
		end]]
		
		--change physics gravity
		ball:applyForce(physicsParam.xGrav, physicsParam.yGrav, ball.x, ball.y)
		physics.setGravity(0,0)
	end
	
end

-- swipe mechanic
local function swipeMechanics(event)
	--print("swipeMechanics(event)")
	
	local tempPane = mapData.pane

	-- call swipe mechanic and get new Pane
	touch.touchScreen(event, mapData, player1, physics)
	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase and mapData.pane ~= tempPane then

		-- delete everything on map
		gui.back:remove(1)
		-- Pause physics
		physics.pause()
		---------------------------------------------------
		-- Play "character" teleportation animation here --
		---------------------------------------------------
		-- Resume physics
		physics.start()
		
		-- load map
		map = loadLevel.changePane(mapData)
		-- insert objects onto map layer
		gui.back:insert(map)
		map.layer["tiles"]:insert(ball)
		
		-- Reassign game mechanic listeners
		collisionDetection.changeCollision(ball, player1, mapData)
	end
	
end

--------------------------------------------------------------------------------
-- Core Game Loop
--------------------------------------------------------------------------------
local function gameLoop(event)
	-----------------------------
	--[[ START GAMEPLAY LOOP ]]--
	-- If game has started do:
	if gameData.gameStart then
	
		-- Stop BGM
		sound.stopBGM(event)
		-- Start physics
		physics.start()
		-- Load Map
		loadMap()

		print("Game Start!")
	
		-- Start mechanics
		collisionDetection.createCollisionDetection(ball, player1, mapData, gui.back[1])
		Runtime:addEventListener("accelerometer", controlMovement)
		gui.back:addEventListener("touch", swipeMechanics)
		menu.ingameOptionsbutton(event)
		
		-- Re-evaluate gameData booleans
		gameData.BGM = 2
		gameData.menuOn = false
		gameData.BGM = false
		gameData.ingame = true
		gameData.showMiniMap = true
		gameData.gameStart = false
	end
	
	----------------------
	--[[ IN-GAME LOOP ]]--
	-- If in-game has started do:
	--if gameData.ingame then
		--print(display.fps)
	--end
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
			sound.playBGM(event, sound.mainmenuSound)
		end
								
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
		ball:removeEventListener("accelerometer", controlMovement)
		
		-- Re-evaluate gameData booleans
		gameData.ingame = false
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
		Runtime:addEventListener("accelerometer", controlMovement)
		
		-- Re-evaluate gameData booleans
		gameData.inGameOptions = false
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

--------------------------------------------------------------------------------
-- Memory Check (http://coronalabs.com/blog/2011/08/15/corona-sdk-memory-leak-prevention-101/)
--------------------------------------------------------------------------------
local prevTextMem = 0
local prevMemCount = 0
local monitorMem = function()
collectgarbage()

local memCount = collectgarbage("count")
	if (prevMemCount ~= memCount) then
		print( "MemUsage: " .. memCount)
		textObject.text = "MemUsage: " .. memCount
		prevMemCount = memCount
	end
	local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
	if (prevTextMem ~= textMem) then
		prevTextMem = textMem
		print( "TexMem: " .. textMem )
	end
	
	-- Display fps
	--print(display.fps)
end

Runtime:addEventListener( "enterFrame", monitorMem )
--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------

