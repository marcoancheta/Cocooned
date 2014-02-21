--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadLevel.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local dusk = require("Dusk.Dusk")
local miniMapMechanic = require("miniMap")
local objects = require("objects")
local loading = require("loadingScreen")
require("levelFinished")
local loaded = 0
local level = 0 

local glowTileSheet = graphics.newImageSheet("mapdata/art/tileGlow.png", 
				 {width = 36, height = 36, sheetContentWidth = 216, sheetContentHeight = 36, numFrames = 6})


--------------------------------------------------------------------------------
-- Load level on startup
--------------------------------------------------------------------------------

local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(level) end
function createLevel(mapData, ball, player)
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
	timer.performWithDelay(300, myClosure)-- first loading check point gui groups and subgroups added
	
	map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/M.json")
	objects.main(mapData, map, player)

	timer.performWithDelay(600, myClosure) --map built
	
	-- animate glowing tiles
	for i=1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][i].name == "glowTile" then
			local tx, ty = map.layer["tiles"][i].x, map.layer["tiles"][i].y
			map.layer["tiles"][i] = display.newSprite(glowTileSheet, spriteOptions.glowTile)
			map.layer["tiles"][i].x, map.layer["tiles"][i].y = tx, ty
			map.layer["tiles"][i].timeScale = 0.5
			map.layer["tiles"][i]:setSequence("move")
			map.layer["tiles"][i]:play()
		end
	end

	timer.performWithDelay(900, myClosure) --objects moved

	-- set players location
	ball.x, ball.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

	timer.performWithDelay(1200, myClosure)--players location set

	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, player, map)
	miniMapDisplay.name = "miniMapName"

	timer.performWithDelay(1500, myClosure) --minimap created

	--miniMapDisplay:removeSelf()

	-- Add objects to its proper groups
	gui.back:insert(1, map)
	map.layer["tiles"]:insert(ball)

	timer.performWithDelay(1800, myClosure)--added groups
	timer.performWithDelay(3000, deleteClosure)

	return gui, miniMapDisplay

end

--------------------------------------------------------------------------------
-- update pane for level
--------------------------------------------------------------------------------
function changePane(mapData, player, miniMap)

	-- Load in map
	local map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/" .. mapData.pane .. ".json")
	objects.main(mapData, map, player)

	miniMapMechanic.updateMiniMap(mapData, miniMap, map, player)
	if player.small == true then
		player:unshrink()
	end
	-- load 
	
	-- if an item was previously taken, remove it from map
	if #player.inventory.items > 0 then
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
				if map.layer["tiles"][removeItem].name == "pinkRune" then
					player:slowTime(map)
				elseif map.layer["tiles"][removeItem].name == "blueRune" then
					player:breakWalls(map)
				elseif	map.layer["tiles"][removeItem].name == "purpleRune" then
					player:shrink()
				end
				print("removed: ", map.layer["tiles"][removeItem].name)
				map.layer["tiles"]:remove(removeItem)
			end
		end
	end

	checkWin(player, map, mapData)
	-- return new pane
	return map
end



local loadLevel = {
	createLevel = createLevel,
	changePane = changePane
}

return loadLevel

-- end of loadLevel