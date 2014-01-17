-- Magnetism 

-- magnetism call
local function onMagnetism( event)
	-- send both ball position values to distance function
	distance(ballTable[1].x, ballTable[2].x, ballTable[1].y, ballTable[2].y)

	if distanceFrom(ballTable[1], ballTable[2]) < 100 and ballVariables.getRepelled() == false then
		if ballVariables.getMagnetized1() then
			ballTable[1]:applyLinearImpulse((ballTable[1].x - ballTable[2].x)/1000,(ballTable[1].y-ballTable[2].y)/1000, ballTable[1].x, ballTable[1].y)
		end
		if ballVariables.getMagnetized2() then
			ballTable[2]:applyLinearImpulse((ballTable[2].x - ballTable[1].x)/1000,(ballTable[2].y-ballTable[1].y)/1000, ballTable[2].x, ballTable[2].y)
		end
		ballVariables.setRepelled(true);
		timer.performWithDelay( 2000, ballVariables.setRepelled(false) )
	end

	if distanceFrom(ballTable[1], star) < 30 and distanceFrom(ballTable[2], star) < 30 and ballVariables.getMagnetized1() == false and ballVariables.getMagnetized2() == false then
		storyboard.gotoScene("select", "fade", 500)
		storyboard.removeScence("level2")
		storyboard.removeScence("level2a")
		storyboard.removeScence("level2b")
		storyboard.removeScence("level2c")
		storyboard.removeScence("level2d")

	end
end

local magnetism = {
	onMagnetism = onMagnetism
}

return magnetism