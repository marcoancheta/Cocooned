local function distance(object1, object2)
	local d = math.sqrt((object2.x-object1.x)^2 + (object2.y-object1.y)^2)
	return d
end

local function distanceXY(x1, y1, x2, y2)
	local d = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
	return d
end

local function deg2rad(degree)
	local rad = degree * (math.pi/180)
	return rad
end

local function rad2deg(radian)
	local deg = radian * (180/math.pi)
	return deg
end

local utilMath = {
	distance = distance,
	distanceXY = distanceXY,
	deg2rad = deg2rad,
	rad2deg = rad2deg
}

return utilMath