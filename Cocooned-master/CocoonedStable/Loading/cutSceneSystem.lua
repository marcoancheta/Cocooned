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
local gameData = require("Core.gameData")
local generate = require("Objects.generateObjects")
local loading = require("Loading.loadingScreen")
--------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------
-- Arrays
local scenes = {}
-- Level number = number of cutscenes
local screensA = {["T"] = 10, ["1"] = 24,  ["2"] = 0, 
				  ["3"] = 0,  ["4"] = 0,  ["5"] = 0, 
				  ["6"] = 19,  ["7"] = 0,  ["8"] = 3, 
				  ["9"] = 0,  ["10"] = 3, ["11"] = 0, 
				  ["12"] = 3, ["13"] = 0, ["14"] = 0, 
				  ["15"] = 25}
						 
local screensB = {["T"] = 0, ["1"] = 0,  ["2"] = 0, 
				  ["3"] = 0,  ["4"] = 0,  ["5"] = 0, 
				  ["6"] = 10,  ["7"] = 0,  ["8"] = 0, 
				  ["9"] = 0,  ["10"] = 0, ["11"] = 0, 
				  ["12"] = 0, ["13"] = 0, ["14"] = 0, 
				  ["15"] = 6}
						 
-- Variables
local currScene = 0
local nextScene
local tempGui
local tempMapData

--local deleteClosure = function() return loading.deleteLoading() end

--------------------------------------------------------------------------------
-- nextSceneOrDelete - ?
--------------------------------------------------------------------------------
local function nextSceneOrDeleteA(event)
	--print("nextSceneOrDelete")	
	if scenes[currScene] ~= nil then
		scenes[currScene]:removeEventListener("tap", nextSceneOrDeleteA)
		-- Delete scene on screen.
		scenes[currScene]:removeSelf()
		scenes[currScene] = nil	
	end
	-- Clear variables if current scene reaches levels' maximum amount of scenes
	if currScene == screensA[tempMapData.levelNum] then
<<<<<<< HEAD
=======
		-- Remove event listener from currScene
		--scenes[currScene]:removeEventListener("tap", nextSceneOrDeleteA)
>>>>>>> 195e964ecd48541425951bf9b5885b3d3b5b64cd
		-- Clear current scene
		currScene = nil
		-- Remove event listener from nextScene
		--if nextScene ~= nil then
		--	nextScene:removeEventListener("tap", nextSceneOrDeleteA)
		--	nextScene:removeSelf()
		--	nextScene = nil	
		--end
		-- Clear scenes array
		scenes = nil
		scenes = {}
		-- Run pregame timer events
		local counter = 3
		gameTimer.preGame(tempGui, tempMapData, counter)
		-- destroy loading screen
		--local loadingTimer = timer.performWithDelay(2000, deleteClosure)
		-- Clear temporary gui and mapData variables
		tempGui = nil
		tempMapData = nil
	elseif currScene == screensB[tempMapData.levelNum] then
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
		gameData.levelComplete = true
		-- destroy loading screen
		--local loadingTimer = timer.performWithDelay(2000, deleteClosure)
		-- Clear temporary gui and mapData variables
		tempGui = nil
		tempMapData = nil
	else
		currScene = currScene +1
		scenes[currScene]:addEventListener("tap", nextSceneOrDeleteA)
		scenes[currScene].isVisible = true
	end
end

--------------------------------------------------------------------------------
-- nextSceneOrDelete - ?
--------------------------------------------------------------------------------
local function nextSceneOrDeleteB(event)
	--print("nextSceneOrDelete")	
	if scenes[currScene] ~= nil then
		scenes[currScene]:removeEventListener("tap", nextSceneOrDeleteB)
		-- Delete scene on screen.
		scenes[currScene]:removeSelf()
		scenes[currScene] = nil	
	end
	-- Clear variables if current scene reaches levels' maximum amount of scenes
	if currScene == screensB[tempMapData.levelNum] then
		-- Remove event listener from currScene
		--scenes[currScene]:removeEventListener("tap", nextSceneOrDeleteB)
		-- Clear current scene
		currScene = nil
		-- Remove event listener from nextScene
		--if nextScene ~= nil then
		--	nextScene:removeEventListener("tap", nextSceneOrDeleteB)
		--	nextScene:removeSelf()
		--	nextScene = nil	
		--end
		-- Clear scenes array
		scenes = nil
		scenes = {}
		-- Run pregame timer events
		gameData.levelComplete = true
		-- destroy loading screen
		--local loadingTimer = timer.performWithDelay(2000, deleteClosure)
		-- Clear temporary gui and mapData variables
		tempGui = nil
		tempMapData = nil
	else
		currScene = currScene +1
		scenes[currScene]:addEventListener("tap", nextSceneOrDeleteB)
		scenes[currScene].isVisible = true
	end
end

