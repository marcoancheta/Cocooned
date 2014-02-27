--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- selectLvl.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua file that holds functionailty for level select system

--------------------------------------------------------------------------------
-- Load in Classes [Go to gameLoop.lua for class details]
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local math_abs = math.abs
local physics = require("physics") 
local animation = require("animation")
local dusk = require("Dusk.Dusk")
local gameData = require("gameData")
local objects = require("objects")
local goals = require("goals")
local loading = require("loadingScreen")
local player = require("player")
local movementMechanic = require("Accelerometer")
local movement = require("movement")

--------------------------------------------------------------------------------
-- Local Variables
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------

-- Local mapData array clone
local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0
}

-- Local Arrays
local kCircle = {} -- Color Circle Array
local levels = {}  -- Level Indicator Array
local lockedLevels = {}

-- Local Variables
local levelGUI
local dPad
local map, bg
local player1, ball
local silKipcha
local player1Sheet
local camera
local loaded = 0

-- Local Booleans
local trackplayer1 = true
local allowPlay = true

-- loading screen functions
local levelNumber = -1 -- -1 for level select (used for cutscenes)
local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(levelNumber) end

--------------------------------------------------------------------------------
-- Create camera
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createCamera(map)
	camera = display.newCircle(100, 100, 30)
	camera.strokeWidth = 5
	camera:setStrokeColor(1, 0, 0)
		
	map.layer["tiles"]:insert(camera)
	map.setCameraFocus(camera)
	map.setTrackingLevel(0.1)
end

--------------------------------------------------------------------------------
-- Create portals - Assign portals names and positions
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createPortals(map)
	-- Create level numbers
	lvlNumber = {	
		[1] = "T", [2] = "1", [3] = "2",
		[4] = "3", [5] = "4", [6] = "5",
		[7] = "6", [8] = "7", [9] = "8",
		[10] = "9", [11] = "10", [12] = "11",
		[13] = "12", [14] = "13", [15] = "14",
		[16] = "15", [17] = "F", [18] = "bonus"
	}
	
	-- Level numbers' position
	textPos = {
		--      X,         Y,
		[1] = 750,   [2] = 800,  -- T
		[3] = -250,  [4] = 305,  -- 1
		[5] = -65,  [6] = 175,  -- 2
		[7] = 720,  [8] = 150,  -- 3
		[9] = 1500, [10] = 190, -- 4
		[11] = 1700, [12] = 320, -- 5
		[13] = 1625, [14] = 700, -- 6
		[15] = 1800, [16] = 900, -- 7
		[17] = 1625, [18] = 1100, -- 8
		[19] = 1700, [20] = 1500,  -- 9
		[21] = 1500, [22] = 1650, -- 10
		[23] = 720, [24] = 1700,  -- 11
		[25] = -65, [26] = 1650,  -- 12
		[27] = -250, [28] = 1500,  -- 13
		[29] = -210, [30] = 1100,  -- 14
		[31] = -380, [32] = 900,  -- 15
		[33] = 750, [34] = 1100,  -- F
		[35] = -210, [36] = 700  -- Bonus
	}
		
	for i=1, #lvlNumber do
		-- Make & assign attributes to the 10 circles (kCircle[array])
		kCircle[i] = display.newCircle(textPos[2*i-1] + 500, textPos[2*i], 35)
		kCircle[i].name = lvlNumber[i]
		kCircle[i]:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862)
		kCircle[i]:setStrokeColor(1, 1, 1)
		kCircle[i].strokeWidth = 5

		-- Along with its text indicator (levels[array])
		levels[i] = display.newText(lvlNumber[i], textPos[2*i-1]+ 500, textPos[2*i], native.Systemfont, 35)
		levels[i]:setFillColor(0, 0, 0)
		map.layer["tiles"]:insert(kCircle[i])
		map.layer["tiles"]:insert(levels[i])
		
		-- Unlock && lock levels
		if i~=2 then		   
			lockedLevels[i] = display.newImage("graphics/lock.png")
			lockedLevels[i].x = kCircle[i].x
			lockedLevels[i].y = kCircle[i].y
			lockedLevels[i]:scale(0.2, 0.2)
			map.layer["tiles"]:insert(lockedLevels[i])
			kCircle[i].isAwake = false
		else		
			kCircle[i].isAwake = true
		end
	end
	
	-- Loading Screen delay
	timer.performWithDelay(1, myClosure)
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Derrick [Derived from Marco's loadMap() in gameLoop.lua]
--------------------------------------------------------------------------------
local function loadMap()
	physics.setScale(45)
	
	-- Initialize player(s)
	player1 = player.create()
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
	ball.linearDamping = 1.5
	ball.density = .3
	ball.x = 800
	ball.y = 500

	-- Create levelSelector Background
	bg = display.newImage("mapdata/art/iceBg.png", 0, 0, true)
	bg.x = 1930
	bg.y = 1300
	bg:scale(4, 4)
	
	-- Load in map
	map = dusk.buildMap("mapdata/levels/LS/levelSelect.json")
		
	-- Apply map properties to objects in Tiled
	for check=1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].name == "wall" then
			physics.addBody(map.layer["tiles"][check], "static", {bounce=0})
			map.layer["tiles"][check].collType = wall
			map.layer["tiles"][check].isEnabled = true
		end
	end
	
	-- Callers:
	--		+ createPortals [create level portals]
	--		+ createCamera	[create/initialize player camera]
	createPortals(map)
	createCamera(map)
	
	-- Insert ball to map last
	map.layer["tiles"]:insert(ball)
