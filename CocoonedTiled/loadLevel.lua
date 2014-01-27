
local dusk = require("Dusk.Dusk")

function createLevel(map, player)


	

	-- Create game user interface (GUI) group
	local gui = display.newGroup()
	
	-- Create GUI subgroups
	gui.front = display.newGroup()
	gui.back = display.newGroup()
		
	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.front)
		  
	-- Load in map
	map = dusk.buildMap("mapdata/levels/tempNew/" .. map.pane .. map.version .. ".json")

	player.x, player.y = map.tilesToPixels(map.playerLocation.x + 0.5, map.playerLocation.y + 0.5)

	-- Add objects to its proper groups
	gui.back:insert(map)
	map:insert(player)
	map.layer["tiles"]:insert(player)
	map.layer["tiles"]:remove(1)
	print(map.layer["tiles"][1].name)

	return gui
end

function changePane(mapData)

	-- Load in map
	map = dusk.buildMap("mapdata/levels/tempNew/" .. mapData.pane .. mapData.version .. ".json")

	return map

end


local loadLevel = {
	createLevel = createLevel,
	changePane = changePane
}

return loadLevel