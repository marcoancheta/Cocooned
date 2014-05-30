--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- stars.lua
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local inventory = require("Mechanics.inventoryMechanic")
local sound = require("sound")
local font = require("utils.font")
local json = require("json")
--------------------------------------------------------------------------------
-- Stars class/constructor
-- holds the level name for loading
local stars = {	
	-- stars.tables[levelNum]
	tables = {
		-- [1] = 0 player has not played level, 1 player played level
		-- [2],[3],[4] = 0 player has not received a gold star, 1 player has received a gold star
		-- [2] = wisps, [3] = time, [4] = deaths
		--      [1][2][3][4]
		["1"] = {0, 0, 0, 0},
		["2"] = {0, 0, 0, 0},
		["3"] = {0, 0, 0, 0},
		["4"] = {0, 0, 0, 0},
		["5"] = {0, 0, 0, 0},
		["6"] = {0, 0, 0, 0}, 
		["7"] = {0, 0, 0, 0}, 
		["8"] = {0, 0, 0, 0}, 
		["9"] = {0, 0, 0, 0}, 
		["10"] = {0, 0, 0, 0},
		["11"] = {0, 0, 0, 0},
		["12"] = {0, 0, 0, 0},
		["13"] = {0, 0, 0, 0},
		["14"] = {0, 0, 0, 0},
		["15"] = {0, 0, 0, 0}
	},
	-- stars.tables[levelNum] slots
	tableSize = 4,
	counter = 0,
	filename = "starfile.json"
}

local gStars = {}

--------------------------------------------------------------------------------
-- saveScore - Save starss to device root.
--------------------------------------------------------------------------------
local function saveScore()
	-- Initialize "scorefile.txt" file path
	local path = system.pathForFile(stars.filename, system.DocumentsDirectory)
	-- Open path and set to write ("w")
	local file = io.open(path, "w")

	-- Check if file exists
	if file then
		-- Local temp storage of stars table		
		local contents = json.encode(stars.tables)
		file:write(contents)	
		-- Close file when writing is completed
		io.close(file)
		
		return true
	else
		-- Throw error into console
		print("Error: File - '" ..stars.filename.. "' - could not be used to save scores.")		
		return false
	end
end

--------------------------------------------------------------------------------
-- loadScore - load starss from device root.
--------------------------------------------------------------------------------
local function loadScore()
	-- Initialize "scorefile.txt" file path
	local path = system.pathForFile(stars.filename, system.DocumentsDirectory)
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
		saveScore()
		tempTable = loadScore()
		-- Throw error into console
		print("Error: File - '" ..stars.filename.. "' - could not be used to load scores.")
		return tempTable
	end	
	return nil
end

--------------------------------------------------------------------------------
------ UPDATE STARS SCORE ------------------------------------------------------
--------------------------------------------------------------------------------
local function updateStars(value, mapData)
	if stars.tables[mapData.levelNum][value] == 0 then
		stars.tables[mapData.levelNum][value] = 1
	end
	saveScore()	
end

--------------------------------------------------------------------------------
------ WISPS STARS DRAW --------------------------------------------------------
--------------------------------------------------------------------------------
local function wispStars(event)
	local params = event.source.params
	local count = stars.calcScore()
	-- If amount of wisps is the full amount of wisps in [mapData.levelNum].lua file
	if count == params.level.wispCount then		
		-- STAR: WISP
		local star = params.gStars[1]
			  star.isVisible = true
			  star:rotate(-25)
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		-- Transition star from ball to organized position
		local trans = transition.to(star, {time=600, alpha=1, xScale=5, yScale=5,
											x=display.contentCenterX-300, y=display.contentCenterY})
		-- Update star score table					
		updateStars(2, params.mapData)
	elseif count < params.level.wispCount then
		local star = params.gStars[4]
			  star.isVisible = true
			  star:rotate(-25)
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		local trans = transition.to(star, {time=600, alpha=1, xScale=5, yScale=5,
											x=display.contentCenterX-300, y=display.contentCenterY})
	end
end

--------------------------------------------------------------------------------
------ TIMER STARS DRAW --------------------------------------------------------
--------------------------------------------------------------------------------
local function timerStars(event)
	local params = event.source.params
	-- Locally store win time
	local winTime = gameData.gameTime
	local levelTime = params.level.timer
	-- Calculate time used percentage
	local estimate = (winTime/levelTime)
	
	-- Greater than 65%
	if (estimate >= 0.65) then
		local star = params.gStars[2]
			  star.isVisible = true
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		-- Transition alpha and star scaling in 7 milliseconds
		local trans = transition.to(star, {time=600, alpha=1, xScale=5, yScale=5,
											x=display.contentCenterX, y=display.contentCenterY-50})
		-- Update star score table
		updateStars(3, params.mapData)
	-- Less than or equal to 50%
	elseif (estimate <= 0.5) then
		local star = params.gStars[5]
			  star.isVisible = true
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		-- Transition alpha and star scaling in 6 milliseconds
		local trans = transition.to(star, {time=550, alpha=1, xScale=5, yScale=5, 
											x=display.contentCenterX, y=display.contentCenterY-50})
	end
end

