--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameData.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Global Variables
--------------------------------------------------------------------------------

local gameData = {
	gameStart = false,
	gameEnd = false,
	menuOn = true,
	selectLevel = false,
	inLevelSelector = false,
	allowTouch = false,
	allowPaneSwitch = false,
	allowMiniMap = false,
	showMiniMap = false,
	isShowingMiniMap = false,
	ingame = false,
	inGameOptions = false,
	resumeGame = false,
	inOptions = false,
	locked = false,
	BGM = 1    -- [1=ON, 2=OFF]
}

return gameData