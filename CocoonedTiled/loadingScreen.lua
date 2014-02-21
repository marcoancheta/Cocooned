local loadingBG = nil
local loadWolf = nil
local wolfSheet = nil
local cSS = require("cutSceneSystem")

function loadingInit(loadGroup)
	loadingBG = display.newImage('mapdata/art/LoadingScreen2.png', 724, 450, true )
	loadingBG:scale(1.095, 1.095)

	loadingBG:toFront()

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

	loadingBG:removeSelf()
	--loadWolf:removeSelf()
	loadingBG = nil
	--loadWolf = nil
	--while cSS.cutSceneDone == false
end

local loadingScreen = {
	loadingInit = loadingInit,
	updateLoading = updateLoading,
	deleteLoading=deleteLoading
}

return loadingScreen
