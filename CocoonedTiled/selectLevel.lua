--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- selectLvl.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Load in files
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

local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end

local function stopAnimation(event)
	player:setSequence("still")
	player:play()
	allowPlay = true
end

-- Quick function to make all buttons uniform
local function newButton(parent) 
	local butt = display.newRoundedRect(parent, 0, 0, 60, 60, 10) 
	      butt:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862) 
		  butt:setStrokeColor(1, 1, 1)
		  butt.strokeWidth = 3
   return butt 
end

-- Point in rect, using Corona objects rather than a list of coordinates
local function pointInRect(point, rect) 
	return (point.x <= rect.contentBounds.xMax) and 
		   (point.x >= rect.contentBounds.xMin) and 
		   (point.y <= rect.contentBounds.yMax) and 
		   (point.y >= rect.contentBounds.yMin) 
end

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

-- Select Level Loop
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

	bg = display.newImage("mapdata/art/bgLS.png", 0, 0, true)
	bg.x = 1930
	bg.y = 1150
	
	-- Load image sheet
	playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", 
				   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	timer.performWithDelay(500, myClosure) -- first loading checkpoint					   
	-- Create player
	player = display.newSprite(playerSheet, spriteOptions.player)
	player.speed = 250
	player.title = "player"
	player:scale(0.8, 0.8)

	-- Create play button
	silKipcha = display.newImage("graphics/sil_kipcha.png", 0, 0, true)
	silKipcha.x = 1300
	silKipcha.y = 725
	silKipcha:scale(1.5, 1.5)
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

	timer.performWithDelay(400, myClosure)
	
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
		[1] = 150,   [2] = 205,  -- T
		[3] = 420,  [4] = 205,  -- 1
		[5] = 690,  [6] = 205,  -- 2
		[7] = 960,  [8] = 205,  -- 3
		[9] = 1225, [10] = 205, -- 4
		[11] = 420, [12] = 420, -- 5
		[13] = 690, [14] = 420, -- 6
		[15] = 960, [16] = 420, -- 7
		[17] = 1225, [18] = 420, -- 8
		[19] = 420, [20] = 635,  -- 9
		[21] = 690, [22] = 635, -- 10
		[23] = 960, [24] = 635,  -- 11
		[25] = 1225, [26] = 635,  -- 12
		[27] = 420, [28] = 850,  -- 13
		[29] = 690, [30] = 850,  -- 14
		[31] = 960, [32] = 850,  -- 15
		[33] = 1225, [34] = 850,  -- F
		[35] = 150, [36] = 420   -- Bonus
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
		if i~=2 and i~=18 then
		   
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
	timer.performWithDelay(1500, myClosure)
	-- Add physics
	physics.addBody(player, "static", {radius = 0.1}) -- to player
	physics.addBody(cameraTRK, "dynamic", {radius = 0.1}) -- to invisible camera
	
	-- Turn off collision for invisible camera
	cameraTRK.isSensor = true
	cameraTRK.isAwake = true
	
	-- Set player start position
	player.x = textPos[1] + 500
	player.y = textPos[1] + 175
	
	-- Insert objects/groups to their proper display group
	levelGUI:insert(levelGUI.back)
	levelGUI:insert(levelGUI.front)
	levelGUI.back:insert(map)
	levelGUI.back:insert(bg)
	levelGUI.front:insert(silKipcha)
	levelGUI.front:insert(dPad)

	bg:toBack()
	timer.performWithDelay(2000, myClosure)
	selectLevel.levelNum = kCircle[1].name
	kCircle[1].isAwake = true
	kCircle[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	timer.performWithDelay(2500, myClosure)
	-- Insert objects into map layer "tiles"
	map.layer["tiles"]:insert(player)
	map.layer["tiles"]:insert(cameraTRK)
	
	for i=1, #kCircle do
		kCircle[i]:addEventListener("tap", tapOnce)
	end
	
	silKipcha:addEventListener("tap", tapOnce)
	dPad:addEventListener("touch", tapOnce)
	Runtime:addEventListener("enterFrame", setCameratoPlayer)
	timer.performWithDelay(3000, myClosure)
	timer.performWithDelay(4000, loading.deleteLoading)
end
	

-- When player tap's levels once:
function tapOnce(event)
	goals.refresh()
	
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
				kCircle[p]:removeEventListener("tap", tapOnce)
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


selectLevel.selectLoop = selectLoop

return selectLevel
