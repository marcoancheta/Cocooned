local gameData = require("gameData")

local rGhosts = {}

local ghostSprites = {
	[1] = graphics.newImageSheet("mapdata/art/temp/ghosts.png", 
				 {width = 50, height = 72, sheetContentWidth = 876, sheetContentHeight = 72, numFrames = 8})

}

local function blue(event)

	local params = event.source.params

	print(params.param2)
	print(params.param3)
	
	local spriteB = ghostSprites[1]
	local bGhost = display.newSprite(ghostSprites[1], spriteOptions.blueGhost)
		  bGhost.x = params.param2
		  bGhost.y = params.param3		  
		  
		  bGhost.isVisible = true
		  gameData.blueG = true
		  
		  bGhost:addEventListener("enterFrame", blue)
	print("Blue Success")
end

local function green(map, player)
	print("Green Success")
end

local function pink(map, player)
	print("Pink Success")
end

local function purple(map, player)
	print("Purple Success")
end

local function yellow(map, player)
	print("Yellow Success")
end


local function release(rune, map, player)
	-- Blue(map, player)
	if rune.name == "blueRune" then
		--blue(map, player)
		print(player.imageObject.x, player.imageObject.y)
		test = timer.performWithDelay(1, blue)
		test.params = {param1 = map, param2 = player.imageObject.x, param3 = player.imageObject.y}
		print("Go blue")
	-- Green
	elseif rune.name == "greenRune" then
		green(map, player)
		print("Go green")
	-- Pink
	elseif rune.name == pinkRune then
		pink(map, player)	
		print("Go pink")
	-- Purple
	elseif rune.name == "purpleRune" then
		purple(map, player)
		print("Go purple")
	-- Yellow
	elseif rune.name == "yellowRune" then
		yellow(map, player)
		print("Go yellow")
	end
end

rGhosts.release = release
rGhosts.blue = blue
rGhosts.ghostUpdate = ghostUpdate

return rGhosts