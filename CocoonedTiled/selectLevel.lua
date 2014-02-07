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

function setCameratoPlayer(event)
	-- Set up map camera
	map.setCameraFocus(player)
	map.setTrackingLevel(0.1)
end

function stopAnimation(event)
	player:setSequence("still")
	player:play()
end

-- Select Level Loop
function selectLoop(event)
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

	physics.addBody(player, "dynamic", {radius = player.width * 0.25})

	silKipcha = display.newImage("graphics/sil_kipcha.png", 0, 0, true)
	silKipcha.x = 1250
	silKipcha.y = 650
	silKipcha:scale(1.5, 1.5)
	silKipcha.name = "sillykipchatrixareforkids"
	levelGUI.front:insert(silKipcha)

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
		kCircle[i]:setFillColor(105/255, 210/255, 231/255)
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
	kCircle[1]:setFillColor(167/255, 219/255, 216/255)
	
	
	lockedLevels = {}
	


	for i=1, #lvlNumber do
		if i~= 1 and i~=2 and i~=3 and i~=4 and i~=5 and i~=8 then
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
end


-- When player tap's levels once:
local function tapOnce(event)
	for i=1, #kCircle do
		if event.target.name == kCircle[i].name then
			if event.numTaps == 1 and kCircle[i].isAwake then
			
				selectLevel.levelNum = kCircle[i].name
			
				-- Move kipcha to the selected circle
				transition.to(player, {time = 1000, x = kCircle[i].x, y = kCircle[i].y, onComplete=stopAnimation})
				player.rotation = 90
				player:setSequence("move")
				player:play()
			
				kCircle[i]:setFillColor(167/255, 219/255, 216/255)
					
				-- Send signal to refresh sent mapData
				gameData.inLevelSelector = true
			end
		else
			for j=1, #kCircle do
				if kCircle[j].name ~= event.target.name then
					kCircle[j]:setFillColor(105/255, 210/255, 231/255)
				end
			end
		end
	end
	
	-- If player taps silhouette kipcha, start game
	if event.numTaps == 1 and event.target.name == silKipcha.name then
		--	Clean up on-screen items
		display.remove(map)
		display.remove(lvlNumber)
		display.remove(textPos)
		display.remove(levelsMap)
		display.remove(silKipcha)
		display.remove(selLevelText)
						
		for p=1, #kCircle do
			display.remove(kCircle[p])
			display.remove(levels[p])
			display.remove(lockedLevels[p])
		end
			
		-- Send data to start game
		gameData.gameStart = true
		
		if gameData.gameStart then
			silKipcha:removeEventListener("touch", runLevelSelector)
			Runtime:removeEventListener("enterFrame", setCameratoPlayer)
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
			silKipcha:removeEventListener("tap", tapOnce)
		end
	end
end

selectLevel.selectLoop = selectLoop

return selectLevel
