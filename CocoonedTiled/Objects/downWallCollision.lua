function collide(collideObject, player, event, mapData, map)
end

function move(obj)
	startTransitionD(obj)
end

function startTransitionD(obj)
	transition.to(obj, {time = 300, x = x, y = obj.y+300, onComplete = goBackD})
end

function goBackD(obj)
	transition.to(obj, {time = 300, x = x, y = obj.y-300, onComplete = startTransitionD})
end

local downWallCollision = {
	collide = collide,
	move = move
}

return downWallCollision