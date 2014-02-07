--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- selectLvl.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Load in files
--------------------------------------------------------------------------------
local physics = require("physics") 
	  physics.start()
	  physics.setGravity(0, 0)
local math_abs = math.abs
local animation = require("animation")
local dusk = require("Dusk.Dusk")
local gameData = require("gameData")

local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0,
}

local map
local player
local levelGUI
local trackPlayer = true
local trackInvisibleBoat = false
local allowPlay = true

local function setCameratoPlayer(event)
	
	if trackPlayer then
		-- Set up map camera
		map.setCameraFocus(player)
		map.setTrackingLevel(0.1)
	elseif trackInvisibleBoat then
		map.setCameraFocus(cameraTRK)
		map.setTrackingLevel(0.1)
	end
	
	if trackInvisibleBoat == false then
		cameraTRK.x = player.x
		cameraTRK.y = player.y
	end
end

local function stopAnimation(event)
	player:setSequence("still")
	player:play()
	allowPlay = true
end

-- Select Level Loop
local function selectLoop(event)
	--------------------------------------------------------------------------------
	-- Initialize local variables
	--------------------------------------------------------------------------------
	levelGUI = display.newGroup()
	levelGUI.front = display.newGroup()
	levelGUI.back = display.newGroup()

	levelGUI:insert(levelGUI.back)
	levelGUI:insert(levelGUI.front)
		
	--------------------------------------------------------------------------------
	-- Load Map
	--------------------------------------------------------------------------------
	map = dusk.buildMap("mapdata/levels/LS/levelSelect.json")
	levelGUI.back:insert(map)
		
	--------------------------------------------------------------------------------
	-- Load in image sheet
	--------------------------------------------------------------------------------
	local playerSheet = graphics.newImageSheet("mapdata/graphics/AnimationRollSprite.png", 
				   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	--------------------------------------------------------------------------------
	-- Create player
	--------------------------------------------------------------------------------
	player = display.newSprite(playerSheet, spriteOptions.player)
	player.speed = 250
	player.title = "player"
	player:scale(0.8, 0.8)

	physics.addBody(player, "static", {radius = 0.1})

	silKipcha = display.newImage("graphics/sil_kipcha.png", 0, 0, true)
	silKipcha.x = 1300
	silKipcha.y = 725
	silKipcha:scale(1.5, 1.5)
	silKipcha.name = "sillykipchatrixareforkids"
	levelGUI.front:insert(silKipcha)

	cameraTRK = display.newImage("mapdata/art/invisibleBoat.png", 0, 0, true)
	cameraTRK.speed = 500
	cameraTRK.title = "camera"
		
	physics.addBody(cameraTRK, "dynamic", {radius = 0.1})
	cameraTRK.isSensor = true
	
	lvlNumber = {	
		[1] = "T", [2] = "1", [3] = "2",
		[4] = "3", [5] = "4", [6] = "5",
		[7] = "6", [8] = "7", [9] = "8",
		[10] = "9", [11] = "10", [12] = "11",
		[13] = "12", [14] = "13", [15] = "14",
		[16] = "15", [17] = "F"
	}
	
	textPos = {
		--      X,         Y,
		[1] = 150,   [2] = 105,  -- T
		[3] = 420,  [4] = 105,  -- 1
		[5] = 690,  [6] = 105,  -- 2
		[7] = 960,  [8] = 105,  -- 3
		[9] = 1225, [10] = 105, -- 4
		[11] = 420, [12] = 320, -- 5
		[13] = 690, [14] = 320, -- 6
		[15] = 960, [16] = 320, -- 7
		[17] = 1225, [18] = 320, -- 8
		[19] = 420, [20] = 535,  -- 9
		[21] = 690, [22] = 535, -- 10
		[23] = 960, [24] = 535,  -- 11
		[25] = 1225, [26] = 535,  -- 12
		[27] = 420, [28] = 750,  -- 13
		[29] = 690, [30] = 750,  -- 14
		[31] = 960, [32] = 750,  -- 15
		[33] = 1225, [34] = 750,  -- 16
	}
	
	-- Set player start position
	player.x = textPos[1]
	player.y = textPos[2]
	
	-- Create Color Circle Array
	kCircle = {}
	-- Create Level Indicator Array
	levels = {}

	for i=1, #lvlNumber do
		-- Make & assign attributes to the 10 circles (kCircle[array])
		kCircle[i] = display.newCircle(textPos[2*i-1], textPos[2*i], 35)
		kCircle[i].name = lvlNumber[i]
		kCircle[i]:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862)
		kCircle[i]:setStrokeColor(1, 1, 1)
		kCircle[i].strokeWidth = 5

		-- Along with its text indicator (levels[array])
		levels[i] = display.newText(lvlNumber[i], textPos[2*i-1], textPos[2*i], native.Systemfont, 35)
		levels[i]:setFillColor(0, 0, 0)
		map.layer["tiles"]:insert(kCircle[i])
		map.layer["tiles"]:insert(levels[i])
	end
					
	kCircle[1].isAwake = true
	selectLevel.levelNum = kCircle[1].name
	kCircle[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
	
	
	lockedLevels = {}
	
	for i=1, #lvlNumber do
		if i~= 1 and i~=2 and i~=3 and i~=4 and i~=5 then
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
	
	map.layer["tiles"]:insert(player)
	map:addEventListener("touch", runLevelSelector)
	Runtime:addEventListener("enterFrame", setCameratoPlayer)
	Runtime:addEventListener("enterFrame", trackCamera)
end


-- When player tap's levels once:
function tapOnce(event)
	trackInvisibleBoat = false
	trackPlayer = true

	for i=1, #kCircle do
		if event.target.name == kCircle[i].name then
			if event.numTaps == 1 and kCircle[i].isAwake then
			
				selectLevel.levelNum = kCircle[i].name
				allowPlay = false
				-- Move kipcha to the selected circle
				transition.to(player, {time = 1000, x = kCircle[i].x, y = kCircle[i].y, onComplete=stopAnimation})
				player.rotation = 90
				player:setSequence("move")
				player:play()
			
				kCircle[i]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
					
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
	
	if allowPlay then
		-- If player taps silhouette kipcha, start game
		if event.target.name == silKipcha.name then
		
				-- Send data to start game
			gameData.gameStart = true
			
			map:removeEventListener("touch", runLevelSelector)
			Runtime:removeEventListener("enterFrame", setCameratoPlayer)
			Runtime:removeEventListener("enterFrame", trackCamera)
			silKipcha:removeEventListener("tap", tapOnce)
			
			--	Clean up on-screen items
			levelGUI:removeSelf()
			dPad:removeSelf()
			map = nil
			player = nil
			trackPlayer = nil
			trackInvisibleBoat = nil
			allowPlay = nil
							
			for p=1, #kCircle do
				display.remove(kCircle[p])
				display.remove(levels[p])
				display.remove(lockedLevels[p])
			end
		end
	end
end


function runLevelSelector(event)
	for i=1, #kCircle do
		silKipcha:addEventListener("tap", tapOnce)
		kCircle[i]:addEventListener("tap", tapOnce)
	end
				
	if gameData.gameStart then
		for i=1, #kCircle do
			kCircle[i]:removeEventListener("tap", tapOnce)
		end
	end
end

function trackCamera(event)

	-- Set player velocity according to movement result
	    if dPad.result == "l" then cameraTRK:setLinearVelocity(-cameraTRK.speed, 0)
	elseif dPad.result == "r" then cameraTRK:setLinearVelocity(cameraTRK.speed, 0)
	elseif dPad.result == "u" then cameraTRK:setLinearVelocity(0, -cameraTRK.speed)
	elseif dPad.result == "d" then cameraTRK:setLinearVelocity(0, cameraTRK.speed)
	elseif dPad.result == "n" then cameraTRK:setLinearVelocity(0, 0)
	end
	
end

-- Quick function to make all buttons uniform
local function newButton(parent) 
	local b = display.newRoundedRect(parent, 0, 0, 60, 60, 10) 
	      b:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862) 
		  b:setStrokeColor(1, 1, 1)
		  b.strokeWidth = 3
   return b 
