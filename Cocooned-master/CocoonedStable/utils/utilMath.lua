-- find distance of two points
local function distance(object1, object2)
	local d = math.sqrt((object2.x-object1.x)^2 + (object2.y-object1.y)^2)
	return d
end

-- find distance of two points, alternate
local function distanceXY(x1, y1, x2, y2)
	local d = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
	return d
end

-- change degree to radians
local function deg2rad(degree)
	local rad = degree * (math.pi/180)
	return rad
end

-- change radians to degree
local function rad2deg(radian)
	local deg = radian * (180/math.pi)
	return deg
end

-- function for cleaning displayGroups
local function cleanGroup(group)
	if group.numChildren ~= 0 then
		for i = group.numChildren, 1, -1 do
			group[i]:removeSelf()
			group[i] = nil
		end
	end
end

-- displayGroup for rayCasting calculations
local pointsFound = display.newGroup()
-- rayCasting function
local function rayCastCircle(startPos, lastPos, startDist, maxDist, checkGroup)

	print("check at point " .. startPos.x .. ", " .. startPos.y)
	-- set the variables used for rayCasting calculations
	local pointFound = false
	local degree = 0
	local distCheck = startDist
	local rotation = 36
	local degreeAdd = 10

	-- clean the displayGroup from previous use
	cleanGroup(pointsFound)

	-- make loop for raycasting until a point is found
	while pointFound == false do
		-- check raycasting in 360 degree radius
		for i = 1, rotation do
			-- find the point where raycasting will take placelocal point = display.newCircle(x, y, 5)
			-- point:setFillColor(0,0,0)
			-- pointsFound:insert(point)
			-- pointsFound:toFront()
			local x = startPos.x + (distCheck * math.cos(degree * (math.pi/180)))
			local y = startPos.y + (distCheck * math.sin(degree * (math.pi/180)))

			-- get raycast data
			local hits = physics.rayCast(startPos.x, startPos.y, x, y, "sorted")
			-- if we have data, check that data
			if (hits) then
				for i,v in ipairs(hits) do
					for n = 1, #checkGroup do
						if v.object ~= nil then
							-- check if any data is matching with what we want raycasting to check
							-- if it doesm save that point to pointsFound display group
							if v.object.name == checkGroup[n] then
								local point = display.newCircle(v.position.x, v.position.y, 5)
								point.alpha = 0
								point.name = v.object.name .. "Point"
								pointsFound:insert(point)
								pointsFound:toFront()
							end
						end
					end
				end
			end
			-- increment the degree of check for raycast until we go in a full circle
			degree = degree + degreeAdd
		end
		-- if the distance check if greater than 180 then we need to make sure we decrease degreeAdd so we check more ground
		if distCheck >= 180 then
			degreeAdd = 5
			rotation = 72
		end

		-- reset the degree and increase distance check
		degree = 0
		distCheck = distCheck + 20

		-- if we want to compare points found with a last point, check the distance of those points
		if lastPos ~= nil then
			for i = 1, pointsFound.numChildren do
				local distToPoint = distance(lastPos, pointsFound[i])
				-- if the distance if less than 80, that point is close to the last save point, so we use that point, set point Found to true
				if math.abs(distToPoint) < 80 then
					pointFound = true
					break
				end
			end	
		end

		-- if the distance Check is greater than the max distance we want to check, stop the rayCasting check, and use what ever points we found
		if distCheck >= maxDist then
			pointFound = true
			break
		end

		-- if a desired point was not found, clean the group and raycast again
		if pointFound == false then
			cleanGroup(pointsFound)
		end
	end

	-- return the display group of desired points found from raycasting
	return pointsFound
end

-- calculate the direcitonal force you want the player to go
local function calcDirectionForce(startPosX, startPosY, endPosX, endPosY, dist, power)

	-- get the offSet of startPos to endPos
	local deltaX, deltaY = 0,0
	deltaX = endPosX - startPosX
	deltaY = endPosY - startPosY

	-- get the angle of movement
	local angleX = math.acos(deltaX/dist)
	local angleY = math.asin(deltaY/dist)

	-- get the force to apply to the player in that direction with a certain power
	local directX, directY = 0,0
	directX = power * math.cos(angleX)
	directY = power * math.sin(angleY)

	-- return the force to apply to player in X and Y direction
	return directX, directY
end

-- calculate the next travel point of player depending on their velocity
local function calcNextPoint(player, distance)

	-- get the players velocity
	local vx, vy = player.imageObject:getLinearVelocity()

	-- get the players next location from velocity
	local xf = player.imageObject.x + vx
	local yf = player.imageObject.y + vy

	-- calculate the distance traveled
	local distance = distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)

	-- get the travel movement depending on how far you want player to travel in velocity direction
	local moveX = distance * math.cos(math.acos(vx/distance))
	local moveY = distance * math.sin(math.asin(vy/distance))

	-- get that final location you want the player to go to
	xf = player.imageObject.x + moveX
	yf = player.imageObject.y + moveY

	-- return those points
	return xf, yf
end

local utilMath = {
	distance = distance,
	distanceXY = distanceXY,
	deg2rad = deg2rad,
	rad2deg = rad2deg,
	cleanGroup = cleanGroup,
	rayCastCircle = rayCastCircle,
	calcDirectionForce = calcDirectionForce,
	calcNextPoint = calcNextPoint
}

return utilMath