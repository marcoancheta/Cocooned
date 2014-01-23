--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameLoop.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local physics = require("physics")
physics.start()
--physics.setGravity(0,-10)
--physics.setDrawMode("hybrid")

local math_abs = math.abs

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- ball variables and add ball image
local ball

-- level variable
local mapData = {
	levelNum = 1,
	pane = "M",
}

-- load in global Variables
local gameData = require("gameData")
--animation Variables
require("animation")

--------------------------------------------------------------------------------
-- add in main menu
--------------------------------------------------------------------------------
local menu = require("menu")

--------------------------------------------------------------------------------
-- add in sounds
--------------------------------------------------------------------------------
local sound = require("sound")

--------------------------------------------------------------------------------
-- add in mechanics
--------------------------------------------------------------------------------

local touch = require("touchMechanic")
local movementMechanic = require("Accelerometer")
local collisionDetection = require("collisionDetection")
--local magnetismMechanic = require("magnetism")

-- tile engine
local dusk = require("Dusk.Dusk")

--------------------------------------------------------------------------------
-- create player
--------------------------------------------------------------------------------

local player = require("player")
local player1 = player.create()
local player2 = player.create()


print("player name = ", player1.name)
print("player color = ", player1.color)

--------------------------------------------------------------------------------
-- Load Map
--------------------------------------------------------------------------------
local function loadMap() 

	--------------------------------------------------------------------------------
	-- Creating display group
	--------------------------------------------------------------------------------
	gui = display.newGroup()
	gui.front = display.newGroup()
	gui.back = display.newGroup()

	gui:insert(gui.back)
	gui:insert(gui.front)
	local playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	local textObject = display.newText("Testing", 200, 100, native.Systemfont, 40)
	textObject:setFillColor(0,0,0)
	gui.front:insert(textObject)

	map = dusk.buildMap("mapdata/levels/tempNew/M.json")
	gui.back:insert(map)
	player1.imageObject = display.newSprite(playerSheet, spriteOptions.player )
	ball = player1.imageObject
	physics.addBody(ball, {player1.radius, player1.bounce})
	map:insert(ball)
	ball.name = "player"
	ball:setSequence("move")
	ball:play()
	map.layer["tiles"]:insert(ball)
	local loc = map.tilesToPixels(10,6)
	print(map.tilesToPixels(10 , 6))
	print(map.pixelsToTiles(684, 440))
	--physics = mapBuilder.buildMap("mapdata/levels/temp/M.lua", map)

	ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)
end


--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
--------------------------------------------------------------------------------

-- control mechanic
local function controlMovement(event) 

	-- call accelerometer to get data
	if gameData.isShowingMiniMap == false then
		physicsParam = movementMechanic.onAccelerate(event)
		player1:rotate(physicsParam.xGrav, physicsParam.yGrav)
		print('xRot=', physicsParam.xRot)
		print('yRot=', physicsParam.yRot)
		if physicsParam.xRot >= physicsParam.yRot then
			scale = physicsParam.xRot
		else
			scale = physicsParam.yRot
		end
		if scale >= .05 then
			ball.timeScale = 1-scale
			print("scale=",1-scale)
		end
		--change physics gravity
		physics.setGravity(physicsParam.xGrav, physicsParam.yGrav)
	end
end

-- swipe mechanic
local function swipeMechanics(event)

	local tempPane = mapData.pane

	-- call swipe mechanic and get new Pane
	touch.touchScreen(event, mapData, player1, physics)
	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase and mapData.pane ~= tempPane then
		physics.stop()
		physics.start()
		physics.addBody(ball, {radius = 38, bounce = .25})
		map:removeSelf()
		map = dusk.buildMap("mapdata/levels/tempNew/" .. mapData.pane .. ".json")
		map:addEventListener("touch", swipeMechanics)
		collisionDetection.changeCollision(ball, player1)
		gui.back:insert(map)
		map.layer["tiles"]:insert(ball)
	end
end


--------------------------------------------------------------------------------
-- Game Loop
--------------------------------------------------------------------------------
local gamehasstarted = false
local function gameLoop (event)
	
	--map.updateView()
	
	--print("inOptions", gameData.inOptions)
	--print("showMiniMap", gameData.showMiniMap)
	
	-- Start game play once "play" is tapped
	-- Only call these event listeners once
	if gameData.gameStart then
		
		-- Start physics engine
		physics.start()
		
		-- load in map
		loadMap()

		-- change gameData variables
		gameData.showMiniMap = true
		
		-- start collision detection for player ball
		collisionDetection.createCollisionDetection(ball, player1)

		-- start other mechanics for levels
		
		if gameData.inOptions == false then 
			map:addEventListener("touch", swipeMechanics)
			Runtime:addEventListener("accelerometer", controlMovement)
			menu.ingameO(event)
			gamehasstarted = true
		end
		
		print("Gameplay in Progress")
			
		-- change gameData variables
		-- set global gameStart to false so it will only be called once
		gameData.gameStart = false
		gameData.showMiniMap = true
		
	-- If game Start is false then start the mainMenu
	-- Only call this event once so game isn't laggy
	elseif gameData.menuOn then
		menu.MM(event)
		gameData.menuOn = false
	end
	
	if gameData.inOptions == true then
		gameData.showMiniMap = false
		Runtime:removeEventListener( "accelerometer", controlMovement)
	end
end

--------------------------------------------------------------------------------
-- Finish Up - Call gameLoop every 30 fps
--------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", gameLoop)

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
		prevMemCount = memCount
	end
	local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
	if (prevTextMem ~= textMem) then
		prevTextMem = textMem
		print( "TexMem: " .. textMem )
	end
end

Runtime:addEventListener( "enterFrame", monitorMem )
--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------

return global
