--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- breakWallCollision.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--local GA = require("plugin.gameanalytics")
local uMath = require("utils.utilMath")

-- variables for shake animation
local shakeAmount = 0
local shakeGui

-- lets start shaking!!
local function shakeScreen(event)
	if shakeAmount > 0 then
		-- shake dat nigga
		-- by getting a random number from shakeAmount and get random number from that amount
		-- then apply offset to gui to give shake effect
	    local shake = math.random( shakeAmount )
	    shakeGui.x = shakeGui.originalX + math.random( -shake, shake )
	    shakeGui.y = shakeGui.originalY + math.random( -shake, shake )
	    shakeAmount = shakeAmount - 1
	else
		-- once its done shaking, turn off event listener and revert gui back to original position (0,0)
		shakeGui.x = shakeGui.originalX
		shakeGui.y = shakeGui.originalY
		Runtime:removeEventListener ("enterFrame", shakeScreen)
	end
end

--------------------------------------------------------------------------------
-- Collide Function - function for breakable wall collision
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function collide(collideObject, player, event, mapData, map, gui)

	if event.phase == "began" then
		-- if breakCount is less than 3 and the wall hasn't been hit then increment and shake screen
		if collideObject.breakCount < 3  and collideObject.justHit == false and player.breakable then
			print("breaking")
			-- increment breakCount counter and set boolean of just hit
			collideObject.breakCount = collideObject.breakCount + 1
			collideObject.justHit = true
			
			-- set the shake amount and call eventListener
			shakeAmount = 50
			shakeGui = gui
			Runtime:addEventListener("enterFrame", shakeScreen)
		end
	elseif event.phase == "ended" then
		-- print("ended collision with break wall")
		if collideObject.breakCount < 3  and player.breakable then
			-- function for changeing boolean to false so that player can hit the 
			local function changeBool(event)
				collideObject.justHit = false
			end
			-- delay the timer to give time for shake to be done
			timer.performWithDelay(1000, changeBool)
		-- if the breakCount is 3, then destroy that wall
		elseif collideObject.breakCount == 3 and player.breakable then
			collideObject.breakCount = collideObject.breakCount + 1
			transition.to(collideObject, {time = 300, alpha = 0, onComplete = function() collideObject:removeSelf() end})
		end
	end
	
end



--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local breakWallCollision = {
	collide = collide
}

return breakWallCollision

-- end of breakWallCollision.lua