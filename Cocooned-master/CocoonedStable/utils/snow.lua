--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- snow.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Base snow algorithm derived from: http://forums.coronalabs.com/topic/27637-snow-effect/
--------------------------------------------------------------------------------
local levelNames = require("utils.levelNames")
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Local Variables
--------------------------------------------------------------------------------
local snowGroup
local snowTrans
local wind


--------------------------------------------------------------------------------
-- snow.new() - Re-initialize snowGroup
--------------------------------------------------------------------------------
local function new()
	snowGroup = display.newGroup()
	wind = math.random(80) - 40
end

--------------------------------------------------------------------------------
-- snow.meltSnow() - Clean up snow variables
--------------------------------------------------------------------------------
local function meltSnow()
	transition.cancel(snowTrans)
	if snowGroup then
		snowGroup:removeSelf()
		snowGroup = nil
		wind = nil
		snowTrans = nil
	end
end

--------------------------------------------------------------------------------
-- snow.pauseSnow() - pause snow transition
--------------------------------------------------------------------------------
local function pauseSnow()
	transition.pause(snowTrans)
end

--------------------------------------------------------------------------------
-- snow.resumeSnow() - resume snow transition
--------------------------------------------------------------------------------
local function resumeSnow()
	transition.resume(snowTrans)
end

--------------------------------------------------------------------------------
-- removeFlake(target) - Delete snow object if target has been reached
--------------------------------------------------------------------------------
local function removeFlake(target)
	if gameData.ingame then
		if target then
			target:removeSelf()
			target = nil
		end
	end
end

--------------------------------------------------------------------------------
-- spawnSnowFlake() - Create and transit snow object for main menu
--------------------------------------------------------------------------------
local function spawnSnowFlake()
	-- Create a new temp flake
	local flake = display.newCircle(0,0,5)
	flake.name = "flake"
    flake.x = math.random(0, display.contentWidth)
    flake.y = -2
	-- Apply transition to global variable
    flake.trans = transition.to(flake,{time=math.random(5000) + 3000, 
										y = math.random(display.contentHeight-50, display.contentHeight-10), 
										x = flake.x + wind, 
										onComplete=removeFlake})									
	return flake
end

--------------------------------------------------------------------------------
-- calcSnowDir(snowFlake) - Math for in-game snow algorithm
--------------------------------------------------------------------------------
local function calcSnowDir(snowflake)
	if snowflake and wind then
		--	  formula = {Down, Up, Left, Right}
		local formula = {(snowflake.x + wind), (snowflake.x + wind), (snowflake.y - wind), (snowflake.y + wind)}
		-- 	   Dir = {Middle, Down, Up, Left, Right)
		local xDir = {0, formula[1], formula[2], 1240, 200}
		local yDir = {0, 200, 660, formula[3], formula[4]}
		
		return xDir, yDir
	end
end

