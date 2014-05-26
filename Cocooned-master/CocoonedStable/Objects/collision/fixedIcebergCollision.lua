local gameData = require("Core.gameData")
local uMath = require("utils.utilMath")

local icebergCount = 0
local shoreCheck = display.newGroup()
local waterShadow

local function collide(collideObject, player, event, mapData, map, gui)
	if event.phase == "began" then
		gameData.onIceberg = true
		player.onLand = true
		player:stopDeathTimer()
		if gameData.inWater then
			player.shook = false
			gameData.inWater = false
			gameData.allowPaneSwitch = true
			player.lastPositionSaved = false
			player.imageObject:setLinearVelocity(0,0)
			player.imageObject.linearDamping = 1.25
		end
		icebergCount = icebergCount + 1
		print("~~~~~~~~~~~~~~~~~~~~ On dat iceberg COUNT: " .. icebergCount .. " ~~~~~~~~~~~~~~~~~~~")

	elseif event.phase == "ended" then
		if icebergCount > 0 then
			print(">>>>>>>>>>>>>>>>> Off dat iceberg COUNT: " .. icebergCount .. " <<<<<<<<<<<<<<<<<<<")
			icebergCount = icebergCount - 1
		end
		local dist = uMath.distance(player.imageObject, collideObject)
		print("distance from center: " .. dist)
		if dist > 65 then
			if shoreCheck then
				for i = shoreCheck.numChildren, 1, -1 do
					shoreCheck[i]:removeSelf()
					shoreCheck[i] = nil
				end
			end
			
			if icebergCount == 0 then

				gameData.onIceberg = false
				player.onLand = false
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
						player:startDeathTimer(mapData)
						player.lastPositionX = -100
						player.lastPositionY = -100
						player.lastPositionSaved = true
						player.lastSavePoint = collideObject
						player.imageObject.linearDamping = 3

						if waterShadow then
						waterShadow:removeSelf()
						waterShadow = nil
						end
						waterShadow = display.newCircle(player.lastPositionX, player.lastPositionY, 38)
						waterShadow.alpha = 0.75
						waterShadow:setFillColor(0,0,0)
						waterShadow:toFront()

						local vx, vy = player.imageObject:getLinearVelocity()
						--print("entry velocity is " .. vx .. ", " .. vy)


						local xf = player.imageObject.x + vx
						local yf = player.imageObject.y + vy

						local distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)

						local moveX = 100 * math.cos(math.acos(vx/distance))
						local moveY = 100 * math.sin(math.asin(vy/distance))

						xf = player.imageObject.x + moveX
						yf = player.imageObject.y + moveY

						--print("player is at " .. player.imageObject.x .. ", " .. player.imageObject.y)
						--print("move the player to this point: " .. xf .. ", " .. yf)

						distance = uMath.distanceXY(player.imageObject.x, player.imageObject.y, xf, yf)

						local deltaX, deltaY = 0,0
						deltaX = xf - player.imageObject.x
						deltaY = yf - player.imageObject.y

						local angleX = math.acos(deltaX/distance)
						local angleY = math.asin(deltaY/distance)

						local jumpDirectionX, jumpDirectionY = 0,0
						jumpDirectionX = 8 * math.cos(angleX)
						jumpDirectionY = 8 * math.sin(angleY)

						player.imageObject:setLinearVelocity(0,0)
						player.imageObject:applyForce(jumpDirectionX, jumpDirectionY, player.imageObject.x, player.imageObject.y)

						local function stopPlayer()
							print(">>>>>>>>>>>>> STOPPED DAT NIGGA")
							player.imageObject:setLinearVelocity(0,0)
						end

						timer.performWithDelay(500, stopPlayer)
						--local moveIntoWater = transition.to(player.imageObject, {time = 200, x = xf, y = yf})

						player.imageObject:setLinearVelocity(0,0)
						gameData.allowPaneSwitch = false
						gameData.inWater = true
					end
				end
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
	reset = reset
}

return fixedIcebergCollision