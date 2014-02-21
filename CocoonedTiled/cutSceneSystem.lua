--TODO: add in levels that have cutscenes
local numberOfScreens= {[1]=3} --level number, number of cutscenes
local levNum = 0
local currScene = 0
local loadingBG={}

function cutScene(levelNumber)
	levNum = levelNumber
	for i= numberOfScreens[levelNumber]-1,0,-1 do
		loadingBG[i] = display.newImage("mapdata/cutscenes/level"..levelNumber .. "scene" .. i .. ".jpg", 10, 20,true )
	end
	gui.back:addEventListener("tap", nextSceneOrDelete)
	currScene = numberOfScreens[levelNumber]
end

function nextSceneOrDelete()
	loadingBG[currScene]:removeSelf()
	loadingBG[currScene] = nil
	currScene = currScene -1
	if currScene == 0 then
		gui.back:removeEventListener("tap", nextSceneOrDelete)
		currScene = nil
		levNum = nil
		loadingBG = nil
	end
end

local cutSceneSystem= {
	cutScene = cutScene
}

return cutSceneSystem