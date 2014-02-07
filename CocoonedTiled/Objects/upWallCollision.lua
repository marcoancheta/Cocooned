function collide(collideObject, player, event, mapData, map)
end

function move(obj)
	startTransitionX(obj)
end

function startTransitionX(obj)
	transition.to(obj, {time = 300, x = x, y = obj.y-300, onComplete = goBackX})
end

function goBackX(obj)
	transition.to(obj, {time = 300, x = x, y = obj.y+300, onComplete = startTransitionX})
end

local blackWallCollision = {
	collide = collide,
	move = move
}

return blackWallCollision