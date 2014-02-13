--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- fourteen.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")

local fourteen = { 
	energyCount = 30
}

local function coinMachine(coins, map)
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
		coinMachine(coins, map)
	end
	
	if pane == "U" then
		coinMachine(coins, map)
	end
	
	if pane == "D" then
		coinMachine(coins, map)
	end
end

local function destroyObjects() 
end

fourteen.load = load

return fourteen