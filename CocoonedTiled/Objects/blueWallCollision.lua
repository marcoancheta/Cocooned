function collide(collideObject, player, event, mapData)
	if player.color == 'blue' then
		event.contact.isEnabled = false
	end
end