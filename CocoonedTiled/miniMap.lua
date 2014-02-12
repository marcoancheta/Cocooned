--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- miniMap.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")

local dusk = require("Dusk.Dusk")

local prevInventory

--------------------------------------------------------------------------------
-- create miniMap
--------------------------------------------------------------------------------
function createMiniMap(mapData, player)
		
	local miniMap = display.newGroup()
	
	local mPane = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/M.json")
	local dPane = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/D.json")
	local uPane = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/U.json")
	local lPane = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/L.json")
	local rPane = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/R.json")

	local Mpane = display.capture(mPane)
	local Dpane = display.capture(dPane)
	local Upane = display.capture(uPane)
	local Lpane = display.capture(lPane)
	local Rpane = display.capture(rPane)
	
	Mpane:scale(0.25,0.25)
	Mpane.x , Mpane.y = 720, 432

	Dpane:scale(0.25,0.25)
	Dpane.x , Dpane.y = 720, 672

	Upane:scale(0.25,0.25)
	Upane.x , Upane.y = 720, 192

	Lpane:scale(0.25,0.25)
	Lpane.x , Lpane.y = 320, 432

	Rpane:scale(0.25,0.25)
	Rpane.x , Rpane.y = 1120, 432

	-- create background image
	local bg = display.newRect(720, 432, 1540, 864)
	bg:setFillColor(0.5,0.5,0.5)
	
	local currentPane = display.newRect(720, 432, 380, 236)
	currentPane:setFillColor(1,1,1)

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
		miniMap[m].name = m
	end

	mPane.destroy()
	dPane.destroy()
	uPane.destroy()
	lPane.destroy()
	rPane.destroy()

	mPane:removeSelf()
	dPane:removeSelf()
	uPane:removeSelf()
	lPane:removeSelf()
	rPane:removeSelf()

	mPane = nil
	dPane = nil
	uPane = nil
	lPane = nil
	rPane = nil

	Mpane:removeSelf()
	Dpane:removeSelf()
	Upane:removeSelf()
	Lpane:removeSelf()
	Rpane:removeSelf()
	bg:removeSelf()
	currentPane:removeSelf()
	
	miniMap.alpha = 0.5

	--[[
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
	currentPane:setFillColor(1,1,1)

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

	-- set inventory count for miniMap display
	prevInventory = 0
	]]
	return miniMap
end

local miniMapMovement = 0


