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
	["tiltTip"] = {false, "Tilt to move.", 10, 10, 1000, 200},
	["rune1Tip"] = {false, "Runes grant abilities.", 10, 10, 1000, 200},
	["rune2Tip"] = {false, "Collect all runes in a level to activate portal.", 10, 10, 800, 200},
	["waterTip"] = {false, "Shake to swim to shore.", 10, 10, 1000, 200},
	["portalTip"] = {false, "Collect all runes in a level to activate portal.", 10, 10, 800, 200},
	["swipePaneTip"] = {false, "Tap or swipe to swap panes.", 10, 10, 800, 200}
}

--------------------------------------------------------------------------------
-- Deletes hints when they are clicked
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function deleteHint(event)
	--delete text, rect and listener
	hintText[event.target.name].rect:removeEventListener("tap", deleteHint)
	hintText[event.target.name].rect:removeSelf()
	hintText[event.target.name].text:removeSelf()
	hintText[event.target.name].rect = nil
	hintText[event.target.name].text = nil

	--re-enable minimap functionality
	local delay = function() gameData.allowMiniMap = true end
	local timer = timer.performWithDelay(300, delay)

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
		toolTip[2] = display.newText(tipText, toolTip[1].x, toolTip[1].y, native.systemFont, 32)
		toolTip[2]:setFillColor(1,1,1)
		gui.front:insert(toolTip[1])
		gui.front:insert(toolTip[2])

		--set hint to seen.
		hintText[tipType][1] = true

		--keep reference to created objects
		hintText[tipType].rect = toolTip[1]
		hintText[tipType].text = toolTip[2]
	end
end

return tutorialLib

