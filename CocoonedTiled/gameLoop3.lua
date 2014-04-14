--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameLoop.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Localize (Load in files) - [System Files]
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local require = require
local math_abs = math.abs
local physics = require("physics")
local dusk = require("Dusk.Dusk")
--local GA = require("plugin.gameanalytics")
	  
--------------------------------------------------------------------------------
-- Load in files/variables from other .lua's
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")
-- Load level function (loadLevel.lua)
local loadLevel = require("loadLevel")
-- Animation variables/data (animation.lua)
local animation = require("animation")
-- Menu variables/objects (menu.lua)
local menu = require("menu")
-- Sound files/variables (sound.lua)
local sound = require("sound")
-- Player variables/files (player.lua)
local player = require("player")
-- Object variables/files (objects.lua)
local objects = require("objects")
-- miniMap display functions
local miniMapMechanic = require("miniMap")
-- memory checker (memory.lua)
local memory = require("memory")

--[[ Load in game mechanics begin here ]]--
-- Touch mechanics (touchMechanic.lua)
local touch = require("touchMechanic")
-- Accelerometer mechanic (Accelerometer.lua)
local movementMechanic = require("Accelerometer")
-- Movement based on Accelerometer readings
local movement = require("movement")
-- Collision Detection (collisionDetection.lua)
local collisionDetection = require("collisionDetection")
-- Spirits mechanics (spirits.lua)
local spirits = require("spirits")
-- Pane Transitions (paneTransition.lua)
local paneTransition = require("paneTransition")

--------------------------------------------------------------------------------
-- Local/Global Variables
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------

-- Initialize ball
local ball
local mapPanes
local t = 1
local timeCheck = 1
local timeCount = 0

-- Initialize map data
local mapData = {
	levelNum = 1,
	pane = "M",
	version = 0
}

local miniMap
local map, ball
local gui
local player1, player2 -- create player variables
local tempPane -- variable that holds current pane player is in for later use
local count = 0

--------------------------------------------------------------------------------
-- Game Functions:
------- controlMovement
------- swipeMechanics
------- tapMechanics
------- speedUp
--------------------------------------------------------------------------------
