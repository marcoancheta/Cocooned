 --------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- cutSceneSystem.lua
--------------------------------------------------------------------------------
-- Andrew's TODO:
-- TODO: add in levels that have cutscenes
-- TODO: Add Variable to gameData to show that player is in cutscene?
-- Note to Andrew: Please comment your code like so. Makes things easier for 
-- everyone else.
--------------------------------------------------------------------------------
-- Load in classes
--------------------------------------------------------------------------------
local gameTimer = require("utils.timer")
local generate = require("Objects.generateObjects")
local loading = require("Loading.loadingScreen")
--------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------
-- Arrays
local scenes = {}
-- Level number = number of cutscenes
local numberOfScreens = { ["LS"] = 0, ["1"] = 3,  ["2"] = 0, 
						 ["3"] = 0,  ["4"] = 0,  ["5"] = 0, 
						 ["6"] = 0,  ["7"] = 0,  ["8"] = 0, 
						 ["9"] = 0,  ["10"] = 0, ["11"] = 0, 
						 ["12"] = 0, ["13"] = 0, ["14"] = 0, 
						 ["15"] = 0 }
						 
-- Variables
local currScene = 0
local nextScene
local tempGui
local tempMapData

local deleteClosure = function() return loading.deleteLoading() end

--------------------------------------------------------------------------------
-- nextSceneOrDelete - ?
--------------------------------------------------------------------------------
local function nextSceneOrDelete(event)
	--print("nextSceneOrDelete")	
	if scenes[currScene] ~= nil then
		-- Delete scene on screen.
		scenes[currScene]:removeSelf()
		scenes[currScene] = nil	
	end
	-- Clear variables if current scene reaches levels' maximum amount of scenes
	if currScene == numberOfScreens[tempMapData.levelNum] then
		loading.loadingInit(tempGui)
		-- Clear current scene
		currScene = nil
		-- Remove event listener from nextScene
		if nextScene ~= nil then
			nextScene:removeEventListener("tap", nextSceneOrDelete)
			nextScene:removeSelf()
			nextScene = nil	
		end
		-- Clear scenes array
		scenes = nil
		scenes = {}
		-- Run pregame timer events
		gameTimer.preGame(tempGui, tempMapData)
		-- Clear temporary gui and mapData variables
		tempGui = nil
		tempMapData = nil
		-- destroy loading screen
		local loadingTimer = timer.performWithDelay(2000, deleteClosure)
	else
		currScene = currScene +1
	end
end

--------------------------------------------------------------------------------
-- nextSceneOrDelete - ?
--------------------------------------------------------------------------------
local function cutScene(gui, mapData)
	-- Temporary store gui and mapData for use in nextSceneOrDelete
	tempGui = gui
	tempMapData = mapData
	
	--print(mapData.levelNum)	
	if numberOfScreens[mapData.levelNum] > 0 then
		for i= numberOfScreens[mapData.levelNum], 1, -1 do
			scenes[i] = display.newImageRect("mapdata/art/cutscenes/OLD/"..mapData.levelNum.."/"..i..".png", 1460, 864)
			scenes[i].x, scenes[i].y = display.contentCenterX, display.contentCenterY
		end
		--print("drawing next scene")
		-- Create nextScene button
		nextScene = display.newImageRect("mapdata/art/buttons/play.png", 250, 250)
		-- map nextScene button to right corner
		nextScene.x, nextScene.y = generate.tilesToPixels(36, 19)
		-- Add tap listener to play button
		nextScene:addEventListener("tap", nextSceneOrDelete)
		currScene = 1
	else
		gameTimer.preGame(tempGui, tempMapData)
	end
end


local cutSceneSystem= {
	cutScene = cutScene
}

return cutSceneSystem