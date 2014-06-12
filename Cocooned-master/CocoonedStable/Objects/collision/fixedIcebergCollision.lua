local gameData = require("Core.gameData")
local uMath = require("utils.utilMath")

local icebergCount = 0
local shoreCheck = display.newGroup()
local waterShadow

local function collide(collideObject, player, event, mapData, map, gui)
	if event.phase == "began" then
		-- set the onIceberg variables
		gameData.onIceberg = true
		player[1].onLand = true

		-- start player death timer
		player[1]:stopDeathTimer()

		-- if the player was in water, then the player is safe now because they are on an iceberg
		if gameData.inWater then
			-- set player variables to safe ones
			player[1].shook = false
			gameData.inWater = false
			gameData.allowPaneSwitch = true
			player[1].lastPositionSaved = false
			player[1].imageObject:setLinearVelocity(0,0)
			player[1].imageObject.linearDamping = 1.25

			-- stop the alpha animation
			if player[1].sinkTrans ~= nil then
				transition.cancel(player[1].sinkTrans)
				player[1].sinkTrans = nil
			end
		end

		-- increment the iceBerg count to make sure how many bodies of iceBerg the player is on
		icebergCount = icebergCount + 1

	elseif event.phase == "ended" then

		-- decrement the iceBerg count to make sure if the player is still on an Iceberg
		if icebergCount > 0 then
			icebergCount = icebergCount - 1
		end

		-- calculate the distance of the player and the center of iceberg to see if he is still on it
		local dist = uMath.distance(player[1].imageObject, collideObject)
		--print("distance from center: " .. dist)

		-- if the dist is greater than 65, then the player is out of iceBerg
		if dist > 65 then

			-- clear the display group for later calculations
			if shoreCheck then
				for i = shoreCheck.numChildren, 1, -1 do
					shoreCheck[i]:removeSelf()
					shoreCheck[i] = nil
				end
			end

			-- if the icebergCound is 0 then the player is out of iceberg and we need to see if player is safe or not
			if icebergCount == 0 then

				-- set player booleans
				gameData.onIceberg = false
				player[1].onLand = false

				-- check the surrounds of the player with rayCasting, check for background
				local nameCheck = {"background"}
				local shoreCheck = uMath.rayCastCircle(player[1].imageObject, nil, 100, 100, nameCheck)

				-- check if the player is on land with raycasting data
				local onlyWater = true
				for i = 1, shoreCheck.numChildren do
					-- if background object was found, then the player is on land
					if shoreCheck[i].name == "background" then
						onlyWater = false
					end
				end
				
				-- if this boolean is true then the player is on water and now we start death timer
				if onlyWater then
					if player[1].lastPositionSaved == false then

						-- set the player variables
						player[1]:startDeathTimer(mapData, gui)
						player[1].lastPositionSaved = true
						player[1].lastSavePoint.pane = mapData.pane
						player[1].imageObject.linearDamping = 3

						-- calculate the next point of travel
						local xf, yf = uMath.calcNextPoint(player[1], 100)

						-- calculate the distance traveled
						distance = uMath.distanceXY(player[1].imageObject.x, player[1].imageObject.y, xf, yf)

						-- calculate the force to apply on player to make sure they are fully in water
						local jumpDirectionX, jumpDirectionY = 0, 0
						jumpDirectionX, jumpDirectionY = uMath.calcDirectionForce(player[1].imageObject.x, player[1].imageObject.y, xf, yf, distance, 8)

						-- apply that force onto the player
						player[1].imageObject:setLinearVelocity(0,0)
						player[1].imageObject:applyForce(jumpDirectionX, jumpDirectionY, player[1].imageObject.x, player[1].imageObject.y)

						-- stop the player once they are fully in water
						local function stopPlayer()
							player[1].imageObject:setLinearVelocity(0,0)
						end

						-- start timer to stop player when they are fully in water
						timer.performWithDelay(500, stopPlayer)

						-- set player variables and game variables
						player[1].imageObject:setLinearVelocity(0,0)
						gameData.allowPaneSwitch = false
						gameData.inWater = true

						-- play alpha animation for player
						player[1].sinkTrans = transition.to(player[1].imageObject, {time=3000, alpha=0})
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