local gameData = require("gameData")
local movement = require("movement")

local floor = math.floor
local atan2 = math.atan2
local pi = math.pi

local rGhosts = {}
local playerCoord = {}
local ghostSprites = {}

-- Initialize Ghosts
function rGhosts:init()	
	ghostSprites = {
		[1] = graphics.newImageSheet("mapdata/art/temp/ghosts.png", 
					 {width = 55, height = 72, sheetContentWidth = 876, sheetContentHeight = 72, numFrames = 8})
	}

	local bGhost, gGhost, pGhost
	
end

local function companion(ghost, map, player)
	  	
	local function update(event)				
		ghost.x = player.x
		ghost.y = player.y 		
			
		--if not gameData.blueG then
		--	bGhost.isVisible = false
		--	Runtime:removeEventListener("enterFrame", update)
		--end
	end
	
	Runtime:addEventListener("enterFrame", update)
end

local function release(rune, map, player)
	-- Blue(map, player)
	if rune == "blueRune" then
		rGhosts:init()
		
		bGhost = display.newSprite(ghostSprites[1], spriteOptions.blueGhost)
		physics.addBody(bGhost, {bounce=0})
		
		bGhost.name = "blueGhost"
		bGhost.isVisible = true
		bGhost.isSensor = true
		bGhost:setSequence("move")
		bGhost:play()
		
		companion(bGhost, map, player)
		
		player.isSensor = true
		player.alpha = 0.5
		
		print("Go blue")
	-- Green
	elseif rune == "greenRune" then
		rGhosts:init()
		
		gGhost = display.newSprite(ghostSprites[1], spriteOptions.blueGhost)
		physics.addBody(gGhost, {bounce=0})
		
		gGhost.isVisible = true
		gGhost.isSensor = true
		gGhost:setSequence("move")
		gGhost:play()
		
		companion(gGhost, map, player)
		print("Go green")
	-- Pink
	elseif rune == "pinkRune" then
		rGhosts:init()
		
		pGhost = display.newSprite(ghostSprites[1], spriteOptions.blueGhost)
		physics.addBody(pGhost, {bounce=0})
		
		pGhost.isVisible = true
		pGhost.isSensor = true
		pGhost:setSequence("move")
		pGhost:play()
		
		companion(pGhost, map, player)	
		print("Go pink")
	end
end

rGhosts.release = release

return rGhosts