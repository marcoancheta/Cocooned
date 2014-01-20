--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local gameData = require("gameData")

function createMiniMap(mapData)
	-- create new display group
	local miniMap = display.newGroup()

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)

	-- create pane images
	local Mpane = display.newImage("mapdata/levels/temp/tmx/M.png")
	local Upane = display.newImage("mapdata/levels/temp/tmx/U.png")
	local Dpane = display.newImage("mapdata/levels/temp/tmx/D.png")
	local Lpane = display.newImage("mapdata/levels/temp/tmx/L.png")
	local Rpane = display.newImage("mapdata/levels/temp/tmx/R.png")

	-- scale images
	Mpane:scale(0.25, 0.25)
	Upane:scale(0.25, 0.25)
	Dpane:scale(0.25, 0.25)
	Lpane:scale(0.25, 0.25)
	Rpane:scale(0.25, 0.25)

	-- set image locations
	Mpane.x, Mpane.y = 720, 432
	Upane.x, Upane.y = 720, 672
	Dpane.x, Dpane.y = 720, 192
	Lpane.x, Lpane.y = 320, 432
	Rpane.x, Rpane.y = 1120, 432

	-- create highlight for current pane
	local x, y
	if mapData.pane == "M" then
		x, y = Mpane.x , Mpane.y
	elseif mapData.pane == "U" then
		x, y = Upane.x , Upane.y
	elseif mapData.pane == "D" then
		x, y = Dpane.x , Dpane.y
	elseif mapData.pane == "L" then
		x, y = Lpane.x , Lpane.y
	elseif mapData.pane == "R" then
		x, y = Rpane.x , Rpane.y
	end

	local currentPane = display.newRect(x,y, 380, 236)
	currentPane:setFillColor(1,0,0)

	-- add images to group
	miniMap:insert(bg)
	miniMap:insert(currentPane)
	miniMap:insert(Mpane)
	miniMap:insert(Upane)
	miniMap:insert(Dpane)
	miniMap:insert(Lpane)
	miniMap:insert(Rpane)

	miniMap.alpha = 0.75

	return miniMap
end

local miniMap = {
	createMiniMap = createMiniMap
}

return miniMap