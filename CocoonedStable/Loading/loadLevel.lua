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
local goals = require("Core.goals")

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
-- drawPane - function that draws the actual pane; returns levelMap
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawPane(mapData)
	local levelMapping
	levelMapping = display.newImage("mapdata/art/background/" .. mapData.levelNum .. "/" .. mapData.pane .. ".png")
	levelMapping.name = "testing 1"
	levelMapping.anchorX = 0
	levelMapping.anchorY = 0
	
	physics.addBody(levelMapping, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))
		
	return levelMapping
end

--------------------------------------------------------------------------------
-- Create Level - function that creates starting pane of level
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function createLevel(mapData, player1)
	-- Create game user interface (GUI) group
	local gui = display.newGroup()

	-- Create GUI subgroups
	gui.front = display.newGroup()
	gui.back = display.newGroup()

	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.front)
	
	loading.loadingInit() --initializes loading screen assets and displays them on top
	loaded = 0 -- current loading checkpoint, max is 6
	level = mapData.levelNum
		
	-- Load in map
	local map = display.newGroup()
	map.name = "display group"
	if mapData.levelNum ~= "LS" then
		-- load in wall collision
		local levelMap = drawPane(mapData)
		map:insert(levelMap)		
	else
		map = dusk.buildMap("mapdata/levels/" .. mapData.levelNum .. "/LS.json")
	end
	
	objects.main(mapData, map)
	
	-- set players location according to level
	if mapData.levelNum == "LS" then
		goals.drawGoals(gui)
		player1.imageObject.x, player1.imageObject.y = map.tilesToPixels(24, 18)
		map.layer["tiles"]:insert(player1.imageObject)
	else
		player1.imageObject.x, player1.imageObject.y = generate.tilesToPixels(20, 6)
		map:insert(player1.imageObject)
	end
	
	-- create miniMap for level
	--local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, map)
	--	  miniMapDisplay.name = "miniMapName"

	-- Add objects to its proper groups
	gui.back:insert(map)
	
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
	-- load in wall collision
	local levelMap = drawPane(mapData)
	
	map:insert(levelMap)
	objects.main(mapData, map)

	-- if player is small, set player size back to normal
	if player.small == true then
		player:unshrink()
	end

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