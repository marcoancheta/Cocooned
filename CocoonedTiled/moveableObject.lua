local moveObject = {
	object = '',
	startX = 0,
	startY = 0,
	endX = 0,
	endY = 0,
	time = 0
}

function create(o)
	o = o or {}
	return moveObject:new(o)
end

function moveObject:new(o)
	setmetatable(o, self)
	self.__index = self
	return o
end

function moveObject:setPoints(sX, sY, eX, eY, t)
	self.startX = sX
	self.startY = sY
	self.endX = eX
	self.endY = eY
	self.time = t
end

function moveObject:endTransition()
	transition.cancel(foward)
	transition.cancel(back)
end

function moveObject:startTransition(obj)
	moveFoward(obj)
end

local foward, back

function moveFoward(obj)
	--print("moveF:", obj.name)
	foward = transition.to(obj, {time = obj.time, x = obj.endX, y = obj.endY, onComplete = moveBackward})
end

function moveBackward(obj)
	--print("moveB:", obj.name)
	back = transition.to(obj, {time = obj.time, x = obj.startX, y = obj.startY, onComplete = moveFoward})
end





local moveableObject = {
	create = create
}

return moveableObject