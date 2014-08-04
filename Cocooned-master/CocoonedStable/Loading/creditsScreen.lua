 --------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- credits.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Variables - variables for loading screens
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local creditsBG
--------------------------------------------------------------------------------
-- Loading Init - function that initialzies loading screen
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function creditsInit(gui)
	creditsBG = display.newImageRect('mapdata/art/credits.png', 1460, 864)	
	creditsBG.x = display.contentCenterX
	creditsBG.y = display.contentCenterY
	gui.load:insert(creditsBG)

	--print("DONNNNNEEEEEE LOADING")
	
	return creditsBG
end

--------------------------------------------------------------------------------
-- Delete Loading - function that destroys lodaing screen when loading is finished
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function deleteLoading(gui)
	if creditsBG then 
		print("REMOVE LOADING BG")
		display.remove(creditsBG)
		--gui.load:remove(loadingBG)
		creditsBG:removeSelf()
		creditsBG = nil
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local creditsScreen = {
	creditsInit = creditsInit,
	deleteLoading = deleteLoading
}

return creditsScreen