--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- win.lua
--------------------------------------------------------------------------------
local highScore = require("Core.highScore")
local generate = require("Objects.generateObjects")
local gameData = require("Core.gameData")
local menu = require("Core.menu")
local font = require("utils.font")
--------------------------------------------------------------------------------
-- Class
local win = {}
--------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------
-- Arrays
local textObj = {}
local scoreObj = {}
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
	
end

--------------------------------------------------------------------------------
-- init - Initialize scoring
--------------------------------------------------------------------------------
local function init(gui)
	--print("RUN")
	textObj = {}
	scoreObj = {}
	-- Create overlay object
	overlay = display.newRect(display.contentCenterX, display.contentCenterY, 1460, 860)
	overlay:setFillColor(0,0,0)
	overlay.alpha = 0.9
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
	elseif event.target.name == "restart" then
		gameData.levelRestart = true
		clean()
	elseif event.target.name == "quit" then
		gameData.gameEnd = true
		clean()
	end
end

--------------------------------------------------------------------------------
-- runWinner - show high scores
--------------------------------------------------------------------------------
local function runWinner(mapData, gui)
	-- Initialize high score board and save scoreText objects locally
	init(gui)
	textObj = highScore.init(gui)
	-- Create "HIGHSCORES" text
	highText = display.newText("HIGH SCORES", display.contentCenterX, 80,font.TEACHERA, 82)

	local tables = highScore.loadScore()
	highScore.scoreTable = tables
	highScore.updateScore(mapData, gui, score)
	highScore.counter = 0
	
	-- Restart Level button
	scoreObj[1] = display.newImageRect("mapdata/art/buttons/restart.png", 200, 200)
	scoreObj[1].name = "restart"
	scoreObj[1].x, scoreObj[1].y = generate.tilesToPixels(34, 18)
	-- Level Selector button
	scoreObj[2] = display.newImageRect("mapdata/art/buttons/select.png", 200, 200)
	scoreObj[2].name = "select"
	scoreObj[2].x, scoreObj[2].y = generate.tilesToPixels(34, 10)
	-- Main Menu button
	scoreObj[3] = display.newImageRect("mapdata/art/buttons/main.png", 200, 200)
	scoreObj[3].name = "quit"
	scoreObj[3].x, scoreObj[3].y = generate.tilesToPixels(8, 18)
			
	gui.front:insert(highText)
	
	for i=1, #scoreObj do
		scoreObj[i]:scale(1.5, 1.5)
		scoreObj[i]:addEventListener("tap", tap)
		gui.front:insert(scoreObj[i])
	end
end

--------------------------------------------------------------------------------
-- delay - Scoring transition delay
--------------------------------------------------------------------------------
local function delay(event)
	-- Called from listener below
	local params = event.source.params
	-- Remove wisps (target = wisps)
	if params.targetParam then
		params.targetParam:removeSelf()
		params.targetParam = nil
	end
	-- Clean
	clean()
	-- Run winner
	runWinner(params.mapParam, params.guiParam)
end

--------------------------------------------------------------------------------
-- listener - Transition listener
--------------------------------------------------------------------------------
local function listener(target, mapData, gui)
	-- Show time remaining
	scoreObj[3] = display.newText("Time left: " ..os.date("!%M:%S", gameData.gameTime), display.contentCenterX, 80,font.TEACHERA, 72)
	scoreObj[3].x, scoreObj[3].y = generate.tilesToPixels(20, 7)
	scoreObj[3].alpha = 0
	
	local fade = function() local endTrans = transition.to(scoreObj[3], {time=2000, alpha=0}) end
	local trans = transition.to(scoreObj[3], {time=2000, alpha=1, onComplete=fade})
	
	-- Called from showScore transition:
	-- Delay 5 seconds to show high score
	tempTimer = timer.performWithDelay(5000, delay)
	tempTimer.params = {targetParam = target, mapParam = mapData, guiParam = gui}
end

--------------------------------------------------------------------------------
-- showScore - Run initial scoring screen
--------------------------------------------------------------------------------
local function showScore(mapData, gui)
	-- Temporarily store mapData and gui
	tempDataw = mapData
	tempGui = gui	
	-- Draw "WINNER" at the top of the screen 	
	highText = display.newText("Level Complete!", display.contentCenterX, 80, font.TEACHERA, 82)
	-- Calculate player's score
	local temp = highScore.calcScore(mapData, gui)
	count = (temp*0.01)
	score = (temp + (gameData.gameTime * 100))
	-- Draw wisp for score transition
	local wisp = display.newImage("mapdata/art/wisp/whisp.png")
	wisp.x, wisp.y = generate.tilesToPixels(20, 7)
	-- Draw player ball for score transition
	scoreObj[1] = display.newImage("mapdata/art/ball/ball1.png")
	scoreObj[1]:scale(2, 2)
	scoreObj[1].x, scoreObj[1].y = generate.tilesToPixels(20, 15)
	-- Show player's score
	scoreObj[2] = display.newText("Score: " ..score, display.contentCenterX, 80,font.TEACHERA, 82)
	scoreObj[2].x, scoreObj[2].y = generate.tilesToPixels(20, 20)
	-- If amount of wisps is greater than 0, run transition
	if count > 0 then
		-- run transition for 0.5 seconds
		local wispTran = transition.to(wisp, {time=500, alpha=0, x=scoreObj[1].x, y=scoreObj[1].y, iterations=count, onComplete= function(wisp) listener(wisp, mapData, gui) end})		
	-- if not wisp collected, just show time left
	elseif count == 0 then
		wisp.alpha = 0
		listener(wisp, mapData, gui)

	end

end

win.init = init
win.showScore = showScore
win.runWinner = runWinner

return win