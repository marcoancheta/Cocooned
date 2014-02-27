--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- selectLvl.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua file that holds functionailty for level select system

--------------------------------------------------------------------------------
-- Variables
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
local loaded = 0

local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0,
}

-- Local Variables
local levelGUI
local dPad
local map, bg
local player
local silKipcha
local playerSheet
local cameraTRK

local kCircle = {} -- Color Circle Array
local levels = {}  -- Level Indicator Array
local lockedLevels = {}

-- Local Booleans
local trackPlayer = true
local trackInvisibleBoat = false
local allowPlay = true


-- loading screen functions
local levelNumber = -1 -- -1 for level select (used for cutscenes)
local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(levelNumber) end

--------------------------------------------------------------------------------
-- Stop Animation - function that stops animation of player
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local function stopAnimation(event)
	player:setSequence("still")
	player:play()
	allowPlay = true
end

--------------------------------------------------------------------------------
-- New Button - function that creates new button
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function newButton(parent) 
	local butt = display.newRoundedRect(parent, 0, 0, 60, 60, 10) 
	      butt:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862) 
		  butt:setStrokeColor(1, 1, 1)
		  butt.strokeWidth = 3
   return butt 
end

--------------------------------------------------------------------------------
-- Point in Rect - function that checks if point is in rect
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function pointInRect(point, rect) 
	return (point.x <= rect.contentBounds.xMax) and 
		   (point.x >= rect.contentBounds.xMin) and 
		   (point.y <= rect.contentBounds.yMax) and 
		   (point.y >= rect.contentBounds.yMin) 
end

--------------------------------------------------------------------------------
-- Set Camera to Player - function that makes camera follow player object
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function setCameratoPlayer(event)
	map.updateView()
	if trackPlayer then
		trackInvisibleBoat = false
		-- Set up map camera
		map.setCameraFocus(player)
		map.setTrackingLevel(0.1)

		movex = cameraTRK.x - player.x
		movey = cameraTRK.y - player.y

		bg.x = bg.x + movex
		bg.y = bg.y + movey
		
		cameraTRK.x = player.x
		cameraTRK.y = player.y
	elseif trackInvisibleBoat then
		trackPlayer = false
		map.setCameraFocus(cameraTRK)
		map.setTrackingLevel(0.1)
	end
	
	local vx, vy = cameraTRK:getLinearVelocity()

	--movement of bg
	if vx < 0 then	bg.x = bg.x + 8.25
	elseif vx > 0 then bg.x = bg.x - 8.25
	elseif vy < 0 then bg.y = bg.y + 8.25
	elseif vy > 0 then bg.y = bg.y - 8.25
	end
	
end

