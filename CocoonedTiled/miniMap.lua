--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local gameData = require("gameData")

-- variables for panes
local Mpane, Upane, Dpane, Lpane, Rpane

--------------------------------------------------------------------------------
-- create miniMap
--------------------------------------------------------------------------------
function createMiniMap(mapData, player)

	gameData.allowPaneSwitch = false

	-- create new display group
	local miniMap = display.newGroup()

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)

	-- create pane images
	Mpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/M.png")
	Upane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/U.png")
	Dpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/D.png")
	Lpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/R.png")
	Rpane = display.newImage("mapdata/levels/" .. mapData.levelNum .. "/tmx/L.png")

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
	
	-- set miniMap to first be invisible
	miniMap.alpha = 0

	return miniMap
end

local miniMapMovement = 0


--------------------------------------------------------------------------------
-- update miniMap
--------------------------------------------------------------------------------
function updateMiniMap(mapData, miniMap, swipeX, swipeY)

	-- if swiping to right of left, move miniMap for feedback
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

	-- if swiping up or down, move miniMap for feedback
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

--------------------------------------------------------------------------------
-- reset miniMap
--------------------------------------------------------------------------------
function resetMiniMap(miniMap, mapData)

	-- set image locations
	Mpane.x, Mpane.y = 720, 432
	Dpane.x, Dpane.y = 720, 672
	Upane.x, Upane.y = 720, 192
	Lpane.x, Lpane.y = 320, 432
	Rpane.x, Rpane.y = 1120, 432

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

	-- reset miniMap movement
	miniMapMovement = 0

end

local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap,
	resetMiniMap = resetMiniMap
}

return miniMap