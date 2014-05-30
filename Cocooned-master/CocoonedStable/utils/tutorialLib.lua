--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- tutorialLib.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for tutorial textboxes

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local generate = require("Objects.generateObjects")
local font = require("utils.font")
local gameData = require("Core.gameData")

local tutorialLib = {}
local hintText = {
	--name         popped up?, text, box x position, box y position, box width, box height,
	["tiltTip"] = {false, "Tilt to move.", 20, 5, 700, 200, 72},
	["rune1Tip"] = {false, "Runes grant abilities.", 20, 12, 800, 200, 68},
	["rune2Tip"] = {false, "Collect all runes in a level to activate portal.", 20, 5, 1200, 200, 48},
	["waterTip"] = {false, "Shake to swim to shore.", 20, 12, 1000, 200, 72},
	["portalTip"] = {false, "Collect all runes in a level to activate portal.", 20, 19, 1200, 200, 48},
	["swipePaneTip"] = {false, "Tap or swipe to swap panes.", 20, 19, 800, 200, 48}
}

--------------------------------------------------------------------------------
-- Checks if any tool tips are active
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function toolTipActive()
	--if tilt tip is deleted create a new swipe pane tip
	if hintText["tiltTip"].active or hintText["rune1Tip"].active or hintText["waterTip"].active or hintText["portalTip"].active or hintText["swipePaneTip"].active then
		return true
	else
		return false
	end
end

--------------------------------------------------------------------------------
-- Deletes hints when they are clicked
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function deleteHint(event)
	--if tilt tip is deleted create a new swipe pane tip
	--if event.target.name == " tiltTip" then
		--local swipePaneTipTimer = timer.performWithDelay(1000, tutorialLib:showTipBox())
	--end

	--delete text, rect and listener
	hintText[event.target.name].rect:removeEventListener("tap", deleteHint)
	hintText[event.target.name].rect:removeSelf()
	hintText[event.target.name].text:removeSelf()
	hintText[event.target.name].rect = nil
	hintText[event.target.name].text = nil
	hintText[event.target.name].active = false
	print(toolTipActive())

	--re-enable minimap functionality
	if toolTipActive() == false then
		local delay = function() gameData.allowMiniMap = true end
		local timer = timer.performWithDelay(100, delay)
	end

end

--------------------------------------------------------------------------------
-- Creates text boxes for hints
-- (called in waterCollision line 48, rune Collision lines 69 and 87, exitportalcollision lines 48, timer lines 208 and 209
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
--called in movement 
function tutorialLib:showTipBox(tipType, gui)
	local playerSeen = hintText[tipType][1]
	local tipText = hintText[tipType][2]
	local boxPosX = hintText[tipType][3]
	local boxPosY = hintText[tipType][4]
	local boxWidth = hintText[tipType][5]
	local boxHeight = hintText[tipType][6]
	local fontSize = hintText[tipType][7]
	local toolTip = {}
	
	if playerSeen == false then
		--pause minimap functinality
		gameData.allowMiniMap = false

		--create background box
		toolTip[1] = display.newRect(0, 0, boxWidth, boxHeight)
		toolTip[1].x, toolTip[1].y = generate.tilesToPixels(boxPosX, boxPosY)

		-- same visuals as goal box
		toolTip[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		toolTip[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		toolTip[1].strokeWidth = 15
		toolTip[1].alpha = .5
		toolTip[1].name = tipType

		--add tap functionality
		toolTip[1]:addEventListener("tap", deleteHint)
		--add text over box and add to gui
		toolTip[2] = display.newText(tipText, toolTip[1].x, toolTip[1].y, font.TEACHERA, fontSize)
		toolTip[2]:setFillColor(1,1,1)
		gui.front:insert(toolTip[1])
		gui.front:insert(toolTip[2])

		--set hint to seen.
		hintText[tipType][1] = true

		--set hint to active
		hintText[tipType].active = true

		--keep reference to created objects
		hintText[tipType].rect = toolTip[1]
		hintText[tipType].text = toolTip[2]
	end
end

return tutorialLib