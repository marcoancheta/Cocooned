--TODO: add in levels that have cutscenes
--TODO: Add Variable to gameData to show that player is in cutscene?
-- Timer
local gameTimer = require("utils.timer")
local numberOfScreens= {["LS"] = 0, ["1"] = 3, ["2"] = 0, ["3"] = 0, ["4"] = 0, ["5"] = 0, ["6"] = 0, ["7"] = 0, ["8"] = 0, ["9"] = 0, ["10"] = 0, ["11"] = 0, ["12"] = 0, ["13"] = 0, ["14"] = 0, ["15"] = 0} --level number, number of cutscenes
local levNum = 0
local currScene = 0
local loadingBG={}
local nextScene
local lgui
local lmapdata

local function nextSceneOrDelete()
	print("nextSceneOrDelete")
	loadingBG[currScene]:removeSelf()
	loadingBG[currScene] = nil
	if currScene == numberOfScreens[levNum] then
		nextScene:removeEventListener("tap", nextSceneOrDelete)
		nextScene:removeSelf()
		nextScene = nil
		currScene = nil
		levNum = nil
		loadingBG = nil
		loadingBG = {}
		gameTimer.preGame(lgui, lmapdata)
		lgui = nil
		lmapdata = nil
	else
		currScene = currScene +1
	end
end

local function cutScene(gui, mapdata)
	levNum = mapdata.levelNum
	lgui = gui
	lmapdata = mapdata
	print(mapdata.levelNum)
	if numberOfScreens[mapdata.levelNum] > 0 then
		for i= numberOfScreens[mapdata.levelNum],1,-1 do
			loadingBG[i] = display.newImage("mapdata/art/cutscenes/OLD/level"..mapdata.levelNum .. "Scene" .. i .. ".png", 700, 432,true )
		end
		print("drawing next scene")
		nextScene = display.newImage("mapdata/art/buttons/play.png", 1200, 732,true )
		nextScene:scale(.25, .25)
		nextScene:addEventListener("tap", nextSceneOrDelete)
		currScene = 1
	else
		gameTimer.preGame(lgui, lmapdata)
	end
end



local cutSceneSystem= {
	cutScene = cutScene
}

return cutSceneSystem