--------------------------------------------------------------------------------
-- Select Loop - Select Level Loop
--------------------------------------------------------------------------------
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
	dPad = display.newGroup()
	loading.loadingInit() -- initializes loading screen assets and displays them on top
	
	-- Create Arrays
	kCircle = {} -- Color Circle Array
	levels = {}  -- Level Indicator Array
	lockedLevels = {} -- Locked Levels Array
	
	-- Load Map
	map = dusk.buildMap("mapdata/levels/LS/levelSelect.json")
	
	for check=1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].name == "wall" then
			physics.addBody(map.layer["tiles"][check], "static",
							{bounce=0})
			map.layer["tiles"][check].collType = wall
			map.layer["tiles"][check].isEnabled = true
		end
	end

	bg = display.newImage("mapdata/art/iceBg.png", 0, 0, true)
	bg.x = 1930
	bg.y = 1300
	bg:scale(2, 2.5)
	
	-- Load image sheet
	playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", 
				   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	-- Create player
	player = display.newSprite(playerSheet, spriteOptions.player)
	player.speed = 250
	player.title = "player"
	player:scale(0.8, 0.8)

	-- Create play button
	silKipcha = display.newImage("graphics/sil_kipcha.png", 0, 0, true)
	silKipcha.x = 1290
	silKipcha.y = 720
	silKipcha:scale(2, 2)
	silKipcha.name = "sillykipchatrixareforkids"

	-- Create invisible camera tracker
	cameraTRK = display.newImage("mapdata/art/invisibleBoat.png", 0, 0, true)
	cameraTRK.speed = 500
	
	-- Create dPad
	dPad.result = "n"
	dPad.prevResult = "n"
	
	-- Create dPad buttons and position them
	dPad.l = newButton(dPad); dPad.l.x, dPad.l.y = -60, 0 
	dPad.r = newButton(dPad); dPad.r.x, dPad.r.y = 60, 0
	dPad.u = newButton(dPad); dPad.u.x, dPad.u.y = 0, -60 
	dPad.d = newButton(dPad); dPad.d.x, dPad.d.y = 0, 60
	
	-- Assign names to dPad
	dPad.l.name = "l"
	dPad.r.name = "r"
	dPad.u.name = "u"
	dPad.d.name = "d"
	
	-- Position dPad buttons
	dPad.x = display.screenOriginX + dPad.contentWidth * 0.5 + 40
	dPad.y = display.contentHeight - dPad.contentHeight * 0.5 - 40

	
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
	timer.performWithDelay(1, myClosure)
	-- Add physics
	physics.addBody(player, "static", {radius = 0.1}) -- to player
	physics.addBody(cameraTRK, "dynamic", {radius = 0.1}) -- to invisible camera
	
	-- Turn off collision for invisible camera
	cameraTRK.isSensor = true
	cameraTRK.isAwake = true
	
	-- Set player start position
	player.x = 1250
	player.y = 950
	
	-- Insert objects/groups to their proper display group
	levelGUI:insert(levelGUI.back)
	levelGUI:insert(levelGUI.front)
	levelGUI.back:insert(map)
	levelGUI.back:insert(bg)
	levelGUI.front:insert(silKipcha)
	levelGUI.front:insert(dPad)

	bg:toBack()
	selectLevel.levelNum = kCircle[1].name
	kCircle[1].isAwake = true
	kCircle[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	-- Insert objects into map layer "tiles"
	map.layer["tiles"]:insert(player)
	map.layer["tiles"]:insert(cameraTRK)
	
	--for i=1, #kCircle do
	--	kCircle[i]:addEventListener("tap", tapOnce)
	--end
	
	silKipcha:addEventListener("tap", tapOnce)
	dPad:addEventListener("touch", tapOnce)
	Runtime:addEventListener("enterFrame", setCameratoPlayer)

	timer.performWithDelay(2000, deleteClosure)
end
	

--------------------------------------------------------------------------------
-- Tap Once - function is called when player taps screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
function tapOnce(event)
	goals.refresh()
	
	--[[
	-- kCircles button detection
	for i=1, #kCircle do
		if event.target.name == kCircle[i].name then
			trackPlayer = true
			if event.numTaps == 1 and kCircle[i].isAwake then
								
				selectLevel.levelNum = kCircle[i].name
				allowPlay = false
				-- Move kipcha to the selected circle
				transition.to(player, {time = 1000, x = kCircle[i].x, y = kCircle[i].y, onComplete=stopAnimation})
				player.rotation = 90
				player:setSequence("move")
				player:play()
			
				kCircle[i]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
					
				goals.findGoals(selectLevel)
					
				-- Send signal to refresh sent mapData
				gameData.inLevelSelector = true
			end
		else
			for j=1, #kCircle do
				if kCircle[j].name ~= event.target.name then
					kCircle[j]:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862)
				end
			end
		end
	end
	]]--


	-- dPad Button detection
	if event.target.name == dPad.l.name or dPad.r.name or dPad.u.name or dPad.d.name then
		if event.target.isFocus or "began" == event.phase then
			dPad.prevResult = dPad.result
			-- Set result according to where touch is
					if pointInRect(event, dPad.l) then dPad.result = "l"
				elseif pointInRect(event, dPad.r) then dPad.result = "r"
				elseif pointInRect(event, dPad.u) then dPad.result = "u"
				elseif pointInRect(event, dPad.d) then dPad.result = "d"
			end
		end

		-- Just a generic touch listener
		if "began" == event.phase then
			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true
			trackPlayer = false
			trackInvisibleBoat = true	
		elseif event.target.isFocus then
			if "ended" == event.phase or "cancelled" == event.phase then
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
				dPad.result = "n"
				dPad.l.alpha = 1; dPad.r.alpha = 1; 
				dPad.u.alpha = 1; dPad.d.alpha = 1
			end
		end

		-- Did the direction change?
		if dPad.prevResult ~= dPad.result then 
			dPad.changed = true 
		end
		
		-- Set player velocity according to movement result
		if dPad.result == "l" then cameraTRK:setLinearVelocity(-cameraTRK.speed, 0)
		elseif dPad.result == "r" then cameraTRK:setLinearVelocity(cameraTRK.speed, 0)
		elseif dPad.result == "u" then cameraTRK:setLinearVelocity(0, -cameraTRK.speed)
		elseif dPad.result == "d" then cameraTRK:setLinearVelocity(0, cameraTRK.speed)
		elseif dPad.result == "n" then cameraTRK:setLinearVelocity(0, 0)
		end
		
	end
	
	
	-- Kipcha Play button detection
	if allowPlay then
		-- If player taps silhouette kipcha, start game
		if event.target.name == silKipcha.name then

			------------------------------------------------------------
			-- remove all objects
			------------------------------------------------------------
			-- Destroy goals map
			goals.destroyGoals()
			
			trackPlayer = true
			trackInvisibleBoat = false

			-- remove eventListeners		
			silKipcha:removeEventListener("tap", tapOnce)
			Runtime:removeEventListener("enterFrame", setCameratoPlayer)
			dPad:removeEventListener("touch", tapOnce)
			
			--	Clean up on-screen items
			levelGUI:removeSelf()
			levelGUI = nil
			dPad:removeSelf()
			dPad = nil
			player:removeSelf()
			player = nil
			cameraTRK:removeSelf()
			cameraTRK = nil
			silKipcha:removeSelf()
			silKipcha = nil
			
			-- remove and destroy all circles
			for p=1, #kCircle do
				display.remove(kCircle[p])
				display.remove(levels[p])
				display.remove(lockedLevels[p])
				--kCircle[p]:removeEventListener("tap", tapOnce)
				map.layer["tiles"]:remove(kCircle[p])
				map.layer["tiles"]:remove(levels[p])
			end
			kCircle = nil

			-- destroy map object
			map.destroy()
			map:removeSelf()
			map = nil

			physics.stop()
			
			-- Send data to start game
			gameData.gameStart = true
		end
	end
		
	return true
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
selectLevel.selectLoop = selectLoop

return selectLevel

-- end of selectLevel.lua
