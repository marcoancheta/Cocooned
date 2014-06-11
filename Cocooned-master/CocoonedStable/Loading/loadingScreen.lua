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
--------------------------------------------------------------------------------
-- Loading Init - function that initialzies loading screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function loadingInit(gui)
	loadingBG = display.newImageRect('mapdata/art/background/screens/loadingScreen.png', 1460, 864)	
	loadingBG.x = display.contentCenterX
	loadingBG.y = display.contentCenterY
	gui.load:insert(loadingBG)

	print("DONNNNNEEEEEE LOADING")
	
	return loadingBG
end

--------------------------------------------------------------------------------
-- Delete Loading - function that destroys lodaing screen when loading is finished
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function deleteLoading(gui)
	if loadingBG then 
		print("REMOVE LOADING BG")
		display.remove(loadingBG)
		--gui.load:remove(loadingBG)
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