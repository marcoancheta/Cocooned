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

-- Variables we'll use often
local gui
local map


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
-- add in mechanics
--------------------------------------------------------------------------------

local switchPaneMechanic = require("switchPane")
local movementMechanic = require("accelerometer")
local json = require("json")

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

print(map.layer["objects"])

ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

--------------------------------------------------------------------------------
-- gameloop
--------------------------------------------------------------------------------

local function gameLoop (event)
	map.updateView()
end

-- control mechanic
local function controlMovement(event) 

	-- call accelerometer to get data
	physicsParam = movementMechanic.onAccelerate(event)
	--print(physicsParam.xGrav)

	--change physics gravity
	physics.setGravity(physicsParam.xGrav, physicsParam.yGrav)
end

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


--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", gameLoop)
Runtime:addEventListener("touch", swipeMechanics)
Runtime:addEventListener( "accelerometer", controlMovement)
