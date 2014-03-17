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
local loading = require("loadingScreen")
local player = require("player")
local movementMechanic = require("Accelerometer")
local movement = require("movement")
local goals = require("goals")

local physicsData = (require "levels.lvlselect_collision.walls").physicsData(1.0)

local loaded = 0

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
local map, bg
local player1, ball
local player1Sheet
local loaded = 0

-- loading screen functions
local levelNumber = -1 -- -1 for level select (used for cutscenes)
local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(levelNumber) end

--------------------------------------------------------------------------------
-- Ball Camera
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function camera(event)
	movement.moveAndAnimate(event, player1)

	-- Set Camera to Ball
	map.setCameraFocus(ball)
	map.setTrackingLevel(0.1)
end

--------------------------------------------------------------------------------
-- Local Collision Detection: Ball vs Portals
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function onLocalCollision(self, event)
	for i=1, #lvlNumber do
		if event.other.x == kCircle[i].x and event.other.y == kCircle[i].y then
			event.other.isSensor = true
						
			local pause = function() physics.start(); event.other.isBodyActive = false; end
			local begin = function() event.other.isBodyActive = true; end

			local trans = transition.to(ball, {time = 1500, x = kCircle[i].x, y = kCircle[i].y - 15, onComplete = function() 
																physics.pause(); timer.performWithDelay(1000, pause); 
																				 timer.performWithDelay(5000, begin); end})				
			
			selectLevel.levelNum = kCircle[i].name
	
			goals.refresh()
			goals.findGoals(selectLevel)
					
			-- Level unlocked? Then create play button, else do nothing.
			-- Unlock play button for level (i == levelNum+1)
			if i == 1 or i == 2 or i == 4 then
				play.isVisible = true
				play:toFront()
			else
				play.isVisible = false
			end
			
		end
	end
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function tapOnce(event)
	-- Kipcha Play button detection
	-- If player1 taps silhouette kipcha, start game
	if event.target.name == play.name then
		gameData.inLevelSelector = true
	
		------------------------------------------------------------
		-- remove all objects
		------------------------------------------------------------
		transition.cancel()
		--timer.cancel(ball)
		
		-- Destroy goals map
		goals.destroyGoals()
				
		gameData.gameStart = true
	end		
end

--------------------------------------------------------------------------------
-- Control Mechanics - controls movement for player1
--------------------------------------------------------------------------------
-- Updated by: Derrick [Derived from Andrews's controlMovement() in gameLoop.lua]
--------------------------------------------------------------------------------
local function controlMovement(event)
 	--ball:setSequence("move")
	--ball:play()
	
	-- call accelerometer to get data
	physicsParam = movementMechanic.onAccelerate(event, player1, map)

	-- set player1's X and Y gravity times the player1's curse
	player1.xGrav = physicsParam.xGrav
	player1.yGrav = physicsParam.yGrav
				
end


--------------------------------------------------------------------------------
-- Create play button and level details
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createLevelPlay()
	-- Create play button
	play = display.newImage("mapdata/art/buttons/sil_kipcha.png", 0, 0, true)
	play.x = 1280
	play.y =150
	play:scale(2, 2)
	play.name = "playButton"
	play.isVisible = false
	
	play:addEventListener("tap", tapOnce)
end

--------------------------------------------------------------------------------
-- Select Level Core Loop
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function selectLoop(event)
	loaded = 0 --current loading checkpoint, max is 6
	-- Start physics
	physics.start()
	physics.setGravity(0, 0)
	--------------------------------------------------------------------------------
	-- Initialize local variables
	--------------------------------------------------------------------------------
	levelGUI = display.newGroup()
	levelGUI.front = display.newGroup()
	levelGUI.back = display.newGroup()

	loading.loadingInit() -- initializes loading screen assets and displays them on top
	
	-- Create Arrays
	kCircle = {} -- Color Circle Array
	levels = {}  -- Level Indicator Array
	lockedLevels = {} -- Locked Levels Array
			
end


--------------------------------------------------------------------------------
-- Create portals - Assign portals names and positions
---------------------------------------------------	-----------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createPortals(map)
	-- Create level numbers
	lvlNumber = {	
		[1] = "1", [2] = "2", [3] = "3",
		[4] = "4", --[[[5] = "5", [6] = "6",
		[7] = "7", [8] = "8", [9] = "9",
		[10] = "10", [11] = "11", [12] = "12",
		[13] = "13", [14] = "14", [15] = "15",
		[16] = "16", [17] = "F", [18] = "bonus"]]--
	}
	
	-- Level numbers' position
	textPos = {
		--      X,         Y,
		 [1] = -60,   [2] = 555,   -- 1
		 [3] = 205,   [4] = 355,    -- 2
		 [5] = 460,   [6] = 355,   -- 3 
		 [7] = 710,   [8] = 555,    -- 4
		--[[ [9] = 710,  [10] = 515,   -- 5
		[11] = 1800, [12] = 300,  -- 6
		[13] = 1750, [14] = 650,  -- 7
		[15] = 1950, [16] = 900,  -- 8
		[17] = 1750, [18] = 1100, -- 9
		[19] = 1850, [20] = 1500, -- 10
		[21] = 1600, [22] = 1650, -- 11
		[23] = 770,  [24] = 1700,  -- 12
		[25] = -60,  [26] = 1650,  -- 13
		[27] = -250, [28] = 1500, -- 14
		[29] = -200, [30] = 1100, -- 15
		[31] = -380, [32] = 850,  -- 16
		[33] = 750,  [34] = 1100,  -- F
		[35] = -200, [36] = 700   -- Bonus]]--
	}
	
	local kCircleSheet = graphics.newImageSheet("mapdata/art/animation/exitPortalSheet.png", 
				 {width = 72.5, height = 39, sheetContentWidth = 362, sheetContentHeight = 39, numFrames = 5})
		
		
	for i=1, #lvlNumber do
		-- Make & assign attributes to the 10 circles (kCircle[array])
		--kCircle[i] = display.newCircle(textPos[2*i-1] + 500, textPos[2*i], 35)
		kCircle[i] = display.newSprite(kCircleSheet, spriteOptions["exitPortal"])
		kCircle[i]:scale(1.5, 1.5)
		kCircle[i].x, kCircle[i].y = textPos[2*i-1] + 500, textPos[2*i]
		kCircle[i].name = lvlNumber[i]
		kCircle[i]:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862)
		physics.addBody(kCircle[i], "static", {bounce=0})

		-- Along with its text indicator (levels[array])
		levels[i] = display.newText(lvlNumber[i], textPos[2*i-1]+ 500, textPos[2*i] - 40, native.Systemfont, 50)
		levels[i]:setFillColor(3*0.00392156862, 101*0.00392156862, 100*0.00392156862)
		--levels[i]:setFillColor(0, 0, 0)
		map.layer["tiles"]:insert(kCircle[i])
		map.layer["tiles"]:insert(levels[i])
		
		-- Unlock (i~=levelNum+1) && lock levels
		-- When unlocking levels, also add changes to line 95 of this lua file.
		if i~=1 and i~=2 and i~=4 then
			lockedLevels[i] = display.newImage("mapdata/art/buttons/lock.png")
			lockedLevels[i].x = kCircle[i].x
			lockedLevels[i].y = kCircle[i].y
			lockedLevels[i]:scale(0.2, 0.2)
			map.layer["tiles"]:insert(lockedLevels[i])
			kCircle[i].isAwake = false
			kCircle[i]:setSequence("still")
			kCircle[i]:play()
		else		
			kCircle[i]:setSequence("move")
			kCircle[i]:play()
			kCircle[i].isAwake = true
		end
	end
	
	-- Loading Screen delay
	timer.performWithDelay(1, myClosure)
