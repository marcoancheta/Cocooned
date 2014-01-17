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

-- Global Variables
local global = {
	gameActive = false
}

-- ball variables and add ball image
local ball = display.newImage("mapdata/graphics/ball 1.png")

physics.start()
physics.addBody(ball, {radius = 38, bounce = .25})

-- level variable
local mapData = {
	levelNum = 1,
	pane = "M",
}

--------------------------------------------------------------------------------
-- add in menu
--------------------------------------------------------------------------------

local main = require("menu")

--------------------------------------------------------------------------------
-- add in mechanics
--------------------------------------------------------------------------------

local switchPaneMechanic = require("switchPane")
local movementMechanic = require("accelerometer")

local json = require("json")

local level = require("mapdata.levels.temp.M")
print("print: ", tostring(tileset[0])


local player = require("player")
local player1 = player.create()
local player2 = player.create()
player1:changeColor('green')
player2.name = "test"

print("player name = ", player1.name)
print("player color = ", player1.color)


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

map.layer["tiles"]:insert(ball)

ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

--------------------------------------------------------------------------------
-- gameloop
--------------------------------------------------------------------------------

-- control mechanic
local function controlMovement(event) 

	-- call accelerometer to get data
	physicsParam = movementMechanic.onAccelerate(event)
	--print(physicsParam.xGrav)

	--change physics gravity
	physics.setGravity(physicsParam.xGrav, physicsParam.yGrav)
end

gui:addEventListener( "accelerometer", controlMovement)

-- swipe mechanic
local function swipeMechanics(event)
	-- call swipe mechanic
	local newPane = switchPaneMechanic.switchP(event, mapData)
	
	-- if touch ended then change map if pane is switched
	if "ended" == event.phase then
		mapData.pane = newPane
		map = dusk.buildMap("mapdata/levels/temp/" .. mapData.pane .. ".json")
		map.layer["tiles"]:insert(ball)
	end
end

map:addEventListener("touch", swipeMechanics)

local function gameLoop (event)

	map.updateView()
	
	if gameActive then
		print("Gameplay in Progress")
	else
		main.MM(event)
	end
	
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", gameLoop)

return global
