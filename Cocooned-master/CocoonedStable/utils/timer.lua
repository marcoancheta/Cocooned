--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- timer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local levelNames = require("utils.levelNames")
--------------------------------------------------------------------------------
-- Variables - variables for loading panes
--------------------------------------------------------------------------------
local gameTimer = {}

local theTimer
local clockFormat
local counter = 0

local function gameCountFunct(event)
	local params = event.source.params
	local textObj = params.counterParam

	gameData.gameTime = gameData.gameTime - 1
	
	if gameData.gameTime > 0 then
		if gameData.gameTime < 10 then
			textObj:setFillColor(1,0,0)
		end
		
		clockFormat = os.date("!%M:%S", gameData.gameTime)
		textObj.text = clockFormat
		print(gameData.gameTime)
	elseif gameData.gameTime == 0 then
		gameData.levelRestart = true
		textObj:removeSelf()
		timer.cancel(theTimer)
		theTimer = nil
	end
end

local function inGame(gui, mapData)	
	local level = require("levels." .. levelNames[mapData.levelNum])
	gameData.gameTime = level.timer
	local wispCounter = level.wispCount

	clockFormat = os.date("!%M:%S", gameData.gameTime)
	
	local counterText = display.newText(clockFormat, 0, 0, native.systemFontBold, 100)
	counterText.x = display.contentCenterX
	counterText.y = 50
	counterText:setFillColor(0, 0, 0)
	
	theTimer = timer.performWithDelay(100, gameCountFunct, gameData.gameTime*wispCounter)
	theTimer.params = {counterParam = counterText}
	
	gui.front:insert(counterText)
end

local function counterFunc(event)
	local params = event.source.params
	counter = counter - 1
	
	if counter > 0 then
		params.counterParam.text = counter
		params.guiParam.middle.alpha = 0.3
		params.guiParam.back.alpha = 0.3
		physics.pause()
	elseif counter == 0 then
		params.counterParam.text = "START!"
	elseif counter == -1 then
		params.guiParam.middle.alpha = 1
		params.guiParam.back.alpha = 1
		physics.start()
		timer.cancel(theTimer)
		theTimer = nil
		inGame(params.guiParam, params.mapDataParam)
	end
	print(counter)
end

local function preGame(gui, mapData)
	counter = 5
	
	local counterText = display.newText(counter, 0, 0, native.systemFontBold, 150)		
	counterText.x = display.contentCenterX
	counterText.y = display.contentCenterY
	counterText:setFillColor(255, 255, 255)
	
	theTimer = timer.performWithDelay(1000, counterFunc, counter+1)
	theTimer.params = {guiParam = gui, counterParam = counterText, mapDataParam = mapData}
	
	gui.front:insert(counterText)
end

gameTimer.preGame = preGame
gameTimer.inGame = inGame

return gameTimer