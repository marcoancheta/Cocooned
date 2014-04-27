--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocotwod by Damaged Panda Games (http://signup.cocotwodgame.com/)
-- trails.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local trail = {}

--[[
local floorText = {
	type = "image",
	filename = "mapdata/art/texture/floor.png"
}
]]--

--------------------------------------------------------------------------------
-- Create Trail - Draws trail behind player
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function drawTrail(event)
	if line then		
		line:removeSelf()
		line = nil
	end

	if gui then				
		if #linePts >= 2 then
			line = display.newLine(linePts[1].x, linePts[1].y, linePts[2].x, linePts[2].y)
			line:setStrokeColor(1, 1, 1)
			--line.stroke = floorText
			line.strokeWidth = 15
			
			local lineDupe = display.newLine(linePts[1].x, linePts[1].y, linePts[2].x, linePts[2].y)
			lineDupe:setStrokeColor(236*0.003921568627451, 228*0.003921568627451, 243*0.003921568627451)
			lineDupe.strokeWidth = 30
			
			gui.middle:insert(lineDupe, 1)
			gui.middle:insert(line, 1)	
			
			for i = 3, #linePts, 1 do 
				line:append(linePts[i].x,linePts[i].y);
				lineDupe:append(linePts[i].x,linePts[i].y);
			end 
		end
	end	
end

trail.drawTrail = drawTrail

return trail