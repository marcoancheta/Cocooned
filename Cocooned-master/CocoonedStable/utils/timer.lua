--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- timer.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Variables - variables for loading panes
--------------------------------------------------------------------------------
local gameTimer = {}

local theTimer

local counter = 5
local counterText = display.newText(counter, 0, 0, native.systemFontBold, 150)

local function counterFunc(event)
	local params = event.source.params

	if counter > 1 then
		counter = counter - 1
		counterText.text = counter
		params.guiParam.middle.alpha = 0.3
		params.guiParam.back.alpha = 0.3
		physics.pause()
	elseif counter == 1 then
		counterText:removeSelf()
		params.guiParam.middle.alpha = 1
		params.guiParam.back.alpha = 1
		physics.start()
	end
end

local function preGame(gui)
	counterText.x = display.contentCenterX
	counterText.y = display.contentCenterY
	counterText:setFillColor(255, 255, 255)
	theTimer = timer.performWithDelay(1000, counterFunc, counter)
	theTimer.params = {guiParam = gui}
	
	gui.front:insert(counterText)
end


gameTimer.preGame = preGame


return gameTimer