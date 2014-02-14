local loadingBG = nil
local loadWolf = nil
local loadBar = nil
local loadText = nil
local wolfSheet = nil

function loadingInit(loadGroup)
	loadingBG = display.newImage('mapdata/art/bg2.jpg', 10, 20,true )
	--add text

	--add 6 icewalls right next to each other then hide all
	loadBar = {display.newImage('mapdata/art/iceWall3.png',0+200,500,true), display.newImage('mapdata/art/iceWall.png',216+200,500,true), display.newImage('mapdata/art/iceWall.png',432+200,500,true), display.newImage('mapdata/art/iceWall.png',648+200,500,true), display.newImage('mapdata/art/iceWall.png',648+216+200,500,true), display.newImage('mapdata/art/iceWall.png',648+432+200,500,true)}
	loadingBG:toFront()
	loadBar[1]:toFront()
	loadBar[2]:toFront()
	loadBar[3]:toFront()
	loadBar[4]:toFront()
	loadBar[5]:toFront()
	loadBar[6]:toFront()
	loadBar[1].isVisible=false
	loadBar[2].isVisible=false
	loadBar[3].isVisible=false
	loadBar[4].isVisible=false
	loadBar[5].isVisible=false
	loadBar[6].isVisible=false

	loadText = display.newText("Loading",800, 200, native.systemFontBold, 280, "center")

	--[[add wolf image sheet and frame reference
	wolfSheet = graphics.newImageSheet( "mapdata/graphics/wolfSheet.png", {width = 1000, height = 491, sheetContentWidth = 8000, sheetContentHeight = 491, numFrames = 8} )
	loadWolf = display.newSprite( wolfSheet, spriteOptions.loadWolf )
	loadWolf.x = display.contentWidth/1.9  --center the sprite horizontally
	loadWolf.y = display.contentHeight/1.4  --center the sprite vertically	
	loadWolf = display.newSprite(wolfSheet, spriteOptions.loadWolf)
	loadWolf.speed = 50
	loadWolf.isVisible = false
	loadWolf.isBodyActive = true
    loadWolf.collision = onLocalCollision
    loadWolf:setSequence( "move" )
    --]]

end
function updateLoading(int)
	loadBar[int].isVisible=true
	loadBar[int]:toFront()
	--loadWolf:play()
	return true
end

function deleteLoading()
	loadBar[1]:removeSelf()
	loadBar[2]:removeSelf()
	loadBar[3]:removeSelf()
	loadBar[4]:removeSelf()
	loadBar[5]:removeSelf()
	loadBar[6]:removeSelf()
	loadingBG:removeSelf()
	loadText:removeSelf()
	--loadWolf:removeSelf()
	loadingBG = nil
	--loadWolf = nil
	loadBar = nil
	loadText = nil
end

local loadingScreen = {
	loadingInit = loadingInit,
	updateLoading = updateLoading,
	deleteLoading=deleteLoading
}

return loadingScreen
