--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadLevel.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- level finished function (levelFinished.lua)
--local levelFinished = require("Core.levelFinished")
-- miniMap function (miniMap.lua)
--local miniMapMechanic = require("Mechanics.miniMap")
-- objects function (object.lua)
local objects = require("Loading.objects")
-- loading screen function (loadingScreen.lua)
local loading = require("Loading.loadingScreen")
--create player 2 if player2 is in current level
local player = require("Mechanics.player")
-- generate tilesToPixels func (generateObjects.lua)
local generate = require("Loading.generateObjects")
-- load in physics data
local physicsData = require("Loading.physicsData")
-- Goals (goals.lua)
local goals = require("Core.goals")

local miniMapMechanic = require("Mechanics.miniMap")

--------------------------------------------------------------------------------
-- Variables - variables for loading panes
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- set variables for loading screen
local loaded = 0
local level = 0 

-- holds the level name for loading
local levelNames = {
	["LS"] = "LS",
	["1"] = "one",
	["2"] = "two",
	["3"] = "three",
	["4"] = "four"
}

local ballPos = {
	["LS"] = {["x"]=21,["y"]=15},
	["1"]  = {["x"]=3, ["y"]=10},
	["2"]  = {["x"]=20,["y"]=10},
	["3"]  = {["x"]=5, ["y"]=20},
	["4"]  = {["x"]=22, ["y"]=22},
	["5"]  = {["x"]=4, ["y"]=4},
}

local myClosure = function() loaded = loaded + 1 return loading.updateLoading( loaded ) end
local deleteClosure = function() return loading.deleteLoading() end

--------------------------------------------------------------------------------
-- drawPane - function that draws the actual pane; returns levelMap
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawPane(mapData)
	local displayX = 1460
	local displayY = 864
	
	local levelBG = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/bg/" .. mapData.pane .. ".png", displayX, displayY)
		  levelBG.x = display.contentCenterX
		  levelBG.y = display.contentCenterY
		  levelBG.name = "background"
	
	if mapData.levelNum ~= "LS" then
		levelBG.func = "shoreCollision"
		levelBG.collType = "passThru"
		physics.addBody(levelBG, "static", physicsData.getFloor(mapData.levelNum):get(mapData.pane))
	end
	
	local levelWall = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/wall/" .. mapData.pane .. ".png", displayX, displayY)
		  levelWall.x = display.contentCenterX
		  levelWall.y = display.contentCenterY
		  levelWall.name = "walls"
	
	physics.addBody(levelWall, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))
	
	--[[local function repeatTrans()
		transition.to(levelBG, {time=1000, x=levelBG.x+0.5, onComplete=repeatTrans})
	end
	repeatTrans()
	]]--
	
	return levelBG, levelWall
end

--------------------------------------------------------------------------------
-- Create Level - function that creates starting pane of level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createLevel(mapData, player1)
	-- Create game user interface (GUI) group
	local gui = display.newGroup()
		
	-- Create GUI subgroups
	gui.front = display.newGroup()
	gui.middle = display.newGroup()
	gui.back = display.newGroup()

	gui.front.name = "front"
	gui.back.name = "back"
	gui.middle.name = "middle"

	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.middle)
	gui:insert(gui.front)
	
	loading.loadingInit() --initializes loading screen assets and displays them on top
	loaded = 0 -- current loading checkpoint, max is 6
	level = mapData.levelNum
		
	-- Load in map
	local levelBG, levelWalls = drawPane(mapData)

	-- Add objects to its proper groups
	gui.back:insert(levelBG)
	gui.middle:insert(levelWalls)
	-- Load in objects
	objects.main(mapData, gui) -- gui.front = map
	-- Load in player
	
	player1.imageObject.x, player1.imageObject.y = generate.tilesToPixels(ballPos[mapData.levelNum]["x"], ballPos[mapData.levelNum]["y"])
	
	----------------------------
	-- Level selector exclusive
	if mapData.levelNum == "LS" then
		-- load in goals
		goals.drawGoals(gui)
	end
	----------------------------

	gui.front:insert(player1.imageObject) -- in-game objects also draws here.
	
	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, gui.front)
		  miniMapDisplay.name = "miniMapName"
	
	-- destroy loading screen
	timer.performWithDelay(1000, deleteClosure)

	-- reutrn gui and miniMap
	return gui, miniMapDisplay
end

--------------------------------------------------------------------------------
-- Change Pane - function that changes panes of level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function changePane(gui, mapData, player, miniMap)
	-- load in wall collision
	local levelBG, levelWalls = drawPane(mapData)
	
	gui.back:insert(levelBG)
	gui.middle:insert(levelWalls)
	--gui.front:insert(player.imageObject)
	objects.main(mapData, gui)

	-- if player is small, set player size back to normal
	if player.small == true then
		player:unshrink()
	end

	-- check if player has finished level
	--levelFinished.checkWin(player, gui.middle, mapData)
	
	-- return new pane
	return gui
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