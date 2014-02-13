--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- fifteen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")


local fifteen = { 
	energyCount = 30
}

local function coinMachine(coins, rune)
	-- Position coins
	for i=1, #coins do
		coins[i].x, coins[i].y = map.tilesToPixels(i*3, 7)
		map.layer["tiles"]:insert(coins[i])
		coins[i]:setSequence("move")
		coins[i]:play()
		coins[i].isVisible = true
	end

end

local function load(pane, map, rune, coins)
	-- Check which pane
	if pane == "M" then
		-- Assign rune coordinates
		rune[1].x, rune[1].y = map.tilesToPixels(20, 9)			
		-- Insert blueRune to map
		map.layer["tiles"]:insert(rune[1])	
		-- Only make it visible once when gameStarts
		rune[1].isVisible = true
		coinMachine(coins, map)
	end
	
	if pane == "U" then
		-- Assign rune coordinates
		rune[2].x, rune[2].y = map.tilesToPixels(38, 9)		
		-- Insert greenRune to map
		map.layer["tiles"]:insert(rune[2])		
		if rune[2].isBodyActive then
			rune[2].isVisible = true
			coinMachine(coins, map)
		end
	end
	
	if pane == "D" then
		-- Assign rune coordinates
		rune[3].x, rune[3].y = map.tilesToPixels(5, 15)
		-- Insert pinkRune to map
		map.layer["tiles"]:insert(rune[3])
		
		if rune[3].isBodyActive then
			rune[3].isVisible = true
			coinMachine(coins, map)
		end
	end
end

local function destroyObjects() 
end

fifteen.load = load

return fifteen