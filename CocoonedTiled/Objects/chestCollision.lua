function collide(collideObject, player, event, mapData)
	if #player.inventory.items > 0 then
		if player.inventory.items[1].name == "key" then
			collideObject:removeSelf()
			mapData.version = mapData.version + 1
		end
	end
end