--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- memory.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
--------------------------------------------------------------------------------
-- Memory Check (http://coronalabs.com/blog/2011/08/15/corona-sdk-memory-leak-prevention-101/)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- debug text object
local textObject = {
		display.newText("mem",  10, 720, native.systemFont, 48),
		display.newText("text", 10, 780, native.systemFont, 48),
		display.newText("fps", 10, 80, native.systemFont, 48),
		display.newText("Memory Stable", 10, 30, native.systemFont, 48),
		display.newText("", 600, 200, native.systemFont, 72)
}

local prevTextMem = 0
local prevMemCount = 0
local monitorMem = function() collectgarbage("collect")
	local memCount = collectgarbage("count")
	local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
		
	if (prevMemCount ~= memCount) and (prevTextMem ~= textMem) then
		textObject[1].text = "Mem:" .. " " .. memCount
		textObject[2].text = "Text:" .. " " .. textMem
		textObject[3].text = "FPS:" .. " " .. display.fps
				
		prevMemCount = memCount
		prevTextMem = textMem
	end

	for i=1, #textObject do
		textObject[i].anchorX = 0
		textObject[i]:setFillColor(0,1,0)
		textObject[i]:toFront()
	end
	
	return textObject
end

local function handleLowMemory(event) 
	textObject[4].text = "Memory warning received"
	textObject[4]:setFillColor(1, 0, 0)
end


-- Water debug display function
local function inWater()
	if gameData.inWater then
		textObject[5].text = player1.inventory.runeSize
	else
		textObject[5].text = "false"
	end
	
	textObject[5].x = display.contentCenterX - 50
	textObject[5].y = display.contentCenterY
	textObject[5]:setFillColor(0,0,1)
	textObject[5]:toFront()
end

local function toggle()
	for i=1, #textObject do
		if gameData.debugMode == false then
			textObject[i].isVisible = false
		else
			textObject[i].isVisible = true
		end
	end
end

 
local memory = {
	textObject = textObject,
	monitorMem = monitorMem,
	handleLowMemory = handleLowMemory,
	inWater = inWater,
	toggle = toggle
}

return memory

--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------