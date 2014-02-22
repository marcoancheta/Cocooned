--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")

local dusk = require("Dusk.Dusk")
local objects = require("objects")

--------------------------------------------------------------------------------
-- create miniMap
--------------------------------------------------------------------------------
function createMiniMap(mapData, player, map)

	local miniMapTable = {}
		
	local miniMap = display.newGroup()
	

	miniMapTable[1] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/M.png")
	miniMapTable[2] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/U.png")
	miniMapTable[3] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/D.png")
	miniMapTable[4] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/R.png")
	miniMapTable[5] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/L.png")

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)
	
	local currentPane = display.newRect(720, 432, 390, 236)
	currentPane:setFillColor(0,0,0)

	-- add images to group
	miniMap:insert(1,bg)
	miniMap:insert(2,currentPane)

	for i=1, #miniMapTable do
		local mapX, mapY = 720, 432
		if i == 2 then mapY = mapY + 240
		elseif i == 3 then mapY = mapY - 240
		elseif i == 4 then mapX = mapX - 400
		elseif i == 5 then mapX = mapX + 400
		end
		miniMapTable[i].x, miniMapTable[i].y = mapX, mapY
		miniMapTable[i]:scale(0.25,0.25)
		miniMapTable.name = "miniMapBlah"
		miniMap:insert(i+2, miniMapTable[i])

	end

	-- create highlight for current pane
	for m = 3, 7 do
		if mapData.pane == "U" then
			miniMap[m].y = miniMap[m].y + 240
		elseif mapData.pane == "D" then
			miniMap[m].y = miniMap[m].y - 240
		elseif mapData.pane == "L" then
			miniMap[m].x = miniMap[m].x - 400
		elseif mapData.pane == "R" then
			miniMap[m].x = miniMap[m].x + 400
		end
	end

	local inventoryDisplay = display.newGroup()
	inventoryDisplay.size = 0

	--local inventoryText = display.newText("Inventory:", 280, 180, native.systemFont, 48)
	--inventoryText:setFillColor(0,0,0)
	--inventoryDisplay:insert(inventoryText)

	miniMap:insert(8, inventoryDisplay)

	miniMap.alpha = 0
	
	return miniMap
end

local miniMapMovement = 0


--------------------------------------------------------------------------------
-- update miniMap
--------------------------------------------------------------------------------
function updateMiniMap(mapData, miniMap, map, player)
	
	player.imageObject.isVisible = false
	local pane = display.capture(map)
	if mapData.pane == "M" then
		
		miniMap:remove(3)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 432

		miniMap:insert(3, pane)
		
	elseif mapData.pane == "D" then

		miniMap:remove(5)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 192

		miniMap:insert(5, pane)

	elseif mapData.pane == "U" then

		miniMap:remove(4)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 672

		miniMap:insert(4, pane)
	elseif mapData.pane == "L" then

		miniMap:remove(7)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 1120, 432

		miniMap:insert(7, pane)

	elseif mapData.pane == "R" then

		miniMap:remove(6)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 320, 432

		miniMap:insert(6, pane)
	end
	player.imageObject.isVisible = true

	--checkInventory(miniMap[8], player)
end

function moveMiniMap(miniMap, mapData, event)
	local tempPane = mapData.pane

	--720, 432
	if event.y > 312 and event.y < 552 then
		if event.x > 920  then
			miniMap[2].x = 1120
		elseif event.x < 520 then
			miniMap[2].x = 320
		elseif event.x < 920 and event.x > 520 then
			miniMap[2].x = 720
		end
		miniMap[2].y = 432
	elseif event.x < 920 and event.x > 520 then
		if event.y > 552  then
			miniMap[2].y = 672
		elseif event.y < 312 then
			miniMap[2].y = 192
		elseif event.y < 552 and event.y > 312 then
			miniMap[2].y = 432
		end	
		miniMap[2].x = 720
	end

	local check = miniMap[2]

	if check.x == miniMap[3].x and check.y == miniMap[3].y then
		mapData.pane = "M"
	elseif check.x == miniMap[4].x and check.y == miniMap[4].y then
		mapData.pane = "U"
	elseif check.x == miniMap[5].x and check.y == miniMap[5].y then
		mapData.pane = "D"
	elseif check.x == miniMap[6].x and check.y == miniMap[6].y then
		mapData.pane = "R"
	elseif check.x == miniMap[7].x and check.y == miniMap[7].y then
		mapData.pane = "L"
	end

	return tempPane
end

function checkInventory(invDisplay, player)
	-- add in inventory goal
	if #player.inventory.items > invDisplay.size then
		for count = invDisplay.size+1, #player.inventory.items do
			local itemName = player.inventory.items[count]
			local itemDisplay = display.newImage("mapdata/items/" .. tostring(itemName) .. ".png")
			itemDisplay.x, itemDisplay.y = 130+ (30 *count), 250
			invDisplay:insert(itemDisplay)
			invDisplay.size = invDisplay.size + 1
		end
	end
end

local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap,
	moveMiniMap = moveMiniMap,
}


return miniMap