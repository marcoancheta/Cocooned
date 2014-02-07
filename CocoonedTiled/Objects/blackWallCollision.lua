function collide(collideObject, player, event, mapData, map)
end

local newX, newY
local startX, startY

function move(obj)
	newX, newY = map.tilesToPixels(obj.moveLocX + 0.5, obj.moveLocY + 0.5)
	startX, startY = obj.x, obj.y
	startTransitionX(obj)
end

function startTransitionX(obj)
	transition.to(obj, {time = 300, x = obj.x+300, y = y, onComplete = goBackX})
end

function goBackX(obj)
	transition.to(obj, {time = 300, x = obj.x-300, y = y, onComplete = startTransitionX})
end

local blackWallCollision = {
	collide = collide,
	move = move
}

return blackWallCollision