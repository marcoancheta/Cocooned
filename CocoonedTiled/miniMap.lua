--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- Dusk Enginer (Dusk.lua)
local dusk = require("Dusk.Dusk")


--------------------------------------------------------------------------------
-- create miniMap - function that creats miniMap display
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function createMiniMap(mapData, player, map)

	--hold miniMap panes
	local miniMapTable = {}
	
	-- create new mini map display group
	local miniMap = display.newGroup()
	
	-- set miniMap pane images
	miniMapTable[1] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/M.png")
	miniMapTable[2] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/U.png")
	miniMapTable[3] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/D.png")
	miniMapTable[4] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/R.png")
	miniMapTable[5] = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/L.png")

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)
	
	-- create current pane highlight display
	local currentPane = display.newRect(720, 432, 390, 236)
	currentPane:setFillColor(0,0,0)

	-- add images to group
	miniMap:insert(1,bg)
	miniMap:insert(2,currentPane)

	-- move miniMap panes depending on which pane it is
	for i=1, #miniMapTable do
		local mapX, mapY = 720, 432
		if i == 2 then mapY = mapY + 240
		elseif i == 3 then mapY = mapY - 240
		elseif i == 4 then mapX = mapX - 400
		elseif i == 5 then mapX = mapX + 400
		end
		-- set location and scale
		miniMapTable[i].x, miniMapTable[i].y = mapX, mapY
		miniMapTable[i]:scale(0.25,0.25)
		miniMapTable.name = "miniMap" .. i

		-- insert miniMap pane to miniMap display group
		miniMap:insert(i+2, miniMapTable[i])

	end

	-- set current pane highlight to current pane player is in
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

	-- set panes not in use to invisible
	for m = 1,5 do
		if map.panes[m] == false then
			print("remove:", count)
			miniMap[m+2].isVisible = false
		end
	end

	-- create inventory dispay group
	local inventoryDisplay = display.newGroup()
	inventoryDisplay.size = 0

	-- set inventory text
	--[[
	local inventoryText = display.newText("Inventory:", 280, 180, native.systemFont, 48)
	inventoryText:setFillColor(0,0,0)
	inventoryDisplay:insert(inventoryText)

	-- insert inventory display to miniMap display
	miniMap:insert(8, inventoryDisplay)
	]]

	-- set miniMap to invisible until it is needed
	miniMap.alpha = 0
	
	-- return mini map display
	return miniMap
end

--------------------------------------------------------------------------------
-- Update miniMap - function that updates miniMap
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function updateMiniMap(mapPane, miniMap, map, player)
	
	-- set player image object to invisible for display capture
	player.imageObject.isVisible = false

	-- capture display group image for new miniMap display
	local pane = display.capture(map)

	-- depending on current Pane and save captured display
	-- group to that miniMap display index
	if map.panes[1] == true and mapPane == "M" then
		
		-- remove Main miniMap pane and replace
		miniMap:remove(3)

		-- scale display capture and set location
		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 432

		-- insert new miniMap pane into miniMap Display
		-- and set current pane highlight to that pane
		miniMap:insert(3, pane)
		miniMap[2].x, miniMap[2]. y = 720, 432
		
	elseif map.panes[3] == true and mapPane == "D" then

		miniMap:remove(5)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 192

		miniMap:insert(5, pane)
		miniMap[2].x, miniMap[2]. y = 720, 192

	elseif map.panes[2] == true and mapPane == "U" then

		miniMap:remove(4)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 720, 672

		miniMap:insert(4, pane)
		miniMap[2].x, miniMap[2]. y = 720, 672

	elseif map.panes[5] == true and mapPane == "L" then

		miniMap:remove(7)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 1120, 432

		miniMap:insert(7, pane)
		miniMap[2].x, miniMap[2]. y = 1120, 432

	elseif map.panes[4] == true and mapPane == "R" then

		miniMap:remove(6)

		pane:scale(0.24, 0.25)
		pane.x, pane.y = 320, 432

		miniMap:insert(6, pane)
		miniMap[2].x, miniMap[2]. y = 320, 432

	end

	-- set player image object to visible once update is done
	player.imageObject.isVisible = true

	--checkInventory(miniMap[8], player)
end

--------------------------------------------------------------------------------
-- Move miniMap - function that moves current pane highlight
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveMiniMap(miniMap, mapData, map, event)

	-- hold current pane for later use
	local tempPane = mapData.pane

	-- check where player has tapped
	-- and move current pane highlight to where player has tapped
	if event.y > 312 and event.y < 552 then
		if map.panes[5] == true and event.x > 920  then
			miniMap[2].x = 1120
			miniMap[2].y = 432
		elseif map.panes[4] == true and event.x < 520 then
			miniMap[2].x = 320
			miniMap[2].y = 432
		elseif event.x < 920 and event.x > 520 then
			miniMap[2].x = 720
			miniMap[2].y = 432
		end
	elseif event.x < 920 and event.x > 520 then
		if map.panes[2] == true and event.y > 552  then
			miniMap[2].y = 672
			miniMap[2].x = 720
		elseif map.panes[3] == true and event.y < 312 then
			miniMap[2].y = 192
			miniMap[2].x = 720
		end
	end

	-- save current pane highlight for check
	local check = miniMap[2]

	-- check where current pane highlight is and 
	-- and set pane to that selected one
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

	-- return saved pane for later check
	return tempPane
end

--------------------------------------------------------------------------------
-- Check Inventory - function that checks inventory of player and sets images
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function checkInventory(invDisplay, player)
	-- add in inventory goal
	if #player.inventory.items > invDisplay.size then
		for count = invDisplay.size+1, #player.inventory.items do
			local itemName = player.inventory.items[count]
			local itemDisplay = display.newImage("mapdata/art/" .. tostring(itemName) .. ".png")
			itemDisplay.x, itemDisplay.y = 130+ (30 *count), 250
			invDisplay:insert(itemDisplay)
			invDisplay.size = invDisplay.size + 1
		end
	end
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap,
	moveMiniMap = moveMiniMap,
}


return miniMap

-- end of miniMap.lua