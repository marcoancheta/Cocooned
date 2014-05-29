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

local function cleanGroup(group)
	if group.numChildren ~= 0 then
		for i = group.numChildren, 1, -1 do
			group[i]:removeSelf()
			group[i] = nil
		end
	end
end

local pointsFound = display.newGroup()

local function rayCastCircle(startPos, lastPos, startDist, maxDist, checkGroup)
	local pointFound = false
	local degree = 0
	local distCheck = startDist
	local rotation = 0
	local degreeAdd = 10

	cleanGroup(pointsFound)

	while pointFound == false do
		for i = 1, rotation do
			local x = startPos.x + (distCheck + math.cos(degree * (math.pi/180)))
			local y = startPos.y + (distCheck + math.sin(degree * (math.pi/180)))

			local hits = physics.rayCast(startPos.x, startPos.y, x, y, "sorted")
			if (hits) then
				for i,v in ipairs(hits) do
					for n = 1, checkGroup.numChildren do
						if v.object.name == checkGroup[n] then
							local point = display.newCircle(v.position.x, v.position.y, 1)
							point.alpha = 0
							point.name = v.object.name .. "Point"
							pointsFound:insert(point)
							pointsFound:toFront()
						end
					end
				end
			end
			degree = degree + degreeAdd
		end
		if distCheck >= 180 then
			degreeAdd = 5
			rotation = 72
		end
		degree = 0
		distCheck = distCheck + 20

		if lastPos ~= nil then
			for i = 1, pointsFound.numChildren do
				local distToPoint = distance(lastPos, pointsFound[i])
				if math.abs(distToPoint) < 80 then
					pointFound = true
					break
				end
			end	
		end
		if distCheck >= maxDist then
			pointFound = true
			break
		end
		if pointFound == false then
			cleanGroup(pointsFound)
		end
	end

	return pointsFound
end

local utilMath = {
	distance = distance,
	distanceXY = distanceXY,
	deg2rad = deg2rad,
	rad2deg = rad2deg,
	cleanGroup = cleanGroup,
	rayCastCircle = rayCastCircle
}

return utilMath