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
require("Core.levelFinished")
-- Dusk Engine (Dusk.lua)
local dusk = require("Dusk.Dusk")
-- miniMap function (miniMap.lua)
local miniMapMechanic = require("Mechanics.miniMap")
-- objects function (object.lua)
local objects = require("Loading.objects")
-- loading screen function (loadingScreen.lua)
local loading = require("Loading.loadingScreen")
--create player 2 if player2 is in current level
local player = require("Mechanics.player")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("Mechanics.collisionDetection")
-- Touch mechanics (touchMechanic.lua)
local touch = require("Mechanics.touchMechanic")
-- Menu variables/objects (menu.lua)
local menu = require("Core.menu")
-- generate tilesToPixels func (generateObjects.lua)
local generate = require("Loading.generateObjects")
-- load in physics data
local physicsData = require("Loading.physicsData")

-- set variables for loading screen
local loaded = 0
local level = 0 
-- holds the level name for loading
local levelNames = {
	["1"] = "one",
	["2"] = "two",
	["3"] = "three",
	["4"] = "four",
	["15"] = "fifteen",
	["LS"] = "LS"
}

local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading(level) end

--------------------------------------------------------------------------------
-- Create Level - function that creates starting pane of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function createLevel(mapData, player1)

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

	-- Load in map
	local map = display.newGroup()
	map.name = "display group"
	if mapData.levelNum ~= "LS" then
		-- load in wall collision
		local level
		level = display.newImage("mapdata/art/background/" .. mapData.levelNum .. "/" .. mapData.pane .. ".png")
		level.name = "testing 1"
		level.anchorX = 0
		level.anchorY = 0
		map:insert(1, level)
		physics.addBody(level, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))
		
	else
		local level
		level = display.newImage("mapdata/art/background/" .. mapData.levelNum .. "/" .. mapData.pane .. ".png")
		level.name = "LS"
		level.anchorX = 0
		level.anchorY = 0
		map:insert(1, level)
		physics.addBody(level, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))
	end
	
	objects.main(mapData, map)
	
	-- set players location according to level
	if mapData.levelNum == "LS" then
		player1.imageObject.x, player1.imageObject.y = generate.tilesToPixels(24, 18)
	else
		player1.imageObject.x, player1.imageObject.y = generate.tilesToPixels(20, 6)
	end
	
	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, map)
		  miniMapDisplay.name = "miniMapName"

	-- Add objects to its proper groups
	gui.back:insert(1, map)
	if mapData.levelNum ~= "LS" then
		map:insert(player1.imageObject)
	else
		map:insert(player1.imageObject)
	end
	
	
	-- destroy loading screen
	timer.performWithDelay(1000, deleteClosure)

	-- reutrn gui and miniMap
	return gui, miniMapDisplay
	
end

--------------------------------------------------------------------------------
-- Change Pane - function that changes panes of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function changePane(mapData, player, player2, miniMap)

	-- Load in map
	local map = display.newGroup()
	local level
	--dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/" .. mapData.pane .. ".json")
	level = display.newImage("mapdata/art/background/" .. mapData.levelNum .. "/" .. mapData.pane .. ".png")	
	level.anchorX = 0
	level.anchorY = 0
	map:insert(level)
	physics.addBody(level, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))

	objects.main(mapData, map)

	-- if player is small, set player size back to normal
	if player.small == true then
		player:unshrink()
	end

	--TODO: how does checkWin work?
	-- check if player has finished level
	--checkWin(player, map, mapData)
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
	changePane = changePane,
}

return loadLevel
-- end of loadLevel