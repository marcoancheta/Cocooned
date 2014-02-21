local gameData = require("gameData")

function checkWin(player, map, mapData)
	print("checking win", #player.inventory.items-1, map.itemGoal)

	if tonumber(#player.inventory.items)-1 == tonumber(map.itemGoal) then
		if mapData.pane == "M" then
			print("inside")
			for check = 1, map.layer["tiles"].numChildren do
				if map.layer["tiles"][check].name == "exitPortal1" then
					map.layer["tiles"][check]:setSequence("move")
					map.layer["tiles"][check]:play()
					print("level finished")
				end
			end
		end
		
		
	end
end