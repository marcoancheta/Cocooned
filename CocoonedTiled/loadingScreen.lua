--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadingScreen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that creates loading screen in between gameplay and menu systems

--------------------------------------------------------------------------------
-- Variables - variables for loading screens
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local gameData = require("gameData")
local loadingBG = nil
local levelCompleteBG = nil
local gameOverBG = nil 
local loadWolf = nil
local wolfSheet = nil
local cSS = require("cutSceneSystem")

--------------------------------------------------------------------------------
-- Loading Init - function that initialzies loading screen
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local function loadingInit(loadGroup)
	if levelComplete == true then 
		levelCompleteBG = display.newImage('mapdata/art/background/screens/levelComplete.png', 720, 450, true )
		levelCompleteBG:scale(1.095, 1.095)

		levelCompleteBG:toFront()
	elseif gameData.gameEnd == true then
		gameOverBG = display.newImage('mapdata/art/background/screens/gameOver.png', 720, 450, true)
		gameOverBG:scale(1.095, 1.095)
		gameOverBG:toFront()

	else
		loadingBG = display.newImage('mapdata/art/background/screens/LoadingScreen2.png', 720, 450, true )
		loadingBG:scale(1.095, 1.095)

		loadingBG:toFront()
	end

	--add image sheet and framereference
	--[[
	wolfSheet = graphics.newImageSheet("mapdata/graphics/wolfSheet.png", 
				   --change later {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9})
	loadWolf= display.newImage(wolfSheet, spriteOptions.wolf)
	loadWolf.x = middle
	loadWolf.y = middle
	loadWolf.toFront()
	loadWolf.play()
	]]
end

--------------------------------------------------------------------------------
-- Update Loading - function that updates loading screen
--------------------------------------------------------------------------------
-- Updated by: Marco - constantly adding loading screen to front of screen
--------------------------------------------------------------------------------
--local function updateLoading()
	--loadingBG:toFront()
--end

--------------------------------------------------------------------------------
-- Delete Loading - function that destroys lodaing screen when loading is finished
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local function deleteLoading(level)
	--l = tonumber(level)
	--if  l > 0 then
		--cSS.cutScene(l)
	--end

	if loadingBG ~= nil then 
		loadingBG:removeSelf()
		loadingBG = nil
	end
	if levelCompleteBG ~= nil then 
		levelCompleteBG:removeSelf()
		levelCompleteBG = nil
	end
	if gameOverBG ~= nil then 
		gameOverBG:removeSelf()
		gameOverBG = nil
	end
	--loadWolf:removeSelf()
	--loadWolf = nil
	--while cSS.cutSceneDone == false
end


--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local loadingScreen = {
	loadingInit = loadingInit,
	--updateLoading = updateLoading,
	deleteLoading = deleteLoading
}

-- return loadingScreen.lua
return loadingScreen
