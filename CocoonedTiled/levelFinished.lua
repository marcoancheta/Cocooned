local gameData = require("gameData")

function checkWin(player, map)
	--print("checking win", #player.inventory.items, map.itemGoal)

	if #player.inventory.items == tonumber(map.itemGoal) then
		print("endGame")
		gameData.gameEnd = true

	end
end