end

-- Point in rect, using Corona objects rather than a list of coordinates
local function pointInRect(point, rect) 
	return (point.x <= rect.contentBounds.xMax) and 
		   (point.x >= rect.contentBounds.xMin) and 
		   (point.y <= rect.contentBounds.yMax) and 
		   (point.y >= rect.contentBounds.yMin) 
end

--------------------------------------------------------------------------------
-- Camera Movement Controls
--------------------------------------------------------------------------------
local function levelCamera(event)
	dPad = display.newGroup()
	
	map.layer["tiles"]:insert(cameraTRK)
	
	dPad.result = "n"
	-- Used to detect if the direction has moved
	dPad.prevResult = "n"

	-- Create the four buttons and position them
	dPad.l = newButton(dPad); dPad.l.x, dPad.l.y = -60, 0; dPad.r = newButton(dPad); dPad.r.x, dPad.r.y = 60, 0; dPad.u = newButton(dPad); dPad.u.x, dPad.u.y = 0, -60; dPad.d = newButton(dPad); dPad.d.x, dPad.d.y = 0, 60

	-- Position controls at lower-left
	dPad.x = display.screenOriginX + dPad.contentWidth * 0.5 + 40
	dPad.y = display.contentHeight - dPad.contentHeight * 0.5 - 40
		
	-- Touch listener for controls
	function dPad:touch(event)
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
				trackPlayer = false
				trackInvisibleBoat = true
											
				display.getCurrentStage():setFocus(event.target)
				event.target.isFocus = true
			elseif event.target.isFocus then
				if "ended" == event.phase or "cancelled" == event.phase then
					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
					dPad.result = "n"
				end
			end

			-- Did the direction change?
			if dPad.prevResult ~= dPad.result then 
				dPad.changed = true 
			end
			return true
	end
		
	-- Cancel touch event
	function dPad:cancelTouch()
		display.getCurrentStage():setFocus(nil)
		self.isFocus = false
		self.result = "n"
		return true
	end

	-- Clean
	function dPad:clean()
		self:cancelTouch()
		self:removeEventListener("touch")
		self.l.alpha = 1; self.r.alpha = 1; self.u.alpha = 1; self.d.alpha = 1
	end
			
	dPad:addEventListener("touch")
end

selectLevel.selectLoop = selectLoop
selectLevel.levelCamera = levelCamera

return selectLevel
