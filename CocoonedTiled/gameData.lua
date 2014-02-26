--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameData.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- gameData holds all global variables that will be used across all lua files

--------------------------------------------------------------------------------
-- Global Variables
--------------------------------------------------------------------------------

local gameData = {
	-- Game Loop Booleans
	gameStart = false,
	gameEnd = false,
	ingame = false,
	resumeGame = false,
	menuOn = true,	
	inGameOptions = false,
	inOptions = false,
	
	-- Level Selector Booleans
	selectLevel = false,
	inLevelSelector = false,
	
	-- Touch interface booleans
	allowTouch = false,
	allowPaneSwitch = false,
	
	-- Minimap Booleans
	allowMiniMap = false,
	showMiniMap = false,
	isShowingMiniMap = false,
	
	locked = false,
	
	-- Sound booleans
	BGM = 1    -- [1=ON, 2=OFF]
}

return gameData