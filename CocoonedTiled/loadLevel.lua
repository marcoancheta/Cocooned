--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadLevel.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local dusk = require("Dusk.Dusk")
local miniMap = require("miniMap")
local objects = require("objects")

--------------------------------------------------------------------------------
-- Load level on startup
--------------------------------------------------------------------------------
function createLevel(mapData, ball, player, moveObj)

	-- Create game user interface (GUI) group
	local gui = display.newGroup()
	
	-- Create GUI subgroups
	gui.front = display.newGroup()
	gui.back = display.newGroup()
		
	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.front)

	print("loadMap", mapData.pane)

	-- Load in map
	map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/M.json")

	moveObj.createMoveableObjects(map)

	if map.tutorial == true then
		require("tutorial")
		resetTutorial()
		printTutorial()
	end

	-- set players location
	ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

	-- create miniMap for level
	local miniMapDisplay = miniMap.createMiniMap(mapData, player)
	miniMapDisplay.name = "miniMapName"

	-- Add objects to its proper groups
	gui.back:insert(1, map)
	map:insert(ball)
	map.layer["tiles"]:insert(ball)
	objects.main(mapData, map)
	
	return gui, miniMapDisplay
end


--------------------------------------------------------------------------------
-- update pane for level
--------------------------------------------------------------------------------
function changePane(mapData, player, moveObj)

	-- Load in map
	local map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/" .. mapData.pane .. ".json")

	-- load 
	moveObj.createMoveableObjects(map)

	-- if an item was previously taken, remove it from map
	if tonumber(map.itemSize) > 0 and #player.inventory.items > 0 then
		-- check for N number of items on map if they were taken
		print("remove items")
		for count = 1, #player.inventory.items do
			local itemName = player.inventory.items[count]
			local removeItem = 0
			-- check map display group for picked up item then remove it

			for check = 1, map.layer["tiles"].numChildren do
				if map.layer["tiles"][check].name == itemName then
					removeItem = check
				end
			end
			if removeItem > 0 then
				-- remove that item
				map.layer["tiles"]:remove(removeItem)
			end
		end
	end

	for check = 1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].name == "greenTotem" then
			map.layer["tiles"][check]:scale(2.0,2.0)
			map.layer["tiles"][check].xScale = 1
			map.layer["tiles"][check].yScale = 1
		end
	end



	-- return new pane
	return map
end



local loadLevel = {
	createLevel = createLevel,
	changePane = changePane
}

return loadLevel

-- end of loadLevel