end

--------------------------------------------------------------------------------
-- Stop Animation - function that stops animation of player1
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function stopAnimation(event)
	player1:setSequence("still")
	player1:play()
	allowPlay = true
end

--------------------------------------------------------------------------------
-- Camera Tracker - track player position at all times in levelSelector
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function setCameratoPlayer(event)
	map.updateView()
	
	map.setCameraFocus(ball)
	map.setTrackingLevel(0.1)
		
	moveX = camera.x - ball.x
	moveY = camera.y - ball.y
	
	bg.x = bg.x + moveX
	bg.y = bg.y + moveY
	
	camera.x = ball.x
	camera.y = ball.y

end

--------------------------------------------------------------------------------
-- Control Mechanics - controls movement for player1
--------------------------------------------------------------------------------
-- Updated by: Derrick [Derived from Andrews's controlMovement() in gameLoop.lua]
--------------------------------------------------------------------------------
local function controlMovement(event) 
	-- call accelerometer to get data
	physicsParam = movementMechanic.onAccelerate(event, player1)

	-- set player1's X and Y gravity times the player1's curse
	player1.xGrav = physicsParam.xGrav*player1.curse
	player1.yGrav = physicsParam.yGrav*player1.curse

	movement.moveAndAnimate(player1)
end

--------------------------------------------------------------------------------
-- Select Loop - Select Level Loop
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function selectLoop(event)
	-- Create GUI display levels
	levelGUI = display.newGroup()
	levelGUI.front = display.newGroup()
	levelGUI.back = display.newGroup()
	levelGUI:insert(levelGUI.back)
	levelGUI:insert(levelGUI.front)

	-- Loading screen 
	loaded = 0 --current loading checkpoint, max is 6
	loading.loadingInit() -- initializes loading screen assets and displays them on top
	
	--start physics when everything is finished loading
	physics.start()
	physics.setGravity(0, 0)
	
	-- Callers
	loadMap()
	Runtime:addEventListener("accelerometer", controlMovement)
	Runtime:addEventListener("enterFrame", setCameratoPlayer)
	
	levelGUI.back:insert(bg)
	levelGUI.back:insert(map)	
			
	-- Loading Screen delay
	timer.performWithDelay(2000, deleteClosure)
end

local function clean()

	-- Disable event listeners
	Runtime:removeEventListener("accelerometer", controlMovement)
	Runtime:removeEventListener("enterFrame", setCameratoPlayer)
	
	-- Disable on-screen items
	levelGUI:removeSelf()
	levelGUI = nil
	
	ball:removeSelf()
	ball = nil
	
	camera:removeSelf()
	camera = nil
	
	-- Remove and destroy all circles
	for p=1, #kCircle do
		display.remove(kCircle[p])
		display.remove(levels[p])
		display.remove(lockedLevels[p])
		map.layer["tiles"]:remove(kCircle[p])
		map.layer["tiles"]:remove(levels[p])
	end
	
	kCircle = nil

	-- Destroy map object
	map.destroy()
	map:removeSelf()
	map = nil

	-- Stop physics && Send data to start game
	physics.stop()
	gameData.gameStart = true
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
selectLevel.selectLoop = selectLoop

return selectLevel

-- end of selectLevel.lua