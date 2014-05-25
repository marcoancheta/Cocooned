--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadLevel.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- level finished function (levelFinished.lua)
local levelFinished = require("Core.levelFinished")
-- miniMap function (miniMap.lua)
--local miniMapMechanic = require("Mechanics.miniMap")
-- objects function (object.lua)
local objects = require("Objects.objects")
-- loading screen function (loadingScreen.lua)
local loading = require("Loading.loadingScreen")
--create player 2 if player2 is in current level
local player = require("Mechanics.player")
-- generate tilesToPixels func (generateObjects.lua)
local generate = require("Objects.generateObjects")
-- load in physics data
local physicsData = require("Loading.physicsData")
-- Goals (goals.lua)
local goals = require("Core.goals")
-- Mini-map (miniMap.lua)
local miniMapMechanic = require("Mechanics.miniMap")
-- Snow (snow.lua)
local snow = require("utils.snow")
-- GameData (gameData.lua)
local gameData = require("Core.gameData")

--------------------------------------------------------------------------------
-- Variables - variables for loading panes
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- set variables for loading screen
local loaded = 0
local level = 0 

local ballPos = {
	["world"] = {["x"]=21,["y"]=15},
	["LS"] = {["x"]=21,["y"]=15},
	-- A
	["1"]  = {["x"]=20, ["y"]=14},
	["2"]  = {["x"]=20,["y"]=10},
	["3"]  = {["x"]=5, ["y"]=20},
	["4"]  = {["x"]=22, ["y"]=22},
	["5"]  = {["x"]=4, ["y"]=4},
	-- B
	["6"]  = {["x"]=20, ["y"]=14},
	["7"]  = {["x"]=4, ["y"]=4},
	["8"]  = {["x"]=20, ["y"]=15},
	["9"]  = {["x"]=4, ["y"]=4},
	["10"]  = {["x"]=4, ["y"]=4},
	-- C
	["11"]  = {["x"]=20, ["y"]=14},
	["12"]  = {["x"]=20,["y"]=14},
	["13"]  = {["x"]=20, ["y"]=14},
	["14"]  = {["x"]=20, ["y"]=14},
	["15"]  = {["x"]=20, ["y"]=14},
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
	local displayY = 840
	
	local levelBG
	local levelWall	
		
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		-- In-Game levels load in
		levelBG = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/bg/" .. mapData.pane .. ".png", displayX, displayY)	
		levelWall = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/wall/" .. mapData.pane .. ".png", displayX, displayY)		
		-- Add shores for in-game levels
		levelBG.func = "shoreCollision"
		levelBG.collType = "solid"
		physics.addBody(levelBG, "static", physicsData.getFloor(mapData.levelNum):get(mapData.pane))
		physics.addBody(levelWall, "static", physicsData.getData(mapData.levelNum):get(mapData.pane))
		levelBG.isSensor = true
	elseif mapData.levelNum == "LS" then
		-- Level selector level load in
		-- File Location: mapdata/art/background/LS/(WORLD_HERE)/bg/LS.png
		levelBG = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/" ..mapData.world.. "/bg/" .. mapData.pane .. ".png", displayX, displayY)
		-- File Location: mapdata/art/background/LS/(WORLD_HERE)/wall/LS.png
		levelWall = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/" ..mapData.world.. "/wall/" .. mapData.pane .. ".png", displayX, displayY)
		physics.addBody(levelWall, "static", physicsData.getLSData(mapData):get(mapData.pane))
	elseif mapData.levelNum == "world" then
		-- World selector load in
		-- File Location: mapdata/art/background/world/bg/world.png
		levelBG = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/bg/" .. mapData.pane .. ".png", displayX, displayY)
		-- File Location: mapdata/art/background/world/wall/world.png
		levelWall = display.newImageRect("mapdata/art/background/" .. mapData.levelNum .. "/wall/" .. mapData.pane .. ".png", displayX, displayY)
		physics.addBody(levelWall, "static", physicsData.getWorldData(mapData.levelNum):get(mapData.pane))
	end

	levelBG.x = display.contentCenterX
	levelBG.y = display.contentCenterY
	levelBG.name = "background"
	levelWall.x = display.contentCenterX
	levelWall.y = display.contentCenterY
	levelWall.name = "walls"	
		
	return levelBG, levelWall
end

--------------------------------------------------------------------------------
-- Create Level - function that creates starting pane of level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function createLevel(mapData, players)
	-- Create game user interface (GUI) group
	local gui = display.newGroup()
	gui.name = "main gui"
		
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
	-- Load in objects
	objects.main(mapData, gui) -- gui.front = map
	-- Load in player	
	if level ~= "LS" and level ~= "world" then
		for i = 1, gui.playerCount do
			players[i].imageObject.x, players[i].imageObject.y = generate.tilesToPixels(gui.playerPos[i]["x"], gui.playerPos[i]["y"])
		end
	else
		players[1].imageObject.x, players[1].imageObject.y = generate.tilesToPixels(ballPos[mapData.levelNum]["x"], ballPos[mapData.levelNum]["y"])
	end
	
	-- Create ball shadow
	local shadowCirc
	if gameData.shadow == true then
		shadowCirc = display.newCircle(players[1].imageObject.x, players[1].imageObject.y, 43)
		shadowCirc:setFillColor(86*0.0039216,72*0.0039216,92*0.0039216)
		shadowCirc.alpha = 0.5
	else
		shadowCirc = nil
	end
	
	-- Add objects to its proper groups
	gui.back:insert(levelBG)	
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		if shadowCirc ~= nil then
			gui.middle:insert(shadowCirc)
		end
		gui.middle:insert(levelWalls)
		for i = 1, gui.playerCount do
			gui.front:insert(players[i].imageObject)
		end
		--gui.front:insert(player1.imageObject) -- in-game objects also draws here.
		
		-- check if player has finished level
		levelFinished.checkWin(players[1], gui.front, mapData)
	elseif mapData.levelNum == "LS" or mapData.levelNum == "world" then
		----------------------------
		-- Level selector exclusive
		if shadowCirc ~= nil then
			gui.middle:insert(shadowCirc)
		end
		gui.middle:insert(players[1].imageObject)
		gui.front:insert(levelWalls)
		
		if mapData.levelNum == "LS" then
			-- load in goals
			goals.drawGoals(gui, players[1])
		end
	end
	
	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, gui.front)
		  miniMapDisplay.name = "miniMapName"
	
	-- destroy loading screen
	timer.performWithDelay(2000, deleteClosure)

	-- check if player has finished level
	levelFinished.checkWin(players[1], gui.front, mapData)
		
	-- reutrn gui and miniMap
	return gui, miniMapDisplay, shadowCirc
end

--------------------------------------------------------------------------------
-- Change Pane - function that changes panes of level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function changePane(gui, mapData, player, miniMap)
	-- Delete old snow
	snow.meltSnow()
	transition.cancel()
	snow.new()

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
	levelFinished.checkWin(player, gui.front, mapData)
	
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