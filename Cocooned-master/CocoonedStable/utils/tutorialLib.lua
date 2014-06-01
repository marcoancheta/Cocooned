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
local gameTimer = require("utils.timer")

local tempGui
local current
local tutorialLib = {}
local hintText = {
	--name         popped up?, tutorial cut scene image locations                                          -- text, box x position, box y position, box width, box height,
	["tiltTip"] = {false, "mapdata/art/cutscenes/tutorial/1.png", "mapdata/art/cutscenes/tutorial/2.png"}, --{false, "Tilt to move.", 20, 5, 700, 200, 72},
	["pinkRuneTip"] = {false, "mapdata/art/cutscenes/tutorial/3.png", "mapdata/art/cutscenes/tutorial/4.png"}, --{false, "Runes grant abilities.", 20, 12, 800, 200, 68},
	["purpRuneTip"] = {false, "mapdata/art/cutscenes/tutorial/3.png", "mapdata/art/cutscenes/tutorial/4.png"}, --{false, "Collect all runes in a level to activate portal.", 20, 5, 1200, 200, 48},
	["kipcha"] = {false, "mapdata/art/cutscenes/tutorial/7.png"},
	["waterTip"] = {false, "mapdata/art/cutscenes/tutorial/10.png", "mapdata/art/cutscenes/tutorial/11.png"}, --{false, "Shake to swim to shore.", 20, 12, 1000, 200, 72},
	["swipePaneTip"] = {false, "mapdata/art/cutscenes/tutorial/8.png", "mapdata/art/cutscenes/tutorial/9.png"}, --{false, "Tap or swipe to swap panes.", 20, 19, 800, 200, 48}
	["fishTip"] = {false, "mapdata/art/cutscenes/tutorial/12.png", "mapdata/art/cutscenes/tutorial/13.png", "mapdata/art/cutscenes/tutorial/14.png"},
	["portalTip"] = {false, "mapdata/art/cutscenes/tutorial/5.png", "mapdata/art/cutscenes/tutorial/6.png"}, --{false, "Collect all runes in a level to activate portal.", 20, 19, 1200, 200, 48},
	["runeObjective"] = {false, "mapdata/art/cutscenes/tutorial/3.png", "mapdata/art/cutscenes/tutorial/4.png"}
}

--------------------------------------------------------------------------------
-- Checks if any tool tips are active
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function toolTipActive()
	--if tilt tip is deleted create a new swipe pane tip
	if hintText["tiltTip"].active or hintText["pinkRuneTip"].active or hintText["waterTip"].active or hintText["portalTip"].active 
		or hintText["swipePaneTip"].active or hintText["purpRuneTip"].active then
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
local function deleteHint(event)							
	--if tilt tip is deleted create a new swipe pane tip
	--if event.target.name == " tiltTip" then
		--local swipePaneTipTimer = timer.performWithDelay(1000, tutorialLib:showTipBox())
	--end

	--delete text, rect and listener
	--hintText[event.target.name].rect:removeEventListener("tap", toggleNext)
	hintText[event.target.name].rect:removeSelf()
	--hintText[event.target.name].text:removeSelf()
	hintText[event.target.name].rect = nil
	--hintText[event.target.name].text = nil
	hintText[event.target.name].active = false
	print(toolTipActive())

	--re-enable minimap functionality
	if toolTipActive() == false then
		local delay = function() gameData.allowMiniMap = true end
		local timer = timer.performWithDelay(100, delay)
	end
end

--------------------------------------------------------------------------------
-- Toggles to the next scene image
--------------------------------------------------------------------------------
-- Updated by: D
--------------------------------------------------------------------------------
local function toggleNext(event)
	local tempCurr = current + 1
	if hintText[event.target.name][tempCurr] ~= nil then
		--print(tempCurr)
		hintText[event.target.name].rect:removeEventListener("tap", toggleNext)
		hintText[event.target.name].rect:removeSelf()
		hintText[event.target.name][1] = false
		hintText[event.target.name].active = false
		tutorialLib:showTipBox(event.target.name, tempCurr, tempGui)	
	
	elseif hintText[event.target.name][tempCurr] == nil then
		-- Remove event listener
		hintText[event.target.name].rect:removeEventListener("tap", toggleNext)
		-- Special case for post-tilt tip
		if event.target.name == "tiltTip" then
			hintText[event.target.name].rect:removeSelf()
			tutorialLib:showTipBox("runeObjective", 2, tempGui)
		-- Special case for post-portal tip
		elseif event.target.name == "portalTip" then
			hintText[event.target.name].rect:removeSelf()
			tutorialLib:showTipBox("kipcha", 2, tempGui)
		-- Special case for kipcha interruption
		elseif event.target.name == "kipcha" then
			hintText[event.target.name].rect:removeSelf()
			tutorialLib:showTipBox("swipePaneTip", 2, tempGui)
		-- Special event for post-swipe pane tip
		elseif event.target.name == "swipePaneTip" then
			gameData.ingame = 1
			deleteHint(event)
			gameTimer.resumeTimer()
		else
			-- Process rest of clean up
			deleteHint(event)
			-- Resume game timer
			gameTimer.resumeTimer()
		end
	end	
end

--------------------------------------------------------------------------------
-- Creates text boxes for hints
-- (called in waterCollision line 48, rune Collision lines 69 and 87, exitportalcollision lines 48, timer lines 208 and 209
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
--called in movement 
function tutorialLib:showTipBox(tipType, value, gui)
	gameTimer.pauseTimer()
	-- temporarily store gui
	tempGui = gui
	-- temporarily store current value
	current = value
	
	local playerSeen = hintText[tipType][1]
	
	--local tipText = hintText[tipType][2]
	--local boxPosX = hintText[tipType][3]
	--local boxPosY = hintText[tipType][4]
	--local boxWidth = hintText[tipType][5]
	--local boxHeight = hintText[tipType][6]
	--local fontSize = hintText[tipType][7]
	
	local toolTip = {}
	
	if playerSeen == false then
		--pause minimap functinality
		gameData.allowMiniMap = false

		--create background box
		--toolTip[1] = display.newRect(0, 0, boxWidth, boxHeight)
		toolTip[1] = display.newImageRect(hintText[tipType][current], 1460, 864)
		toolTip[1].x, toolTip[1].y = display.contentCenterX, display.contentCenterY

		-- same visuals as goal box
		--toolTip[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		--toolTip[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		--toolTip[1].strokeWidth = 15
		--toolTip[1].alpha = .5
		toolTip[1].name = tipType

		--add tap functionality
		toolTip[1]:addEventListener("tap", toggleNext)
		--add text over box and add to gui
		--toolTip[2] = display.newText(tipText, toolTip[1].x, toolTip[1].y, font.TEACHERA, fontSize)
		--toolTip[2]:setFillColor(1,1,1)
		gui.load:insert(toolTip[1])
		--gui.front:insert(toolTip[2])

		--set hint to seen.
		hintText[tipType][1] = true

		--set hint to active
		hintText[tipType].active = true

		--keep reference to created objects
		hintText[tipType].rect = toolTip[1]
		--hintText[tipType].text = toolTip[2]
	end
end

return tutorialLib