--------------------------------------------------------------------------------
-- nextSceneOrDelete - ?
--------------------------------------------------------------------------------
local function cutScene(gui, mapData)
	-- Temporary store gui and mapData for use in nextSceneOrDelete
	tempGui = gui
	tempMapData = mapData
	physics.pause()
	--print(mapData.levelNum)	
	if screensA[mapData.levelNum] > 0 then
		print("mapData.levelNum", mapData.levelNum)
		for i= screensA[mapData.levelNum], 1, -1 do
			if mapData.levelNum == "8" or mapData.levelNum == "12" then
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/A/"..i..".png", 1460, 864)
				scenes[i].x, scenes[i].y = display.contentCenterX, display.contentCenterY
				scenes[i].isVisible = false
			elseif mapData.levelNum ~= "8" and mapData.levelNum ~= "12" then
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/A/"..i..".jpg", 1460, 864)
				scenes[i].x, scenes[i].y = display.contentCenterX, display.contentCenterY
				scenes[i].isVisible = false
			end				
		end
		--print("drawing next scene")
		-- Create nextScene button
		--nextScene = display.newImageRect("mapdata/art/buttons/next.png", 250, 250)
		-- map nextScene button to right corner
		--nextScene.x, nextScene.y = generate.tilesToPixels(36, 20)
		--nextScene:addEventListener("tap", nextSceneOrDeleteA)
		currScene = 1
		-- Add tap listener to play button
		scenes[currScene]:addEventListener("tap", nextSceneOrDeleteA)
		scenes[currScene].isVisible = true
	else
		local counter = 3
		gameTimer.preGame(tempGui, tempMapData, counter)
	end
	
end

--------------------------------------------------------------------------------
-- endCutScene(gui, mapData) - plays when level contains a cutscene
--------------------------------------------------------------------------------
local function endCutScene(gui, mapData)
	-- Temporary store gui and mapData for use in nextSceneOrDelete
	tempGui = gui
	tempMapData = mapData
	
	--print(mapData.levelNum)	
<<<<<<< HEAD
	if screensA[mapData.levelNum] > 0 then
		for i= screensA[mapData.levelNum], 1, -1 do
			if mapData.levelNum ~= 8 and mapData.levelNum ~= 12 then
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/A/"..i..".jpg", 1460, 864)
			else
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/A/"..i..".png", 1460, 864)
			end				
=======
	if screensB[mapData.levelNum] > 0 then
		for i= screensB[mapData.levelNum], 1, -1 do
			if mapData.levelNum ~= "6" then
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/B/"..i..".jpg", 1460, 864)
				scenes[i].isVisible = false
			else
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/B/"..i..".png", 1460, 864)
				scenes[i].isVisible = false
			end
			
>>>>>>> 195e964ecd48541425951bf9b5885b3d3b5b64cd
			scenes[i].x, scenes[i].y = display.contentCenterX, display.contentCenterY
		end
		--print("drawing next scene")
		-- Create nextScene button
		--nextScene = display.newImageRect("mapdata/art/buttons/next.png", 250, 250)
		-- map nextScene button to right corner
<<<<<<< HEAD
		nextScene.x, nextScene.y = generate.tilesToPixels(36, 20)
		-- Add tap listener to play button
		nextScene:addEventListener("tap", nextSceneOrDelete)
=======
		--nextScene.x, nextScene.y = generate.tilesToPixels(36, 20)
		--nextScene:addEventListener("tap", nextSceneOrDeleteB)
>>>>>>> 195e964ecd48541425951bf9b5885b3d3b5b64cd
		currScene = 1
		-- Add tap listener to play button
		scenes[currScene]:addEventListener("tap", nextSceneOrDeleteB)
		scenes[currScene].isVisible = true
	else
		gameData.levelComplete = true
	end
	
end

--------------------------------------------------------------------------------
-- endCutScene(gui, mapData) - plays when level contains a cutscene
--------------------------------------------------------------------------------
local function endCutScene(gui, mapData)
	-- Temporary store gui and mapData for use in nextSceneOrDelete
	tempGui = gui
	tempMapData = mapData
	
	--print(mapData.levelNum)	
	if screensB[mapData.levelNum] > 0 then
		for i= screensB[mapData.levelNum], 1, -1 do
			if mapData.levelNum ~= 6 then
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/B/"..i..".jpg", 1460, 864)
			else
				scenes[i] = display.newImageRect("mapdata/art/cutscenes/"..mapData.levelNum.."/B/"..i..".png", 1460, 864)
			end
			
			scenes[i].x, scenes[i].y = display.contentCenterX, display.contentCenterY
		end
		--print("drawing next scene")
		-- Create nextScene button
		nextScene = display.newImageRect("mapdata/art/buttons/next.png", 250, 250)
		-- map nextScene button to right corner
		nextScene.x, nextScene.y = generate.tilesToPixels(36, 20)
		-- Add tap listener to play button
		nextScene:addEventListener("tap", nextSceneOrDelete)
		currScene = 1
	else
		gameData.levelComplete = true
	end
end


local cutSceneSystem= {
	cutScene = cutScene,
	endCutScene = endCutScene
}

return cutSceneSystem