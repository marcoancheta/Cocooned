function trackCamera(event)
	-- Set player velocity according to movement result
	    if dPad.result == "l" then cameraTRK:setLinearVelocity(-cameraTRK.speed, 0)
	elseif dPad.result == "r" then cameraTRK:setLinearVelocity(cameraTRK.speed, 0)
	elseif dPad.result == "u" then cameraTRK:setLinearVelocity(0, -cameraTRK.speed)
	elseif dPad.result == "d" then cameraTRK:setLinearVelocity(0, cameraTRK.speed)
	elseif dPad.result == "n" then cameraTRK:setLinearVelocity(0, 0)
	end
end

-- Quick function to make all buttons uniform
local function newButton(parent) 
	local b = display.newRoundedRect(parent, 0, 0, 60, 60, 10) 
	      b:setFillColor(105*0.00392156862, 210*0.00392156862, 231*0.00392156862) 
		  b:setStrokeColor(1, 1, 1)
		  b.strokeWidth = 3
   return b 
end

-- Point in rect, using Corona objects rather than a list of coordinates
local function pointInRect(point, rect) 
	return (point.x <= rect.contentBounds.xMax) and 
		   (point.x >= rect.contentBounds.xMin) and 
		   (point.y <= rect.contentBounds.yMax) and 
		   (point.y >= rect.contentBounds.yMin) 
end

--------------------------------------------------------------------------------
-- Camera Movement Controls
--------------------------------------------------------------------------------
local function levelCamera(event)
	dPad = display.newGroup()
	
	map.layer["tiles"]:insert(cameraTRK)
	
	dPad.result = "n"
	-- Used to detect if the direction has moved
	dPad.prevResult = "n"

	-- Create the four buttons and position them
	dPad.l = newButton(dPad); dPad.l.x, dPad.l.y = -60, 0; dPad.r = newButton(dPad); dPad.r.x, dPad.r.y = 60, 0; dPad.u = newButton(dPad); dPad.u.x, dPad.u.y = 0, -60; dPad.d = newButton(dPad); dPad.d.x, dPad.d.y = 0, 60

	-- Position controls at lower-left
	dPad.x = display.screenOriginX + dPad.contentWidth * 0.5 + 40
	dPad.y = display.contentHeight - dPad.contentHeight * 0.5 - 40
		
	-- Touch listener for controls
	function dPad:touch(event)
		if event.target.isFocus or "began" == event.phase then
			dPad.prevResult = dPad.result
			-- Set result according to where touch is
					if pointInRect(event, dPad.l) then dPad.result = "l"
				elseif pointInRect(event, dPad.r) then dPad.result = "r"
				elseif pointInRect(event, dPad.u) then dPad.result = "u"
				elseif pointInRect(event, dPad.d) then dPad.result = "d"
			end
		end
			-- Just a generic touch listener
			if "began" == event.phase then
				trackPlayer = false
				trackInvisibleBoat = true
											
				display.getCurrentStage():setFocus(event.target)
				event.target.isFocus = true
			elseif event.target.isFocus then
				if "ended" == event.phase or "cancelled" == event.phase then
					display.getCurrentStage():setFocus(nil)
					event.target.isFocus = false
					dPad.result = "n"
				end
			end

			-- Did the direction change?
			if dPad.prevResult ~= dPad.result then 
				dPad.changed = true 
			end
			return true
	end
		
	-- Cancel touch event
	function dPad:cancelTouch()
		display.getCurrentStage():setFocus(nil)
		self.isFocus = false
		self.result = "n"
		return true
	end

	-- Clean
	function dPad:clean()
		self:cancelTouch()
		self:removeEventListener("touch")
		self.l.alpha = 1; self.r.alpha = 1; self.u.alpha = 1; self.d.alpha = 1
	end
			
	dPad:addEventListener("touch")
end
