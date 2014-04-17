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

--------------------------------------------------------------------------------
-- Check Win - function that determines if player has finished level
--------------------------------------------------------------------------------
-- Updated by: 
--------------------------------------------------------------------------------
function checkWin(player, map, mapData)
	-- debug for checking win
	--print("checking win", player.inventory.runeSize-1, map.itemGoal, mapData.pane)
	--TODO: Inventory
	-- check if rune count is same with rune goal count
	if tonumber(player.inventory.runeSize)-1 == tonumber(map.itemGoal) then

		-- check if player is in Main pane, if so, change exit portal to moving
		if mapData.pane == "M" then

			-- find exit portal and start moving it
			for check = 1, map.layer["tiles"].numChildren do
				if map.layer["tiles"][check].name == "exitPortal1" then
					map.layer["tiles"][check]:setSequence("move")
					map.layer["tiles"][check]:play()

					--debug letting player know level has finished
					print("level finished")
				end
			end
		end	
	end
end


-- end of levelFinished.lua