--------------------------------------------------------------------------------
-- update miniMap
--------------------------------------------------------------------------------
function updateMiniMap(mapData, miniMap, swipeX, swipeY)


	--[[
	for m = 3, 7 do
		if swipeD == "R" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x + 400, y = miniMap[m].y, onComplete = hideMiniMap})
		elseif swipeD == "L" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x - 400, y = miniMap[m].y, onComplete = hideMiniMap})
		elseif swipeD == "U" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x, y = miniMap[m].y + 240, onComplete = hideMiniMap})
		elseif swipeD == "D" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x, y = miniMap[m].y - 240, onComplete = hideMiniMap})
		elseif swipeD == "DR" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x + 400, y = miniMap[m].y - 240, onComplete = hideMiniMap})
		elseif swipeD == "DL" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x - 400, y = miniMap[m].y - 240, onComplete = hideMiniMap})
		elseif swipeD == "UR" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x + 400, y = miniMap[m].y + 240, onComplete = hideMiniMap})
		elseif swipeD == "UL" then
			transition.to(miniMap[m], {time = 200, x = miniMap[m].x - 400, y = miniMap[m].y + 240, onComplete = hideMiniMap})

		end

	end
	
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
			--
			if mapData.pane ~= "M" then
				if swipeY > 40 and miniMapMovement < 400 then
					for m = 3, 7 do
						miniMap[m].y = miniMap[m].y + 13
					end
				elseif swipeY < -40 and miniMapMovement < 400 then
					for m = 3, 7 do
						miniMap[m].y = miniMap[m].y - 13
					end
				end
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
			--
			if mapData.pane ~= "M" then
				if swipeX > 40 and miniMapMovement < 400 then
					for m = 3, 7 do
						miniMap[m].x = miniMap[m].x + 13
					end
				elseif swipeX < -40 and miniMapMovement < 400 then
					for m = 3, 7 do
						miniMap[m].x = miniMap[m].x - 13
					end
				end
			end
			
		end
	end
	]]

	--[[
		local mmCheck = miniMap[7]

	
		for m = 3, 7 do
			if mapData.pane == "M" then
				if swipeX > 0 and math.abs(swipeY) < 150  and miniMapMovement < 2100 then
					miniMap[m].x = miniMap[m].x + 20
				elseif swipeX < 0 and math.abs(swipeY) < 150 and miniMapMovement < 2100 then
					miniMap[m].x = miniMap[m].x - 20
				elseif swipeY > 0 and math.abs(swipeX) < 150 and miniMapMovement < 1300 then
					miniMap[m].y = miniMap[m].y + 20
				elseif swipeY < 0 and math.abs(swipeX) < 150 and miniMapMovement < 1300 then
					miniMap[m].y = miniMap[m].y - 20
				end
				miniMapMovement = miniMapMovement + 20
			elseif mapData.pane ~= "M" and mapData.pane ~= "U" and mapData.pane ~= "D" then
				if math.abs(swipeY) > 80 and mmCheck.x ~= 1120 and mmCheck.x ~= 720 then
					if swipeY > 0 and mmCheck.y < 672 then
						miniMap[m].y = miniMap[m].y + 22
					elseif swipeY < 0 and mmCheck.y > 192 then
						miniMap[m].y = miniMap[m].y - 22
					end
					if swipeX > 0 then
						miniMap[m].x = miniMap[m].x + 20
					else
						miniMap[m].x = miniMap[m].x - 20
					end
				elseif swipeX < 0 and math.abs(swipeY) < 250  and mmCheck.x > 1120 then
					miniMap[m].x = miniMap[m].x - 20
				elseif swipeX > 0 and math.abs(swipeY) < 250  and mmCheck.x < 1120 then
					miniMap[m].x = miniMap[m].x + 20
				end
				miniMapMovement = miniMapMovement + 20
			elseif mapData.pane ~= "M" and mapData.pane ~= "L" and mapData.pane ~= "R" then
				if math.abs(swipeX) > 80 and mmCheck.y ~= 432 then
					if swipeX > 0 and mmCheck.x < 1520 then
						miniMap[m].x = miniMap[m].x + 40
					elseif swipeX < 0 and mmCheck.x > 720 then
						miniMap[m].x = miniMap[m].x - 40
					end
					if swipeY > 0 then
						miniMap[m].y = miniMap[m].y + 10
					else
						miniMap[m].y = miniMap[m].y - 10
					end
				elseif swipeY < 0 and math.abs(swipeX) < 250  and mmCheck.y ~= 432  and mmCheck.y ~= 192 then
					miniMap[m].y = miniMap[m].y - 20
				elseif swipeY > 0 and math.abs(swipeX) < 250  and mmCheck.y ~= 432 and mmCheck.y ~= 672 then
					miniMap[m].y = miniMap[m].y + 20
				end
				miniMapMovement = miniMapMovement + 20
			end
		end
		]]
	

end

function hideMiniMap() 
	miniMap.alpha = 0
end

--------------------------------------------------------------------------------
-- reset miniMap
--------------------------------------------------------------------------------
function resetMiniMap(miniMap, mapData, player)
	--[[
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
	]]
	-- reset miniMap movement
	miniMapMovement = 0

	--checkInventory(miniMap, player)

end

function checkMiniMap(miniMap, index)
	if index == 1 then

	elseif index == 2 then

	elseif index == 3 then

	elseif index == 4 then

	elseif index == 5 then

	elseif index == 6 then

	end
end

function checkInventory(miniMap, player)
	-- add in inventory goal
	if #player.inventory.items > prevInventory then
		
		for count = prevInventory+1, #player.inventory.items do
			local itemName = player.inventory.items[count]
			print(itemName)
			local itemDisplay = display.newImage("mapdata/items/" .. tostring(itemName) .. ".png")
			itemDisplay.x, itemDisplay.y = 60*count, 100

			miniMap:insert((7+count), itemDisplay)
		end
		prevInventory = #player.inventory.items
	end
end

local miniMap = {
	createMiniMap = createMiniMap,
	updateMiniMap = updateMiniMap,
	resetMiniMap = resetMiniMap,
	checkInventory = checkInventory
}


return miniMap