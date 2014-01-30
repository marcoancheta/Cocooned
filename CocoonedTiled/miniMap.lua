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

	

	local currentPane = display.newRect(720, 432, 380, 236)
	currentPane:setFillColor(1,0,0)

	-- add images to group
	miniMap:insert(1,bg)
	miniMap:insert(2,currentPane)
	miniMap:insert(3,Mpane)
	miniMap:insert(4,Upane)
	miniMap:insert(5,Dpane)
	miniMap:insert(6,Lpane)
	miniMap:insert(7,Rpane)

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

local miniMapMovement = 0

function updateMiniMap(mapData, miniMap, swipeX, swipeY)

	if math.abs(swipeX) > math.abs(swipeY) and math.abs(swipeX) > 40 then

		if mapData.pane == "M" or mapData.pane == "R" or mapData.pane == "L" then
			if swipeX > 0 and miniMapMovement < 400 and mapData.pane ~= "R" then
				for m = 3, 7 do
					miniMap[m].x = miniMap[m].x + 20
				end
				miniMapMovement = miniMapMovement + 20
			elseif swipeX < 0 and miniMapMovement < 400  and mapData.pane ~= "L" then
				for m = 3, 7 do
					miniMap[m].x = miniMap[m].x - 20
				end
				miniMapMovement = miniMapMovement + 20
			end
			
		end

	elseif math.abs(swipeX) < math.abs(swipeY) and math.abs(swipeY) > 25 then

		if mapData.pane == "M" or mapData.pane == "U" or mapData.pane == "D" then
			if swipeY > 0 and miniMapMovement < 240 and mapData.pane ~= "U" then
				for m = 3, 7 do
					miniMap[m].y = miniMap[m].y + 20
				end
				miniMapMovement = miniMapMovement + 20
			elseif swipeY < 0 and miniMapMovement < 240 and mapData.pane ~= "D" then
				for m = 3, 7 do
					miniMap[m].y = miniMap[m].y - 20
				end
				miniMapMovement = miniMapMovement + 20
			end
			
		end
	end
end

function resetMiniMap()
	miniMapMovement = 0
end

local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap,
	resetMiniMap = resetMiniMap
}

return miniMap