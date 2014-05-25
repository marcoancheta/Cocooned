--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- levelFinished.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- function that determines in the player has collected all runes in level
-- if so, then set exit portal to move so that player can leave level

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")

local levelFinished = {}

--------------------------------------------------------------------------------
-- Check Win - function that determines if player has finished level
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
local function checkWin(player, map, mapData)
	-- debug for checking win
	--print("checking win", player.inventory.runeSize-1, map.itemGoal, mapData.pane)

	-- check if rune count is same with rune goal count
	if player.inventory.runeSize-1 == map.itemGoal or map.itemGoal == 0 then

		-- check if player is in Main pane, if so, change exit portal to moving
		--if mapData.pane == "M" then

			-- find exit portal and start moving it
			for check = 1, map.numChildren do
				if map[check].name == "exitPortal1" then
					map[check]:setSequence("move")
					map[check]:play()

					--debug letting player know level has finished
					print("level finished")
				end
			end
		--end	
	end
end

levelFinished.checkWin = checkWin

return levelFinished
-- end of levelFinished.lua