--------------------------------------------------------------------------------
-- levelSnow(mapData) - Create and transit snow object for in game
--------------------------------------------------------------------------------
local function levelSnow(mapData, gui)
	-- load in level file according to mapData.levelNumber
	local level = require("levels." .. levelNames[mapData.levelNum])
	-- 	   Coordinate table
	--     Pos = {Middle[1] (0,0),
	--			  Down[2]   (math.random(display.contentWidth), -2), 
	--			  Up[3]		(math.random(display.contentWidth), display.contentHeight), 
	--			  Left[4]	(display.contentWidth, math.random(display.contentHeight), 
	--			  Right[5]	(-2, math.random(display.contentHeight)}
	local xPos = {0, math.random(display.contentWidth), math.random(display.contentWidth), display.contentWidth, -2}
	local yPos = {0, -2, display.contentHeight, math.random(display.contentHeight), math.random(display.contentHeight)}
	
	-- Transition snowBall according to pane name
	if gameData.ingame and gameData.inLevelSelector ~= 1 then
		if mapData.pane == "M" then	
			for i=1, #level.panes do
				-- Check if all neighbouring panes exist
				if level.panes[i+1] then
					-- Create a new temp flake
					local flake = display.newCircle(0,0,5)
					flake.x = xPos[i+1]
					flake.y = yPos[i+1]
					flake.name = "flake"
					-- Send & receive directional coordinates
					local xDir, yDir = calcSnowDir(flake)				
					-- Apply transition to global variable
					if xDir and yDir then
						snowTrans = transition.to(flake,{time=math.random(5000) + 3000, 
															y = yDir[i+1], x = xDir[i+1], onComplete=removeFlake})													
					end
					-- Pass flake into snowBall for return
					gui.front:insert(flake)					
				end
			end
		elseif mapData.pane == "U" then
			-- Create a new temp flake
			local flake = display.newCircle(0,0,5)
			flake.x = xPos[3]
			flake.y = yPos[3]
			flake.name = "flake"
			-- Send & receive directional coordinates
			local xDir, yDir = calcSnowDir(flake)
			-- Apply transition to global variable
			if xDir and yDir then
				snowTrans = transition.to(flake,{time=math.random(5000) + 3000, 
												y = yDir[3], x = xDir[3], onComplete=removeFlake})
			end
			-- Pass flake into snowBall for return
			gui.front:insert(flake)
		elseif mapData.pane == "D" then
			-- Create a new temp flake
			local flake = display.newCircle(0,0,5)
			flake.x = xPos[2]
			flake.y = yPos[2]
			flake.name = "flake"
			-- Send & receive directional coordinates
			local xDir, yDir = calcSnowDir(flake)
			-- Apply transition to global variable
			if xDir and yDir then
				snowTrans = transition.to(flake,{time=math.random(5000) + 3000, 
												y = yDir[2], x = xDir[2], onComplete=removeFlake})
			end
			-- Pass flake into snowBall for return
			gui.front:insert(flake)
		elseif mapData.pane == "L" then
			-- Create a new temp flake
			local flake = display.newCircle(0,0,5)
			flake.x = xPos[4]
			flake.y = yPos[4]
			flake.name = "flake"
			-- Send & receive directional coordinates
			local xDir, yDir = calcSnowDir(flake)
			-- Apply transition to global variable
			if xDir and yDir then
				snowTrans = transition.to(flake,{time=math.random(5000) + 3000, 
												y = yDir[4], x = xDir[4], onComplete=removeFlake})
			end
			-- Pass flake into snowBall for return
			gui.front:insert(flake)
		elseif mapData.pane == "R" then
			-- Create a new temp flake
			local flake = display.newCircle(0,0,5)
			flake.x = xPos[5]
			flake.y = yPos[5]
			flake.name = "flake"
			-- Send & receive directional coordinates
			local xDir, yDir = calcSnowDir(flake)
			-- Apply transition to global variable
			if xDir and yDir then
				snowTrans = transition.to(flake,{time=math.random(5000) + 3000, 
												y = yDir[5], x = xDir[5], onComplete=removeFlake})
			end
			-- Pass flake into snowBall for return
			gui.front:insert(flake)
		end
	end
end

--------------------------------------------------------------------------------
-- snow.makeSnow() - Algorithm for snow particle in main menu
--------------------------------------------------------------------------------
local function makeSnow(event, mapData)
	local temp
    if math.random(15) == 1 then -- adjust speed here by making the random number higher or lower
		temp = spawnSnowFlake()
		snowGroup:insert(temp)
		snowGroup:toFront()
	end
	
	return true
end

--------------------------------------------------------------------------------
-- snow.gameSnow() - Algorithm for snow particle in game
--------------------------------------------------------------------------------
local function gameSnow(event, mapData, gui)
	if math.random(10) == 1 then -- adjust speed here by making the random number higher or lower
		levelSnow(mapData, gui)
	end	
	return true
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
local snow = {
	new = new,
	meltSnow = meltSnow,
	pauseSnow = pauseSnow,
	resumeSnow = resumeSnow,
	makeSnow = makeSnow,
	gameSnow = gameSnow
}

return snow
-- end of snow.lua