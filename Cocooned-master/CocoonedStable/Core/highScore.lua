--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- highScore.lua
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local inventory = require("Mechanics.inventoryMechanic")
local json = require("json")
--------------------------------------------------------------------------------
-- holds the level name for loading
local highScore = {	
	scoreText = { },
	scoreTable = {
		["1"] = {0, 0, 0, 0, 0},
		["2"] = {0, 0, 0, 0, 0},
		["3"] = {0, 0, 0, 0, 0},
		["4"] = {0, 0, 0, 0, 0},
		["5"] = {0, 0, 0, 0, 0},
		["6"] = {0, 0, 0, 0, 0}, 
		["7"] = {0, 0, 0, 0, 0}, 
		["8"] = {0, 0, 0, 0, 0}, 
		["9"] = {0, 0, 0, 0, 0}, 
		["10"] = {0, 0, 0, 0, 0},
		["11"] = {0, 0, 0, 0, 0},
		["12"] = {0, 0, 0, 0, 0},
		["13"] = {0, 0, 0, 0, 0},
		["14"] = {0, 0, 0, 0, 0},
		["15"] = {0, 0, 0, 0, 0}
	},
	
	tableSize = 5,
	counter = 0
}

local function init(gui)
	-- Create score text options array
	local scoreTextOptions = {}
	-- Pre-set string zeroes
	local zero = "0"
	
	-- Score Font and Size
	scoreTextOptions.fontSize = 72
	scoreTextOptions.font = native.systemFontBold
	-- Score Text Object Positions
	scoreTextOptions.x = display.contentCenterX
	scoreTextOptions.y = 150
	-- Score max amount 999,999
	scoreTextOptions.maxDigits = 6
	
	-- Predetermine score file name for save and load
	highScore.filename = "scorefile.json"
	-- Preset scoreText format
	highScore.format = "%" .. zero .. scoreTextOptions.maxDigits .. "d"
	-- Create 4 instances of scoreText object
	for i=1, 5 do
		highScore.scoreText[i] = display.newText(string.format(highScore.format, 0), 
									scoreTextOptions.x, (scoreTextOptions.y + (i*100)), 
									scoreTextOptions.font, scoreTextOptions.fontSize )
		-- Draw to front of screen
		gui.front:insert(highScore.scoreText[i])
	end
								
	-- Return scoreText object
	return highScore.scoreText
end

--------------------------------------------------------------------------------
-- saveScore - Save highScores to device root.
--------------------------------------------------------------------------------
local function saveScore()
	-- Initialize "scorefile.txt" file path
	local path = system.pathForFile(highScore.filename, system.DocumentsDirectory)
	-- Open path and set to write ("w")
	local file = io.open(path, "w")

	-- Check if file exists
	if file then
		-- Local temp storage of highScore table		
		local contents = json.encode(highScore.scoreTable)
		file:write(contents)	
		-- Close file when writing is completed
		io.close(file)
		return true
	else
		-- Throw error into console
		print("Error: File - '" ..highScore.filename.. "' - could not be used to save scores.")		
		return false
	end
end

--------------------------------------------------------------------------------
-- loadScore - load highScores from device root.
--------------------------------------------------------------------------------
local function loadScore()
	-- Initialize "scorefile.txt" file path
	local path = system.pathForFile(highScore.filename, system.DocumentsDirectory)
	-- Initialize file contents
	local contents = ""	
	-- Locally store file
	local file = io.open(path, "r")
	-- Create temp table
	local tempTable = {}
	
	-- Check if file exists
	if file then
		-- Read in and locally store file contents
		local contents = file:read("*a")
		-- Overwrite default scoreTable with new one
		--scoreTable = contents
		tempTable = json.decode(contents)
		-- Close file
		io.close(file)	
		return tempTable
	else
		-- Throw error into console
		print("Error: File - '" ..highScore.filename.. "' - could not be used to load scores.")
	end	
	return nil
end

--------------------------------------------------------------------------------
-- drawScore - Draw highScore onto screen.
--------------------------------------------------------------------------------
local function drawScore(mapData, gui, score)
	-- Check if text object exists
	for i=1, highScore.tableSize do
		if highScore.scoreText[i] then			
			highScore.scoreText[i].text = highScore.scoreTable[mapData.levelNum][i]
			--highScore.scoreText[i].text = string.format(highScore.format, highScore.scoreTable[mapData.levelNum][i])
		end
	end
end

--------------------------------------------------------------------------------
-- updateScore - Update scoreBoard by overwrite values in highScore table
--------------------------------------------------------------------------------
local function updateScore(mapData, gui, score)
	-- Check if level is not in the world or level selector
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		-- Convert levelNum to string
		local levelString = tostring(mapData.levelNum)
		
		-- Debug mode only
		if gameData.debugMode then
			print("levelString", levelString)
			print("highScore.scoreTable[levelString][1]", highScore.scoreTable[levelString][1])
		end
				
		-- Check if scoreTable exists for level
		if highScore.scoreTable[levelString] then
			-- Temporarily store current values of table
			local temp = highScore.scoreTable[levelString]
			
			local i=1
			while i <= highScore.tableSize do
				-- if current score is less than a value in scoreTable
				if score > highScore.scoreTable[levelString][i] then
					-- Debug mode only
					if gameData.debugMode then	
						for k=1, #temp do
							print("temp["..k.."]", temp[k])
						end
					
						print("score", score)
						print("highScore.scoreTable[levelString][i]", highScore.scoreTable[levelString][i])
						print("temp["..i.."]", temp[i])
						print("temp["..(i+1).."]", temp[i+1])
						print("")
						print("i", i)
						print("highScore.scoreTable[levelString]["..i.."]", highScore.scoreTable[levelString][i])	
					end
					
					-- Increase table size by 1, if new high score is found
					highScore.tableSize = highScore.tableSize+1
					-- Replace values below new high score with old ones from temp
					highScore.scoreTable[levelString][i+2] = temp[i+1]
					highScore.scoreTable[levelString][i+1] = temp[i]	
					-- Overwrite scores
					highScore.scoreTable[levelString][i] = score							
					-- Draw scores
					drawScore(mapData, gui, score)
					-- Save scores
					saveScore()
					-- End while loop
					break
				else
					-- No new high score found..
					-- Draw scores
					drawScore(mapData, gui, score)
					-- Save scores
					saveScore()
				end
				-- Continue while loop
				i = i+1
			end
		end
		
		levelString = nil
	else
		-- If in levelSelector or worldSelector, quit
		return false
	end
end

--------------------------------------------------------------------------------
-- calcScore - Do the math for score calculations
--------------------------------------------------------------------------------
local function calcScore(mapData, gui)	
	local count = 0

	if highScore.counter then
		count = highScore.counter * 100
	end
	
	-- High Score hacks (MAX PTS!)
	--updateScore(mapData, gui, 999999)
	return count
end

--------------------------------------------------------------------------------
-- addScore - Do the math for score calculations
--------------------------------------------------------------------------------
local function addScore(value)
	highScore.counter = highScore.counter + value	
	return highScore.counter
end

--------------------------------------------------------------------------------
-- clean - Delete and clear variables and display objects used here
--------------------------------------------------------------------------------
local function clean()
	highScore.counter = 0
	
	for i=1, #highScore.scoreText do
		highScore.scoreText[i]:removeSelf()
		highScore.scoreText[i] = nil
	end	
	
end

highScore.init = init
highScore.loadScore = loadScore
highScore.saveScore = saveScore
highScore.drawScore = drawScore
highScore.updateScore = updateScore
highScore.calcScore = calcScore
highScore.addScore = addScore
highScore.clean = clean

return highScore