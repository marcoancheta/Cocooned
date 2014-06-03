--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- win.lua
--------------------------------------------------------------------------------
local stars = require("Core.stars")
local generate = require("Objects.generateObjects")
local gameData = require("Core.gameData")
local menu = require("Core.menu")
local levelNames = require("utils.levelNames")
local font = require("utils.font")
local snow = require("utils.snow")
local loadingScreen = require("Loading.loadingScreen")
local sound = require("sound")
--------------------------------------------------------------------------------
-- Class
local win = {}
--------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------
-- Arrays
local textObj = {}
local scoreObj = {}
local buttonObj = {}
-- Objects
local overlay
local highText
local count
local score
local tempData
local tempGui
local tempTimer

--------------------------------------------------------------------------------
-- clean - Delete and clear variables and display objects used here
--------------------------------------------------------------------------------
local function clean()
	-- Remove title text
	if highText then
		highText:removeSelf()
		highText = nil
	end
	-- Remove textObjects
	if textObj then
		for i=1, #textObj do
			textObj[i]:removeSelf()
			textObj[i] = nil
		end
	end	
	-- Remove background overlay
	if overlay then
		overlay:removeSelf()
		overlay = nil
	end	
	-- Clear timer
	if tempTimer then
		tempTimer = nil
	end	
	-- Delete all score objects
	if scoreObj then
		for i=1, #scoreObj do
			scoreObj[i]:removeSelf()
			scoreObj[i] = nil
		end
	end
	-- Button objects
	if buttonObj then
		for i=1, #buttonObj do
			buttonObj[i]:removeSelf()
			buttonObj[i] = nil
		end
	end	
end

--------------------------------------------------------------------------------
-- init - Initialize scoring
--------------------------------------------------------------------------------
local function init(gui)
	--print("RUN")
	textObj = {}
	scoreObj = {}
	-- Create overlay object
	overlay = display.newImageRect("mapdata/art/background/screens/levelComplete.png", 1460, 860)
	overlay.x, overlay.y = display.contentCenterX, display.contentCenterY
	overlay.alpha = 0
	
	local overTrans = transition.to(overlay, {time=300, alpha=0.95})
	
	-- Add overlay to front layer
	gui.front:insert(overlay)
end

--------------------------------------------------------------------------------
-- Tap Once - function is called when player1 taps screen
--------------------------------------------------------------------------------
local function tap(event)
	-- Kipcha Play button detection
	if event.target.name == "select" then	
		gameData.selectLevel = true
		clean()
		snow.meltSnow()
		stars.clean()
	elseif event.target.name == "restart" then
		gameData.levelRestart = true
		clean()
		snow.meltSnow()
		stars.clean()
	end
end

--------------------------------------------------------------------------------
-- runWinner - show high scores
--------------------------------------------------------------------------------
local function runWinner(mapData, gui)
	-- Initialize high score board and save scoreText objects locally
	--init(gui)
	--textObj = highScore.init(gui)
	-- Create "HIGHSCORES" text
	--highText = display.newImageRect("mapdata/art/background/screens/highscore.png", 1460, 860)
	--highText.x, highText.y = display.contentCenterX, display.contentCenterY
	--highText:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)

	--local tables = highScore.loadScore()
	--highScore.scoreTable = tables
	--highScore.updateScore(mapData, gui, score)
	--highScore.counter = 0
	
	-- Restart Level button
	buttonObj[1] = display.newImageRect("mapdata/art/buttons/restart.png", 200, 200)
	buttonObj[1].name = "restart"
	buttonObj[1].x, buttonObj[1].y = generate.tilesToPixels(6, 19)
	-- Level Selector button
	buttonObj[2] = display.newImageRect("mapdata/art/buttons/levelselect.png", 200, 200)
	buttonObj[2].name = "select"
	buttonObj[2].x, buttonObj[2].y = generate.tilesToPixels(36, 19)
	
	for i=1, #buttonObj do
		buttonObj[i]:scale(1.5, 1.5)
		buttonObj[i]:addEventListener("tap", tap)
		gui.front:insert(buttonObj[i])
	end
	
	--gui.front:insert(highText)
end

--------------------------------------------------------------------------------
-- delay - Scoring transition delay
--------------------------------------------------------------------------------
local function delay(event)
	-- Called from listener below
	local params = event.source.params
	-- Remove wisps (target = wisps)
	if params.targetParam ~= nil then
		params.targetParam:removeSelf()
		params.targetParam = nil
	end
	-- Clean
	--clean()
	-- Run winner
	--runWinner(params.mapParam, params.guiParam)
end

--------------------------------------------------------------------------------
-- showScore - Run initial scoring screen
--------------------------------------------------------------------------------
local function showScore(mapData, gui)
	-- Temporarily store mapData and gui
	tempData = mapData
	tempGui = gui	
	
	-- Draw "LEVEL COMPLETE" at the top of the screen 	
	highText = display.newImageRect("mapdata/art/background/screens/complete.png", 1460, 860)
	highText.x, highText.y = display.contentCenterX, display.contentCenterY
	highText.name = "completeText"
	-- Add it to gui
	gui.front:insert(highText)
	
	-- Calculate player's score
	--local temp = highScore.calcScore() --mapData, gui)
	--count = (temp*0.01)
	--score = (temp + (gameData.gameTime * 100))
		
	-- Draw player ball for score transition
	scoreObj[1] = display.newImageRect("mapdata/art/ball/ball.png", 200, 200)
	--scoreObj[1]:scale(2, 2)
	scoreObj[1].x, scoreObj[1].y = display.contentCenterX, display.contentCenterY+250
	scoreObj[1].alpha = 0
	local alphatrans = transition.to(scoreObj[1], {time=500, alpha=1, onComplete= function() alphatrans=nil; end})
	
	-- Show level name
	if mapData.levelNum ~= "T" then
		local levelNumber = tonumber(mapData.levelNum)
		scoreObj[2] = display.newText(levelNames.names[levelNumber], display.contentCenterX, 80, font.TEACHERA, 72)
	elseif mapData.levelNum == "T" then
		scoreObj[2] = display.newText("TUTORIAL", display.contentCenterX, 80, font.TEACHERA, 72)
	end
	
	scoreObj[2].x, scoreObj[2].y = display.contentCenterX, display.contentCenterY-200
	scoreObj[2]:setFillColor(0, 0, 0)
	scoreObj[2].alpha = 1
		
	-- Load in stars
	local gStars = stars.initgStars()
	-- Load in level file
	local level = require("levels." .. levelNames[mapData.levelNum])
	-- Run algorithms w/ timers
	local wTimer = timer.performWithDelay(100, stars.wispStars)
		  wTimer.params = {level=level, gStars=gStars, mapData=mapData}
	local sTimer = timer.performWithDelay(200, stars.timerStars)
		  sTimer.params = {level=level, gStars=gStars, mapData=mapData}
	local dTimer = timer.performWithDelay(300, stars.deathStars)
		  dTimer.params = {level=level, gStars=gStars, mapData=mapData}
		  
	runWinner(mapData, gui)
end

win.init = init
win.showScore = showScore
win.runWinner = runWinner

return win