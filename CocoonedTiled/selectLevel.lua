--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- selectLvl.lua
--------------------------------------------------------------------------------
-- Notes:
--		- Select Map sound byte derived from:
--		http://themushroomkingdom.net/sounds/wav/mk64/mk64_announcer05-jp.wav
--		This sound byte is a temporary place holder. 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Load in Global Variables
--------------------------------------------------------------------------------
local gameData = require("gameData")
local sound = require("sound")
local physics = require("physics")
physics.start()

--------------------------------------------------------------------------------
-- Initialize Local Variables
--------------------------------------------------------------------------------
local goTo
local levelNumber
local tapTime = 0

local selectLevel = {
	levelNum = 0,
	pane = "M",
	version = 0,
}

function setupLevelSelector(event)

	local phase = event.phase
	
	-- Load in map level background
	levelsMap = display.newImage("graphics/levelSelector.png")
	levelsMap.x = 700
	levelsMap.y = 455
	levelsMap:scale(1.5, 1.3)
	
	-- Create onScreen text object
	selLevelText = display.newText("Select Level:", 265, 125, native.systemFontBold, 100)
	selLevelText:setFillColor(0, 0, 0)
	
	silKipcha = display.newImage("graphics/sil_kipcha.png")
	silKipcha.x = 1250
	silKipcha.y = 650
	silKipcha:scale(1.5, 1.5)
	silKipcha.name = "sillykipchatrixareforkids"
					
	lvlNumber = {	
		[1] = "T", [2] = "1", [3] = "2",
		[4] = "3", [5] = "4", [6] = "5",
		[7] = "6", [8] = "7", [9] = "8",
		[10] = "F"
	}
	
	textPos = {
		--      X,         Y,
		[1] = 700, [2] = 129,  -- T
		[3] = 700, [4] = 300,  -- 1
		[5] = 470, [6] = 300,  -- 2
		[7] = 930, [8] = 300,  -- 3
		[9] = 550, [10] = 475, -- 4
		[11] = 850,[12] = 475, -- 5
		[13] = 700,[14] = 600, -- 6
		[15] = 470,[16] = 700, -- 7
		[17] = 930,[18] = 700, -- 8
		[19] = 700,[20] = 785  -- F
	}

	-- Create Color Circle Array
	kCircle = {}
	-- Create Level Indicator Array
	levels = {}

	for i=1, 10 do
		-- Make & assign attributes to the 10 circles (kCircle[array])
		kCircle[i] = display.newCircle(textPos[2*i-1], textPos[2*i], 75)
		kCircle[i].name = lvlNumber[i]
		kCircle[i]:setFillColor(105/255, 210/255, 231/255)
		kCircle[i]:setStrokeColor(0, 0, 0)
		kCircle[i].strokeWidth = 5
		
		-- Along with its text indicator (levels[array])
		levels[i] = display.newText(lvlNumber[i], textPos[2*i-1], textPos[2*i], native.Systemfont, 69)
		levels[i]:setFillColor(0, 0, 0)
	end
					
	kCircle[1].isAwake = true
	selectLevel.levelNum = kCircle[1].name
	kCircle[1]:setFillColor(167/255, 219/255, 216/255)
					
	kipcha = display.newImage("graphics/Kipcha135px.png")
	kipcha.x = kCircle[1].x
	kipcha.y = kCircle[1].y
	
	for p=1, #kCircle do
		kCircle[p]:addEventListener("touch", runLevelSelector)
		silKipcha:addEventListener("touch", runLevelSelector)
	end
	
	lockedLevels = {}
	
	for i=1, 10 do
		if i~= 1 and i~=2 and i~=3 then
			lockedLevels[i] = display.newImage("graphics/lock.png")
			lockedLevels[i].x = kCircle[i].x
			lockedLevels[i].y = kCircle[i].y
			lockedLevels[i]:scale(0.5, 0.5)
			kCircle[i].isAwake = false
		else
			kCircle[i].isAwake = true
		end
	end
	
end

-- When player tap's levels twice:
--[[
local function tapTwice(event)
	for i=1, #kCircle do
		if event.target.name == kCircle[i].name then
			if event.numTaps >= 2 and kCircle[i].isAwake then	
				--	Clean up on-screen items	
				display.remove(lvlNumber)
				display.remove(textPos)
				display.remove(kipcha)
				display.remove(levelsMap)
						
				for p=1, #kCircle do
					display.remove(kCircle[p])
					display.remove(levels[p])
					display.remove(lockedLevels[p])
					kCircle[p]:removeEventListener("touch", runLevelSelector)
				end
				
				-- Send data to start game
				gameData.gameStart = true
			end
		end
	end
end
]]--

-- When player tap's silKipcha twice:
--[[
local function tapTwice(event)
	-- Double tap silhouette to play game
	if event.numTaps >= 2 then	
		if event.target.name == "sillykipchatrixareforkids" then
			--	Clean up on-screen items	
			display.remove(lvlNumber)
			display.remove(textPos)
			display.remove(kipcha)
			display.remove(levelsMap)
						
			for p=1, #kCircle do
				display.remove(kCircle[p])
				display.remove(levels[p])
				display.remove(lockedLevels[p])
				kCircle[p]:removeEventListener("touch", runLevelSelector)
			end
			
			-- Send data to start game
			gameData.gameStart = true
		end
	end
end
--]]

-- When player tap's levels once:
local function tapOnce(event)
	for i=1, #kCircle do
		if event.target.name == kCircle[i].name then
			if event.numTaps == 1 and kCircle[i].isAwake then
				print("kCircle[", i, "]", kCircle[i], kCircle[i].isAwake)
				-- Move kipcha to the selected circle
				print("i =", i)
				kipcha.x = kCircle[i].x
				kipcha.y = kCircle[i].y
				goTo = kCircle[i].name
				selectLevel.levelNum = goTo
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
		display.remove(lvlNumber)
		display.remove(textPos)
		display.remove(kipcha)
		display.remove(levelsMap)
		display.remove(silKipcha)
		display.remove(selLevelText)
						
		for p=1, #kCircle do
			display.remove(kCircle[p])
			display.remove(levels[p])
			display.remove(lockedLevels[p])
			kCircle[p]:removeEventListener("touch", runLevelSelector)
			silKipcha:removeEventListener("touch", runLevelSelector)
		end
			
		-- Send data to start game
		gameData.gameStart = true
	end
end


function runLevelSelector(event)

	local phase = event.phase

	for i=1, #kCircle do
		silKipcha:addEventListener("tap", tapOnce)
		kCircle[i]:addEventListener("tap", tapOnce)
		--kCircle[i]:addEventListener("tap", tapTwice)
	end
	
	if gameData.gameStart then
		for i=1, #kCircle do
			kCircle[i]:removeEventListener("tap", tapOnce)
			silKipcha:removeEventListener("tap", tapOnce)
			--kCircle[i]:removeEventListener("tap", tapTwice)
		end
	end
end

-- Add selectLevel functions to global array
selectLevel.setupLevelSelector = setupLevelSelector
selectLevel.runLevelSelector = runLevelSelector

return selectLevel