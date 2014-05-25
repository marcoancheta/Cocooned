local gameData = require("Core.gameData")
local uMath = require("utils.utilMath")

local icebergCount = 0
local shoreCheck = display.newGroup()
local waterShadow

local function collide(collideObject, player, event, mapData, map, gui)
	if event.phase == "began" then
		--print("~~~~~~~~~~~~~~~~~~~~ On dat iceberg ~~~~~~~~~~~~~~~~~~~")
		gameData.onIceberg = true
		icebergCount = icebergCount + 1
	elseif event.phase == "ended" then
		local dist = uMath.distance(player.imageObject, collideObject)
		--print("distance from center: " .. dist)
		if dist > 65 then
			if shoreCheck then
				for i = shoreCheck.numChildren, 1, -1 do
					shoreCheck[i]:removeSelf()
					shoreCheck[i] = nil
				end
			end
			--print(">>>>>>>>>>>>>>>>> Off dat iceberg <<<<<<<<<<<<<<<<<<<")
			gameData.onIceberg = false
			local degree = 0

			for i = 1, 36 do
				local x = player.imageObject.x + (100 * math.cos(uMath.deg2rad(degree)))
				local y = player.imageObject.y + (100 * math.sin(uMath.deg2rad(degree)))

				local hits = physics.rayCast(player.imageObject.x, player.imageObject.y, x, y, "sorted")
				if ( hits ) then
				    -- Output all the results.
				    for i,v in ipairs(hits)
				    do
				    	if v.object.name == "background" or v.object.name == "water" then
					    	local pointC = display.newCircle(v.position.x, v.position.y, 5)
					    	pointC:setFillColor(0.18,0.3,0.3)
					    	pointC.name = v.object.name
					    	shoreCheck:insert(pointC)
					    	shoreCheck:toFront()
					    end
				    end				
				else
				    -- There's no hit.
				end
				degree = degree + 10
			end
			--if shoreCheck.numChildren ~= 0 then print(" >>>>>>>>>>>>>>>>>>>>>>>>>>> WE GOT HITS <<<<<<<<<<<<<<<<<<<<<<<<<< ") end
			local onlyWater = true
			for i = 1, shoreCheck.numChildren do
				--print("Hit: " .. i .. " " .. shoreCheck[i].name .. " at position " .. shoreCheck[i].x .. ", " .. shoreCheck[i].y)
				if shoreCheck[i].name == "background" then
					onlyWater = false
				end
			end
			if onlyWater then
				--print(" YOU DROWNING NIGGA!!!")
				if player.lastPositionSaved == false then
					player.lastPositionX = -100
					player.lastPositionY = -100
					player.lastPositionSaved = true
					player.imageObject.linearDamping = 3

					if waterShadow then
					waterShadow:removeSelf()
					waterShadow = nil
					end
					waterShadow = display.newCircle(player.lastPositionX, player.lastPositionY, 38)
					waterShadow.alpha = 0.75
					waterShadow:setFillColor(0,0,0)
					waterShadow:toFront()
				end
				gameData.inWater = true
			end
		end

	end

	if gameData.debugMode then
		print("gameData.onIceberg", gameData.onIceberg)
	end
end

local function reset()
	icebergCount = 0
end

local fixedIcebergCollision = {
	collide = collide,
	reset = reset,
	icebergCount = icebergCount
}

return fixedIcebergCollision