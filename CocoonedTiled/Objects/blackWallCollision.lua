function collide(collideObject, player, event, mapData, map)
end

local newX, newY
local startX, startY

function move(obj)
	newX, newY = map.tilesToPixels(obj.moveLocX + 0.5, obj.moveLocY + 0.5)
	startX, startY = obj.x, obj.y
	startTransition(obj)
end

function startTransition(obj)
	transition.to(obj, {time = 100000, x = newX, y = newY, onComplete = goBack})
end

function goBack(obj)
	transition.to(obj, {time = 100000, x = startX, y = startY, onComplete = startTransition})
end

local blackWallCollision = {
	collide = collide,
	move = move
}

return blackWallCollision