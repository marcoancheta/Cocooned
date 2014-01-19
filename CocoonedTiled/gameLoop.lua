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
physics.setGravity(0, 10)
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

--------------------------------------------------------------------------------
-- add in main menu
--------------------------------------------------------------------------------

local main = require("menu")

--------------------------------------------------------------------------------
-- add in mechanics
--------------------------------------------------------------------------------

local switchPaneMechanic = require("switchPane")
local movementMechanic = require("accelerometer")
local collisionDetection = require("collisionDetection")

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

	

	map = dusk.buildMap("mapdata/levels/temp/M.json")
	gui.back:insert(map)

	ball = display.newImage("mapdata/graphics/ball 1.png")
	physics.addBody(ball, {radius = 38, bounce = .25})
	map:insert(ball)
	ball.name = "player"

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
	physicsParam = movementMechanic.onAccelerate(event)

	--change physics gravity
	physics.setGravity(physicsParam.xGrav, physicsParam.yGrav)
end

-- swipe mechanic
local function swipeMechanics(event)

	local tempPane = mapData.pane

	-- call swipe mechanic and get new Pane
	switchPaneMechanic.switchP(event, mapData)
	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase and mapData.pane ~= tempPane then
		physics.stop()
		physics.start()
		physics.addBody(ball, {radius = 38, bounce = .25})
		map = dusk.buildMap("mapdata/levels/temp/" .. mapData.pane .. ".json")
		collisionDetection.changeCollision(ball)
		--gui.back:insert(map)
		map.layer["tiles"]:insert(ball)
	end
end


--------------------------------------------------------------------------------
-- Game Loop
--------------------------------------------------------------------------------

local function gameLoop (event)

	--map.updateView()
	
	-- Start game play once "play" is tapped
	-- Only call these event listeners once
	if gameData.gameStart then

		
		-- Start physics engine
		physics.start()
		-- load in map
		loadMap()

		-- start collision detection for player ball
		collisionDetection.createCollisionDetection(ball)

		-- start other mechanics for levels
		map:addEventListener("touch", swipeMechanics)
		gui:addEventListener( "accelerometer", controlMovement)
		print("Gameplay in Progress")

		-- set global gameStart to false so it will only be called once
		gameData.gameStart = false

	-- If game Start is false then start the mainMenu
	-- Only call this event once so game isn't laggy
	elseif gameData.menuOn then
		main.MM(event)
		gameData.menuOn = false
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
		--print( "MemUsage: " .. memCount)
		prevMemCount = memCount
	end
	local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
	if (prevTextMem ~= textMem) then
		prevTextMem = textMem
		--print( "TexMem: " .. textMem )
	end
end

Runtime:addEventListener( "enterFrame", monitorMem )
--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------

return global
