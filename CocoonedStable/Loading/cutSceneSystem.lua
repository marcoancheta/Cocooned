--TODO: add in levels that have cutscenes
--TODO: Add Variable to gameData to show that player is in cutscene?
local numberOfScreens= {[1]=3} --level number, number of cutscenes
local levNum = 0
local currScene = 0
local loadingBG={}
local localGui

local function nextSceneOrDelete()
	print("nextSceneOrDelete")
	loadingBG[currScene]:removeSelf()
	loadingBG[currScene] = nil
	if currScene == numberOfScreens[levNum] then
		localGui.back:removeEventListener("tap", nextSceneOrDelete)
		currScene = nil
		levNum = nil
		loadingBG = nil
	else
		currScene = currScene +1
	end
end

local function cutScene(levelNumber, gui)
	localGui = gui
	levNum = levelNumber
	for i= numberOfScreens[levelNumber],1,-1 do
		loadingBG[i] = display.newImage("mapdata/art/cutscenes/OLD/level"..levelNumber .. "Scene" .. i .. ".png", 10, 20,true )
	end
	localGui.back:addEventListener("tap", nextSceneOrDelete)
	currScene = 1
end



local cutSceneSystem= {
	cutScene = cutScene
}

return cutSceneSystem