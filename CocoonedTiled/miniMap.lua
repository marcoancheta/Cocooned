--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local gameData = require("gameData")

function createMiniMap(mapData, player)

	gameData.allowPaneSwitch = false

	-- create new display group
	local miniMap = display.newGroup()

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)

	-- create pane images
	local Mpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/M.png")
	local Upane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/U.png")
	local Dpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/D.png")
	local Lpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/L.png")
	local Rpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/R.png")

	-- scale images
	Mpane:scale(0.25, 0.25)
	Upane:scale(0.25, 0.25)
	Dpane:scale(0.25, 0.25)
	Lpane:scale(0.25, 0.25)
	Rpane:scale(0.25, 0.25)

	-- set image locations
	Mpane.x, Mpane.y = 720, 432
	Dpane.x, Dpane.y = 720, 672
	Upane.x, Upane.y = 720, 192
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
	miniMap:insert(1,bg)
	miniMap:insert(2,currentPane)
	miniMap:insert(3,Mpane)
	miniMap:insert(4,Upane)
	miniMap:insert(5,Dpane)
	miniMap:insert(6,Lpane)
	miniMap:insert(7,Rpane)
	
	if #player.inventory.items > 0 then
		for count = 1, #player.inventory.items do
			local item = player.inventory.items[1]
			local displayItem = display.newImage("mapdata/art/" .. player.inventory.items[count].name .. ".png")
			displayItem.x, displayItem.y = 100, 100
			miniMap:insert(displayItem)
		end
	end

	miniMap.alpha = 0.75

	return miniMap
end

function updateMiniMap(mapData, miniMap, swipeX, swipeY)

	local pSW1, pSW2

	if math.abs(swipeX) > math.abs(swipeY) and math.abs(swipeX) > 40 then

		if mapData.pane == "M" then
			pSW1, pSW2 = 6, 7
		elseif mapData.pane == "R" then
			pSW1, pSW2 = 3, 6
		elseif mapData.pane == "L" then
			pSW1, pSW2 = 7, 3
		else
			pSW1, pSW2 = 4, 5
		end

		if swipeX > 0 and miniMap[2].x > miniMap[pSW1].x then
			miniMap[2].x = miniMap[2].x - 20
		elseif swipeX < 0 and miniMap[2].x < miniMap[pSW2].x then
			miniMap[2].x = miniMap[2].x + 20
		end

	elseif math.abs(swipeX) < math.abs(swipeY) and math.abs(swipeY) > 40 then

		if mapData.pane == "M" then
			pSW1, pSW2 = 4, 5
		elseif mapData.pane == "U" then
			pSW1, pSW2 = 5, 3
		elseif mapData.pane == "D" then
			pSW1, pSW2 = 3, 4
		else
			pSW1, pSW2 = 6, 7
		end
		if swipeY > 0 and miniMap[2].y > miniMap[pSW1].y then
			miniMap[2].y = miniMap[2].y - 20
		elseif swipeY < 0 and miniMap[2].y < miniMap[pSW2].y then
			miniMap[2].y = miniMap[2].y + 20
		end
	end



end

local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap
}

return miniMap