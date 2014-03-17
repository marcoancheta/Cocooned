--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadLevel.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that loads pane for level


--------------------------------------------------------------------------------
-- Variables - variables for loading panes
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- level finished function (levelFinished.lua)
require("levelFinished")
-- Dusk Engine (Dusk.lua)
local dusk = require("Dusk.Dusk")
-- miniMap function (miniMap.lua)
local miniMapMechanic = require("miniMap")
-- objects function (object.lua)
local objects = require("objects")
-- loading screen function (loadingScreen.lua)
local loading = require("loadingScreen")
-- set variables for loading screen
local loaded = 0
local level = 0 
local player2Params={
		isActive = false,
		x=-1,
		y=-1
}
local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(level) end
--create player 2 if player2 is in current level
local player = require("player")


--------------------------------------------------------------------------------
-- Create Level - function that creates starting pane of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function createLevel(mapData, playerInstance, player2)

	loaded = 0 -- current loading checkpoint, max is 6
	level =  mapData.levelNum

	-- Create game user interface (GUI) group
	local gui = display.newGroup()

	-- Create GUI subgroups
	gui.front = display.newGroup()
	gui.back = display.newGroup()

	loading.loadingInit() --initializes loading screen assets and displays them on top

	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.front)

	print("loadMap", mapData.levelNum)

	-- Load in map	
	map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/M.json")
	objects.main(mapData, map, player)

	local shadowGroup = display.newGroup()

	--map.layer["shadows"].sx = map.layer["shadows"].x
	--map.layer["shadows"].sy = map.layer["shadows"].y
	--map.layer["vWalls"].sx = map.layer["vWalls"].x
	--map.layer["hWalls"].sy = map.layer["hWalls"].y

	-- set players location
	ball = playerInstance.imageObject
	-- set players location according to level
	if mapData.levelNum == "1" then
		ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)
		if map.secondPlayerLocation.x > 0 and map.secondPlayerLocation.y > 0 then
			player2Params.isActive=true
			player2Params.x, player2Params.y= map.tilesToPixels(map.secondPlayerLocation.x + 0.5, map.secondPlayerLocation.y + 0.5)
		else
			player2Params.active = false
		end
	elseif mapData.levelNum == "2" then
		ball.x, ball.y = map.tilesToPixels(map.playerLocation.x, map.playerLocation.y - 8)
		if map.secondPlayerLocation.x > 0 and map.secondPlayerLocation.y > 0 then
			player2Params.isActive=true
			player2Params.x, player2Params.y= map.tilesToPixels(map.secondPlayerLocation.x , map.secondPlayerLocation.y-8)
		else
			player2Params.active = false
		end
	elseif mapData.levelNum == "4" then
		ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 10, map.playerLocation.y - 1.5)
	end
	
	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, player, map)
	miniMapDisplay.name = "miniMapName"

	-- Add objects to its proper groups
	gui.back:insert(1, map)
	map.layer["tiles"]:insert(ball)

	-- destroy loading screen
	timer.performWithDelay(1000, deleteClosure)

	-- reutrn gui and miniMap
	return gui, miniMapDisplay, player2Params
end

--------------------------------------------------------------------------------
-- Change Pane - function that changes panes of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function changePane(mapData, player, player2, miniMap)

	-- Load in map
	local map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/" .. mapData.pane .. ".json")

	--map.layer["vWalls"].sx = map.layer["vWalls"].x
	--map.layer["hWalls"].sy = map.layer["hWalls"].y
	
	objects.main(mapData, map, player)

	-- if player is small, set player size back to normal
	if player.small == true then
		player:unshrink()
	end
	if player2.isActive == true then
		if player2.small == true then
			player:unshrink()
		end
	end
	
	--TODO: check player2 inventory
	-- if an item was previously taken, remove it from map
	if #player.inventory.items > 0 then
		-- check for N number of items on map if they were taken
		for count = 1, #player.inventory.items do
			local itemName = player.inventory.items[count]
			local removeItem = 0
			-- check map display group for picked up item then remove it
			for check = 1, map.layer["tiles"].numChildren do
				if map.layer["tiles"][check].name == itemName then
					-- save index of item that was removed
					removeItem = check
				end
			end

			-- if index if grearter than 0, then item needs to be removed
			if removeItem > 0 then
				-- if rune, start ability
				if map.layer["tiles"][removeItem].name == "pinkRune" then
					player:slowTime(map)
				elseif map.layer["tiles"][removeItem].name == "blueRune" then
					player:breakWalls(map)
				elseif	map.layer["tiles"][removeItem].name == "purpleRune" then
					player:shrink()
				end

				-- debug for which item was removed
				print("removed: ", map.layer["tiles"][removeItem].name)

				-- remove item from map display
				map.layer["tiles"]:remove(removeItem)
			end
		end
	end

	--TODO: how does checkWin work?
	-- check if player has finished level
	checkWin(player, map, mapData)
	-- return new pane
	return map
end


--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local loadLevel = {
	createLevel = createLevel,
	changePane = changePane
}

return loadLevel

-- end of loadLevel