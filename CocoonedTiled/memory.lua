--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- memory.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Memory Check (http://coronalabs.com/blog/2011/08/15/corona-sdk-memory-leak-prevention-101/)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- debug text object
local textObject = {
			display.newText("mem",  25, 660, native.systemFont, 48),
			display.newText("text", 25, 710, native.systemFont, 48),
			display.newText("fps", 25, 760, native.systemFont, 48)
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
		textObject[i]:setFillColor(1,0,0)
		textObject[i]:toFront()
	end
end

local memory = {
	monitorMem = monitorMem
}

return memory

--------------------------------------------------------------------------------
-- END MEMORY CHECKER
--------------------------------------------------------------------------------