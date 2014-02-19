--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- paneTransition.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local paneSheet = graphics.newImageSheet("mapdata/art/paneSwitch.png", 
				 {width = 1440, height = 891, sheetContentWidth = 4320, sheetContentHeight = 8019, numFrames = 27})


function startTransition()

end

function playTransition(temp, pane)
	transPic = display.newSprite(paneSheet, spriteOptions.paneSwitch)
	transPic:scale(1.25, 1.25)
	transPic.x, transPic.y = 720, 432
	transPic:setSequence("move")
	transPic:play()
	transPic:toFront()
	transPic:toFront()
	local direction = "None"
	if temp == "M" then
		if pane == "R" then direction = "right"
		elseif pane == "L" then direction = "left"
		elseif pane == "U" then direction = "up"
		elseif pane == "D" then direction = "down"
		end
	elseif temp == "R" then
		if pane == "U" then direction = "rightup"
		elseif pane == "D" then direction = "rightdown"
		else direction = "left"
		end
	elseif temp == "L" then
		if pane == "U" then direction = "leftdown"
		elseif pane == "D" then direction = "leftup"
		else direction = "right"
		end
	elseif temp == "D" then
		if pane == "L" then direction = "rightup"
		elseif pane == "R" then direction = "leftup"
		else direction = "up"
		end
	elseif temp == "U" then
		if pane == "L" then direction = "rightdown"
		elseif pane == "R" then direction = "leftdown"
		else direction = "down"
		end
	end
	
	if direction == "right" then
		trans(transPic, 0, 432, 2440, 432, 300)
	elseif direction == "left" then
		trans(transPic, 1840, 432, -720, 432, 300)
	elseif direction == "up" then
		trans(transPic, 720, 864, 720, -864, 300)
		transPic.rotation = 180
	elseif direction == "down" then
		trans(transPic, 720, -232, 720, 1864, 800)
	elseif direction == "rightdown" then
		trans(transPic, 1840, -432, -720, 864, 300)
	elseif direction == "rightup" then
		trans(transPic, 1840, 864, -720, -864, 300)
	elseif direction == "leftdown" then
		trans(transPic, 0, -432, 2440, 864, 300)
	elseif direction == "leftup" then
		trans(transPic, 0, 864, 2440, -864, 300)
	end
	
	--transPic:setSequence("stop")
	--transPic:toBack()
	--transPic:stop()
	timer.performWithDelay(800, endTransition)
end

function endTransition()
	transPic:setSequence("stop")
	transPic:toBack()
end

function trans(object, sX, sY, moveX, moveY, moveTime)
	--object.x, object.y = sX, sY
	--transition.to(object, {x = moveX, y = moveY, time = moveTime})
end

local paneTransition = {
	playTransition = playTransition
}

return paneTransition