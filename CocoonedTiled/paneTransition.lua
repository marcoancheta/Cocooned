--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- paneTransition.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for pane switching transitions

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local paneSheet = graphics.newImageSheet("mapdata/art/snowAnimation.png", 
				 {width = 1440, height = 891, sheetContentWidth = 7200, sheetContentHeight = 4081, numFrames = 20})
local transPic, tempPic


--------------------------------------------------------------------------------
-- Play Transition -- function that plays pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playTransition(temp, pane, map, player)

	-- save current pane image
	tempPic = display.capture(map)
	tempPic.x, tempPic.y = 720, 432

	-- play pane switch transition and move to front
	transPic = display.newSprite(paneSheet, spriteOptions.paneSwitch)
	transPic:scale(1.25, 1.25)
	transPic.x, transPic.y = 720, 432
	transPic:setSequence("move")
	transPic:play()
	tempPic:toFront()
	transPic:toFront()

	-- declare direction which pane swithc transition should play
	local direction = "None"

	-- if Pane is Main, chose which direction to play transition 
	-- depending on new pane
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
	
	-- depending on which direction, rotate the pane switch transition
	if direction == "right" then
		transPic:scale(2,2)
		transPic.rotation = -90
	elseif direction == "left" then
		transPic:scale(2,2)
		transPic.rotation = 90
	elseif direction == "up" then
		transPic.rotation = 180
	elseif direction == "down" then
		-- do not change anything for down transition
	elseif direction == "rightdown" then
		transPic:scale(1.5,1.5)
		transPic.rotation = 45
	elseif direction == "rightup" then
		transPic:scale(1.5,1.5)
		transPic.rotation = 135
	elseif direction == "leftdown" then
		transPic:scale(1.5,1.5)
		transPic.rotation = -45
	elseif direction == "leftup" then
		transPic:scale(1.5,1.5)
		transPic.rotation = -135
	end

	-- timers for deleting pane image and ending pane switch
	timer.performWithDelay(450, deleteTemp)
	timer.performWithDelay(900, endTransition)
end

--------------------------------------------------------------------------------
-- Delete Temp - function that deletes pane image taken before pane switch
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function deleteTemp()
	tempPic:removeSelf()
end

--------------------------------------------------------------------------------
-- End Transition - function that ends pane switch transition
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function endTransition()
	-- set sequence to stop and remove it
	transPic:setSequence("stop")
	transPic:toBack()
	transPic:removeSelf()
	
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local paneTransition = {
	playTransition = playTransition
}

return paneTransition

-- end of paneTransition.lua