-----------------------------------------------------------------------
------ DEATH STARS DRAW  ----------------------------------------------
-----------------------------------------------------------------------
local function deathStars(event)
	local params = event.source.params
	-- Locally store win time
	local deaths = gameData.deaths
	-- If there were no deaths GOLD STAR CHAMP
	if (deaths == 0) then
		local star = params.gStars[3]
			  star.isVisible = true
			  star:rotate(25)
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		-- Transition alpha and star scaling in 8 milliseconds
		local trans = transition.to(star, {time=600, alpha=1, xScale=5, yScale=5, 
											x=display.contentCenterX+300, y=display.contentCenterY})
		-- Update star score table
		updateStars(4, params.mapData)
	-- More than one star? Access denied
	elseif (deaths > 0) then
		local star = params.gStars[6]
			  star.isVisible = true
			  star:rotate(25)
			  star.x, star.y = display.contentCenterX, display.contentCenterY+250
		-- Transition alpha and star scaling in 7 milliseconds
		local trans = transition.to(star, {time=600, alpha=1, xScale=5, yScale=5, 
											x=display.contentCenterX+300, y=display.contentCenterY})
	end
end

-----------------------------------------------------------------------
------ Initialize Stars Drawn  ----------------------------------------
-----------------------------------------------------------------------
local function initgStars()
	-- goalStar array
	gStars = {
		-- Gold stars
		[1] = display.newImageRect("mapdata/art/stars/star.png", 50, 50),
		[2] = display.newImageRect("mapdata/art/stars/star.png", 50, 50),
		[3] = display.newImageRect("mapdata/art/stars/star.png", 50, 50),
		-- Empty stars
		[4] = display.newImageRect("mapdata/art/stars/star_empty.png", 50, 50),
		[5] = display.newImageRect("mapdata/art/stars/star_empty.png", 50, 50),
		[6] = display.newImageRect("mapdata/art/stars/star_empty.png", 50, 50)
	}
	
	for i=1, #gStars do
		gStars[i].isVisible = false
		gStars[i]:scale(1.5, 1.5)
	end
	
	return gStars
end

-----------------------------------------------------------------------
------ GOAL STARS DRAW  ----------------------------------------------
-----------------------------------------------------------------------
local function goalStars(gStars, gui, mapData)
	-- Null checker
	if gStars ~= nil then	
		--print("stars.tables[mapData.levelNum][1]", stars.tables[mapData.levelNum][1])
		-- Iterate through stars.tables array
		for j=1, #stars.tables[mapData.levelNum] do
			--print(#stars.tables[levelString])
			-- Skip first stars.tables value
			if (stars.tables[mapData.levelNum][j+1] ~= 0) and j ~= 4 then
				--print("j: ", j)
				gStars[j].x, gStars[j].y = (j*85), 85 
				--print(gStars[j].x, gStars[j].y)
				gStars[j].isVisible = true
			elseif stars.tables[mapData.levelNum][j+1] == 0 then
				--print("j+3: ", j+3)
				gStars[j+3].x, gStars[j+3].y = (j*85), 85
				--print(gStars[j+3].x, gStars[j+3].y)
				gStars[j+3].isVisible = true
			end
		end
	end
end

--------------------------------------------------------------------------------
-- addWisps - Do the math for score calculations
--------------------------------------------------------------------------------
local function addWisps(value)
	stars.counter = stars.counter + value	
	return stars.counter
end

--------------------------------------------------------------------------------
-- calcScore - Do the math for score calculations
--------------------------------------------------------------------------------
local function calcScore() --mapData, gui)	
	local count = 0

	if stars.counter then
		count = stars.counter
	end
	
	return count
end

--------------------------------------------------------------------------------
-- clean - Delete and clear variables and display objects used here
--------------------------------------------------------------------------------
local function clean()
	stars.counter = 0
	
	if gStars then
		for i=1, #gStars do
			gStars[i]:removeSelf()
			gStars[i] = nil
		end		
		gStars = nil
	end
end

-- Process class functions
stars.wispStars = wispStars
stars.timerStars = timerStars
stars.deathStars = deathStars
stars.initgStars = initgStars
stars.goalStars = goalStars
stars.addWisps = addWisps
stars.loadScore = loadScore
stars.saveScore = saveScore
--stars.updateStars = updateStars
stars.calcScore = calcScore
stars.clean = clean

return stars

--[[
--------------------------------------------------------------------------------
-- updateStars - Update scoreBoard by overwrite values in stars table
--------------------------------------------------------------------------------
local function updateStars(mapData, gui, score)
	-- Check if level is not in the world or level selector
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		-- Convert levelNum to string
		local levelString = tostring(mapData.levelNum)
		
		-- Debug mode only
		--if gameData.debugMode then
			print("levelString", levelString)
			print("stars.tables[levelString]", stars.tables[levelString])
		--end
				
		-- Check if scoreTable exists for level
		if stars.tables[levelString] then
			-- Temporarily store current values of table
			local temp = stars.tables[levelString]
			
			local i=1
			while i <= stars.tableSize do
				-- if current score is less than a value in scoreTable
				if score > stars.tables[levelString][i] then
					-- Debug mode only
					if gameData.debugMode then	
						for k=1, #temp do
							print("temp["..k.."]", temp[k])
						end
					
						print("score", score)
						print("stars.tables[levelString][i]", stars.tables[levelString][i])
						print("temp["..i.."]", temp[i])
						print("temp["..(i+1).."]", temp[i+1])
						print("")
						print("i", i)
						print("stars.tables[levelString]["..i.."]", stars.tables[levelString][i])	
					end
					
					-- Increase table size by 1, if new high score is found
					stars.tableSize = stars.tableSize+1
					-- Replace values below new high score with old ones from temp
					stars.tables[levelString][i+2] = temp[i+1]
					stars.tables[levelString][i+1] = temp[i]	
					-- Overwrite scores
					stars.tables[levelString][i] = score							
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
]]--