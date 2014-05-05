--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- systemEvents.lua
--------------------------------------------------------------------------------
-- Save Game (saveGame.lua)
local saveGame = require("Loading.saveGame")
-- Load Game (loadGame.lua)
local loadGame = require("Loading.loadGame")
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")

local systemEvents = {}


local function onSysEvent(event)

	if event.type == "applicationExit" then
		print("save game")
		saveGame.gameSave(gameData, "game.json")
	elseif event.type == "applicationOpen" then
		print("load game")
		loadGame.gameLoad("game.json")
	elseif event.type == "applicationSuspend" then
		print("pause game")
		--saveGame.gameSave(gameData, "game.json")
	end
end

systemEvents.onSysEvent = onSysEvent

return systemEvents