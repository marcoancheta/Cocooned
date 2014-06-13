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
-- Inventory
local inventory = require("Mechanics.inventoryMechanic")
-- Level names
local levelNames = require("utils.levelNames")
-- Tutorial
local tutorialLib = require("utils.tutorialLib")

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

local panes = {"M", "U", "D", "R", "L"}

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
local function createLevel(mapData, players, player, gui)	
	print("+++++++++++++++++++++++++ SCRAPPPEEE +++++++++++++++++++++++++++++++")
	
	-- Create game user interface (GUI) group
	local gui = display.newGroup()
	--print("check gui original pos " .. gui.x .. ", " .. gui.y)
	gui.originalX = gui.x
	gui.originalY = gui.y
	gui.name = "main gui"
		
	-- Create GUI subgroups
	gui.load = display.newGroup()
	gui.front = display.newGroup()
	gui.middle = display.newGroup()
	gui.back = display.newGroup()

	gui.load.name = "load"
	gui.front.name = "front"
	gui.back.name = "back"
	gui.middle.name = "middle"

	-- Add subgroups into main GUI group
	gui:insert(gui.back)
	gui:insert(gui.middle)
	gui:insert(gui.front)
	gui:insert(gui.load)

	level = mapData.levelNum
	-- Load in map
	local levelBG, levelWalls = drawPane(mapData)
	
	-- Create ball shadow
	local shadowCirc
	if gameData.shadow == true then
		 shadowCirc = display.newImage("mapdata/art/shadows/ballshadow.png", players[1].imageObject.x, players[1].imageObject.y)	
		 shadowCirc.name = "shadowCirc"
		 gui.middle:insert(shadowCirc)
		 shadowCirc:toBack()
	else
		shadowCirc = nil
	end
	
	-- Load in playerCount and playerPosition from level file
	local level = require("levels." ..levelNames[mapData.levelNum])
	gui.playerCount = level.playerCount
	gui.playerPos = level.playerPos
	-- Add Background to gui.back
	gui.back:insert(levelBG)	
	if mapData.levelNum ~= "LS" and mapData.levelNum ~= "world" then
		-- WALLS
		gui.middle:insert(levelWalls)
		-- SHADOW
		if shadowCirc ~= nil then
			gui.middle:insert(shadowCirc)
		end
		-- Insert player
		for i = 1, gui.playerCount do
			players[i].imageObject.x, players[i].imageObject.y = generate.tilesToPixels(gui.playerPos[i]["x"], gui.playerPos[i]["y"])
			gui.front:insert(players[i].imageObject)
		end
		-- Load in objects
		objects.main(mapData, gui, players, player) -- gui.front = map
		-- check if player has finished level
		levelFinished.checkWin(players[1], gui.front, mapData)
	elseif mapData.levelNum == "LS" or mapData.levelNum == "world" then
		----------------------------
		-- Level selector exclusive
		-- SHADOW
		if shadowCirc ~= nil then
			gui.middle:insert(shadowCirc)
		end		
		-- Load in objects
		objects.main(mapData, gui, players, player) -- gui.front = map
		-- Insert player
		players[1].imageObject.x, players[1].imageObject.y = generate.tilesToPixels(gui.playerPos[1]["x"], gui.playerPos[1]["y"])
		gui.middle:insert(players[1].imageObject)
		gui.front:insert(levelWalls)		
		-- load in goals
		goals.drawGoals(gui, players[1])
	end

	-- update the shadow position
	shadowCirc.x, shadowCirc.y = players[1].imageObject.x, players[1].imageObject.y
	
	-- create miniMap for level
	local miniMapDisplay = miniMapMechanic.createMiniMap(mapData, gui.front)
		  miniMapDisplay.name = "miniMapName"
	
	-- check if player has finished level
	levelFinished.checkWin(gameData.players[1], gui.front, mapData)
	
	-- destroy loading screen
	local loadingTimer = timer.performWithDelay(2000, deleteClosure)
		
	-- reutrn gui and miniMap
	return gui, miniMapDisplay, shadowCirc
end

--------------------------------------------------------------------------------
-- Activate - re-activation of objects picked up in pane
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function activate(gui, mapData, player, miniMap)
	local level = require("levels." .. levelNames[mapData.levelNum])
	if player[1] then
		-- Check rune inventory slots for runes collected
		for i=1, #player[1].inventory.runes[mapData.pane] do
			-- check which rune was collected and activate ability
			if player[1].inventory.runes[mapData.pane][i] == "blueRune" then
				for j=1, #level.runeAvailable[mapData.pane] do
					if level.runeAvailable[mapData.pane][j] == player[1].inventory.runes[mapData.pane][i] then
						if player[1].large == false then
							player[1]:breakWalls(gui.front)
							player[1].large = true
							player[1]:unshrink()
						end
					end
				end
			elseif player[1].inventory.runes[mapData.pane][i] == "pinkRune" then
				for j=1, #level.runeAvailable[mapData.pane] do
					if level.runeAvailable[mapData.pane][j] == player[1].inventory.runes[mapData.pane][i] then
						player[1]:slowTime(gui.front)
					end
				end
			elseif player[1].inventory.runes[mapData.pane][i] == "greenRune" then
				for j=1, #level.runeAvailable[mapData.pane] do
					if level.runeAvailable[mapData.pane][j] == player[1].inventory.runes[mapData.pane][i] then
						gameData.gRune = true
						--player:moveWalls(gui)
					end
				end
			elseif player[1].inventory.runes[mapData.pane][i] == "purpleRune" then
				for j=1, #level.runeAvailable[mapData.pane] do
					if level.runeAvailable[mapData.pane][j] == player[1].inventory.runes[mapData.pane][i] then
						if player[1].small == false then
							player[1].small = true
							player[1]:shrink()
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Change Pane - function that changes panes of level
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function changePane(gui, mapData, players, player, miniMap)
	-- Delete old snow
	snow.meltSnow()
	transition.cancel()
	snow.new()
		
	-- load in wall collision
	local levelBG, levelWalls = drawPane(mapData)
	gui.back:insert(levelBG)
	gui.middle:insert(levelWalls)
	--gui.front:insert(player.imageObject)
	objects.main(mapData, gui, players, player)	
	-- Check rune inventory slots for runes collected
	activate(gui, mapData, players, miniMap)	
	-- Check if tutorial level
	if mapData.levelNum == "T" and mapData.pane == "U" then
		if tutorialLib.tutorialStatus >= 1 then
			--set up tiltip if in tutorial level
			tutorialLib:showTipBox("waterTip", 2, gui, player[1])
		end
	end	
	
	if player[1] then
		-- check if player has finished level
		levelFinished.checkWin(player[1], gui.front, mapData)
		-- reset curse
		if player[1].small == true then
			player[1].curse = 0.5
		else
			player[1].curse = 1
		end
	end
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
	activate = activate,
	changePane = changePane
}

return loadLevel
-- end of loadLevel