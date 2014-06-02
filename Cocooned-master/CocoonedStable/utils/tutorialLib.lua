--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- tutorialLib.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local generate = require("Objects.generateObjects")
local font = require("utils.font")
local gameData = require("Core.gameData")
local gameTimer = require("utils.timer")
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local tutorialLib = {
		tutorialStatus = 0,
}

local tempPlayer
local tempGui
local current

local hintText = {}
-- Variable function used to re-enabled minimap and pane switching
local delay = function() gameData.allowMiniMap = true; gameData.allowPaneSwitch = true; end
--------------------------------------------------------------------------------
-- init() - Initialize hintText array objects
--------------------------------------------------------------------------------
function tutorialLib:init()
	hintText = {
		--name         popped up?, tutorial cut scene image locations                                          -- text, box x position, box y position, box width, box height,
		["tiltTip"] = {false, "mapdata/art/cutscenes/tutorial/1.png", "mapdata/art/cutscenes/tutorial/2.png",
						"mapdata/art/cutscenes/tutorial/3.png", "mapdata/art/cutscenes/tutorial/4.png", 
						"mapdata/art/cutscenes/tutorial/5.png", "mapdata/art/cutscenes/tutorial/6.png",
						"mapdata/art/cutscenes/tutorial/7.png"},
		["swipePaneTip"] = {false, "mapdata/art/cutscenes/tutorial/8.png", "mapdata/art/cutscenes/tutorial/9.png"},
		["waterTip"] = {false, "mapdata/art/cutscenes/tutorial/10.png", "mapdata/art/cutscenes/tutorial/11.png",
							"mapdata/art/cutscenes/tutorial/12.png", "mapdata/art/cutscenes/tutorial/13.png", 
							"mapdata/art/cutscenes/tutorial/14.png"}
	}
end

--------------------------------------------------------------------------------
-- clean() - Clear out hintText array objects
--------------------------------------------------------------------------------
function tutorialLib:clean()
	if hintText then
		hintText["tiltTip"] = nil
		hintText["waterTip"] = nil
		hintText["swipePaneTip"] = nil
		hintText = nil
	end
	
	if tutorialLib.tutorialStatus > 0 then
		tutorialLib.tutorialStatus = 0
	end
end

--------------------------------------------------------------------------------
-- Checks if any tool tips are active
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
--[[local function toolTipActive()
	--if tilt tip is deleted create a new swipe pane tip
	if hintText["tiltTip"].active or hintText["waterTip"].active or hintText["swipePaneTip"].active then
		return true
	else
		return false
	end
end
]]--
--------------------------------------------------------------------------------
-- Deletes hints when they are clicked
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function deleteHint(event)							
	--delete text, rect and listener
	--hintText[event.target.name].rect:removeEventListener("tap", toggleNext)
	hintText[event.target.name].rect:removeSelf()
	--hintText[event.target.name].text:removeSelf()
	hintText[event.target.name].rect = nil
	--hintText[event.target.name].text = nil
	hintText[event.target.name].active = false
	--print(toolTipActive())

	--re-enable minimap functionality
	--if toolTipActive() == false then
	--end
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
		tutorialLib:showTipBox(event.target.name, tempCurr, tempGui, tempPlayer)	
		
	elseif hintText[event.target.name][tempCurr] == nil then
		-- Remove event listener
		hintText[event.target.name].rect:removeEventListener("tap", toggleNext)			
		-- Special case for post-tilt tip
		if event.target.name == "tiltTip" then
			tutorialLib.tutorialStatus = 1
			gameData.ingame = 1
		-- Special case for post-swipe tip
		elseif event.target.name == "swipePaneTip" then
			tutorialLib.tutorialStatus = 2
			local delayTimer = timer.performWithDelay(1000, delay)
		elseif event.target.name == "waterTip" then
			local delayTimer = timer.performWithDelay(1000, delay)
		end
		
		-- Resume physics
		--physics.start();
		if tempPlayer.small == true then
			tempPlayer.curse = 0.5
		else
			tempPlayer.curse = 1
		end
		print("tempPlayer.curse", tempPlayer.curse)
		
		-- Resume game timer
		gameTimer.resumeTimer()
		-- Process rest of clean up
		deleteHint(event)
	end	
end

--------------------------------------------------------------------------------
-- Creates text boxes for hints
-- (called in waterCollision line 48, rune Collision lines 69 and 87, exitportalcollision lines 48, timer lines 208 and 209
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
--called in movement 
function tutorialLib:showTipBox(tipType, value, gui, player)	
	--pause minimap functinality
	gameData.allowMiniMap = false
	gameData.allowPaneSwitch = false
	
	-- Pause physics	
	--physics.pause()
	-- temporarily store player
	tempPlayer = player
	if tempPlayer.curse ~= 0 then
		tempPlayer.curse = 0
	end

	-- Pause game timer while tutorial screen is up
	gameTimer.pauseTimer()
	-- temporarily store gui
	tempGui = gui
	-- temporarily store current value
	current = value
	
	local toolTip = {}
	local playerSeen = hintText[tipType][1]			
	if playerSeen == false then
		-- Create new image based on tipType
		toolTip[1] = display.newImageRect(hintText[tipType][current], 1460, 864)
		toolTip[1].x, toolTip[1].y = display.contentCenterX, display.contentCenterY
		toolTip[1].name = tipType
		--add tap functionality
		toolTip[1]:addEventListener("tap", toggleNext)
		-- insert to loading layer instead of front
		gui.load:insert(toolTip[1])
		--set hint to seen.
		hintText[tipType][1] = true
		--set hint to active
		hintText[tipType].active = true
		--keep reference to created objects
		hintText[tipType].rect = toolTip[1]
	end
end

return tutorialLib