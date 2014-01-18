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

-- Variables
local gui
local map

-- ball variables and add ball image
local ball = display.newImage("mapdata/graphics/ball 1.png")

-- level variable
local mapData = {
	levelNum = 1,
	pane = "M",
}

-- load in global Variables
local gameData = require("gameData")

--------------------------------------------------------------------------------
-- add in menu
--------------------------------------------------------------------------------

local main = require("menu")

--------------------------------------------------------------------------------
-- add in mechanics
--------------------------------------------------------------------------------

local switchPaneMechanic = require("switchPane")
local movementMechanic = require("accelerometer")
local collisionDetection = require("collisionDetection")

--------------------------------------------------------------------------------
-- create player
--------------------------------------------------------------------------------

local player = require("player")
local player1 = player.create()
local player2 = player.create()

print("player name = ", player1.name)
print("player color = ", player1.color)

physics.start()
physics.addBody(ball, {radius = 38, bounce = .25})
physics.pause()

--------------------------------------------------------------------------------
-- Creating display group
--------------------------------------------------------------------------------
gui = display.newGroup()
gui.front = display.newGroup()
gui.back = display.newGroup()

gui:insert(gui.back)
gui:insert(gui.front)

--------------------------------------------------------------------------------
-- Load Map
--------------------------------------------------------------------------------
local dusk = require("Dusk.Dusk")

map = dusk.buildMap("mapdata/levels/temp/M.json")
gui.back:insert(map)
--gui.front:insert(test)

map:insert(ball)
ball.name = "player"

map.layer["tiles"]:insert(ball)
local loc = map.tilesToPixels(10,6)
print(map.tilesToPixels(10 , 6))
print(map.pixelsToTiles(684, 440))
--physics = mapBuilder.buildMap("mapdata/levels/temp/M.lua", map)

ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

--------------------------------------------------------------------------------
-- gameloop
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

	-- call swipe mechanic and get new Pane
	local newPane = switchPaneMechanic.switchP(event, mapData)
	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase then
		mapData.pane = newPane
		map = dusk.buildMap("mapdata/levels/temp/" .. mapData.pane .. ".json")
		map.layer["tiles"]:insert(ball)
	end
end




local function gameLoop (event)

	map.updateView()
	
	-- Start game play once "play" is tapped
	-- Only call these event listeners once
	if gameData.gameStart then

		-- Start physics engine
		physics.start()

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
-- Finish Up
--------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", gameLoop)

return global
