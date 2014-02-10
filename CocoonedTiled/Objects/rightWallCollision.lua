function collide(collideObject, player, event, mapData, map)
end

function move(obj)
	startTransitionR(obj)
end

function startTransitionR(obj)
	transition.to(obj, {time = 300, x = obj.x+300, y = y, onComplete = goBackR})
end

function goBackR(obj)
	transition.to(obj, {time = 300, x = obj.x-300, y = y, onComplete = startTransitionR})
end

local rightWallCollision = {
	collide = collide,
	move = move
}

return rightWallCollision