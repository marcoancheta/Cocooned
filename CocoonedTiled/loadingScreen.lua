local loadingBG = nil
local loadWolf = nil
local loadBar = nil
local loadText = nil
local wolfSheet = nil
local cSS = require("cutSceneSystem")

function loadingInit(loadGroup)
	loadingBG = display.newImage('mapdata/art/bg2.jpg', 10, 20,true )
	loadText = display.newText("Loading",800, 200, native.systemFontBold, 280, "center")
	loadBar = {
		display.newImage('mapdata/art/iceWall.png',200,500,true), 
		display.newImage('mapdata/art/iceWall.png',416,500,true), 
		display.newImage('mapdata/art/iceWall.png',632,500,true), 
		display.newImage('mapdata/art/iceWall.png',848,500,true), 
		display.newImage('mapdata/art/iceWall.png',1064,500,true), 
		display.newImage('mapdata/art/iceWall.png',1280,500,true)
	}
	loadingBG:toFront()
	loadText:toFront()
	for i=1, 6 do
		loadBar[i]:toFront()
		loadBar[i].isVisible=false
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
function updateLoading(int)
	--loadBar[int].isVisible=true
	--loadBar[int]:toFront()
	--loadWolf:play()
	return true
end

function deleteLoading(level)
	l = tonumber(level)
	if  l > 0 then
		--cSS.cutScene(l)
	end
	for i=1, 6 do
		loadBar[i]:removeSelf()
	end
	loadingBG:removeSelf()
	loadText:removeSelf()
	--loadWolf:removeSelf()
	loadingBG = nil
	--loadWolf = nil
	loadBar = nil
	loadText = nil
	--while cSS.cutSceneDone == false
end

local loadingScreen = {
	loadingInit = loadingInit,
	updateLoading = updateLoading,
	deleteLoading=deleteLoading
}

return loadingScreen
