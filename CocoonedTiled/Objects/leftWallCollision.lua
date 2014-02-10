function collide(collideObject, player, event, mapData, map)
end

function move(obj)
	startTransitionL(obj)
end

function startTransitionL(obj)
	transition.to(obj, {time = 300, x = obj.x-300, y = y, onComplete = goBackL})
end

function goBackL(obj)
	transition.to(obj, {time = 300, x = obj.x+300, y = y, onComplete = startTransitionL})
end

local leftWallCollision = {
	collide = collide,
	move = move
}

return leftWallCollision