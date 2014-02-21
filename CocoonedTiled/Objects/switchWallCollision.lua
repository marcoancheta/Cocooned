function collide(collideObject, player, event, mapData, map)
	print("yolo")

	player.imageObject:applyForce(player.xForce*-15, player.yForce*-15, player.imageObject.x, player.imageObject.y)
end

local switchWallCollision = {
	collide = collide
}

return switchWallCollision