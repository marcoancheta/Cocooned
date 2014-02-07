function collide(collideObject, player, event, mapData, map)
end

function move(obj)
	startTransitionU(obj)
end

function startTransitionU(obj)
	transition.to(obj, {time = 300, x = x, y = obj.y-300, onComplete = goBackU})
end

function goBackU(obj)
	print("up")
	transition.to(obj, {time = 300, x = x, y = obj.y+300, onComplete = startTransitionU})
end

local upWallCollision = {
	collide = collide,
	move = move
}

return upWallCollision