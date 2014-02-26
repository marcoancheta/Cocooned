--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- moveableObject.lua
--------------------------------------------------------------------------------
-- lua file that creates moveable objects for pane

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local foward, back

--------------------------------------------------------------------------------
-- Moveable Objectt Instance - moveabled object table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local moveObject = {
	object = '',
	startX = 0,
	startY = 0,
	endX = 0,
	endY = 0,
	time = 0
}

--------------------------------------------------------------------------------
-- Create Moveable Object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
--call this to create a new moveable object, but make sure to change parameters
function create(o)
	o = o or {}
	return moveObject:new(o)
end

--------------------------------------------------------------------------------
-- New - function that creates a new moveable object table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveObject:new(o)
	setmetatable(o, self)
	self.__index = self
	return o
end

--------------------------------------------------------------------------------
-- New - function that creates a new iventory table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveObject:endTransition()
	transition.cancel(foward)
	transition.cancel(back)
end

--------------------------------------------------------------------------------
-- Start Transition - function that starts movement of object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveObject:startTransition(obj)
	moveFoward(obj)
end

--------------------------------------------------------------------------------
-- Move Foward - function that transitions object to end point
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveFoward(obj)
	obj:rotate(180)
	--print("moveF:", obj.name)
	foward = transition.to(obj, {time = obj.time, x = obj.endX, y = obj.endY, onComplete = moveBackward})
end

--------------------------------------------------------------------------------
-- Move Backward - function that transitions object to start point
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function moveBackward(obj)
	obj:rotate(180)
	--print("moveB:", obj.name)
	back = transition.to(obj, {time = obj.time, x = obj.startX, y = obj.startY, onComplete = moveFoward})
end


--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local moveableObject = {
	create = create
}

return moveableObject

-- end of moveableOject.lua