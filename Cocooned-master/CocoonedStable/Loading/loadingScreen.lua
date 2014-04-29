 --------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadingScreen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Variables - variables for loading screens
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local loadingBG
local displayX = 1460
local displayY = 864
--------------------------------------------------------------------------------
-- Loading Init - function that initialzies loading screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function loadingInit()
	if gameData.levelComplete == true then 
		loadingBG = display.newImageRect('mapdata/art/background/screens/levelComplete.png', displayX, displayY)
	elseif gameData.gameEnd == true then
		loadingBG = display.newImageRect('mapdata/art/background/screens/gameOver.png', displayX, displayY)
	else
		loadingBG = display.newImageRect('mapdata/art/background/screens/loadingScreen.png', displayX, displayY)
	end
	
	loadingBG.x = display.contentCenterX
	loadingBG.y = display.contentCenterY
	loadingBG:toFront()
end

--------------------------------------------------------------------------------
-- Delete Loading - function that destroys lodaing screen when loading is finished
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function deleteLoading()
	if loadingBG then 
		--display.remove(loadingBG)
		loadingBG:removeSelf()
		loadingBG = nil
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local loadingScreen = {
	loadingInit = loadingInit,
	deleteLoading = deleteLoading
}

return loadingScreen