end

--------------------------------------------------------------------------------
-- Load Map - loads start of level
--------------------------------------------------------------------------------
-- Updated by: Derrick [Derived from Marco's loadSelector() in gameLoop.lua]
--------------------------------------------------------------------------------
local function loadSelector()

	physics.setScale(45)
	
	-- Initialize player(s)
	player1 = player.create()
	system.setAccelerometerInterval(30)

	-- Create player sprite sheet
	local playerSheet = graphics.newImageSheet("mapdata/art/animation/AnimationRollSprite.png", 
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
	bg = display.newImage("mapdata/art/background/screens/waterBG.png", 0, 0, true)
	bg.x = 720
	bg.y = 450
	bg:scale(0.8, 0.8)
	
	-- Load in map
	map = dusk.buildMap("mapdata/levels/LS/levelSelect.json")
	
	-- Load in walls
	local wall = {
			  [1] = display.newImage("mapdata/art/background/LS/LS-BB/LS.png"), }
		   
		  wall[1].x, wall[1].y = map.tilesToPixels(22, 15)
		  map.layer["tiles"]:insert(wall[1])
		   
	for i=1, #wall do
		wall[i].isVisible = false
		--wall[i]:setFillColor(1, 0, 0, 0.5)
		physics.addBody(wall[i], "static", physicsData:get("LS") )
	end
	
	-- Callers:
	--		+ createPortals [create level portals]]
	createPortals(map)
	createLevelPlay()
	
	-- Insert ball to map last
	map.layer["tiles"]:insert(ball)
	map.layer["vWalls"].sx = map.layer["vWalls"].x
	map.layer["hWalls"].sy = map.layer["hWalls"].y
	
	ball.collision = onLocalCollision
	ball:addEventListener("collision", ball)
	Runtime:addEventListener("accelerometer", controlMovement)
	Runtime:addEventListener("enterFrame", camera)
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
	loadSelector()
		
	levelGUI.back:insert(bg)
	levelGUI.back:insert(map)
				
	-- Loading Screen delay
	timer.performWithDelay(2000, deleteClosure)
end

--------------------------------------------------------------------------------
-- Clean Up - Delete 
--------------------------------------------------------------------------------
-- Updated by: Marco - moved to end of script so it can see everything for removal
--------------------------------------------------------------------------------
local function clean()
	transition.cancel()
	--timer.cancel(ball)

	-- Disable event listeners
	Runtime:removeEventListener("accelerometer", controlMovement)
	ball:removeEventListener("collision", ball)
	Runtime:removeEventListener("enterFrame", camera)
	
	-- Disable on-screen items
	levelGUI:removeSelf()
	levelGUI = nil
	
	ball:removeSelf()
	ball = nil

	player1:destroy()
	player1 = nil
		
	play:removeSelf()
	play = nil
	
	bg:removeSelf()
	bg = nil
		
	-- Remove and destroy all circles
	for p=1, #kCircle do
		display.remove(kCircle[p])
		display.remove(levels[p])
		display.remove(lockedLevels[p])
		map.layer["tiles"]:remove(kCircle[p])
		map.layer["tiles"]:remove(levels[p])
	end
		
	kCircle = nil
	levels = nil
	lockedLevels = nil

	-- re-inialitze local variables to empty tables
	kCircle = {}
	levels = {} 
	lockedLevels = {}
	
	-- Destroy map object
	map.destroy()
	map:removeSelf()
	map = nil
				
	-- Stop physics
	physics.stop()
		
	print("CLEANED")
end


--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
selectLevel.selectLoop = selectLoop
selectLevel.camera = camera
selectLevel.clean = clean

return selectLevel

-- end of selectLevel.lua
