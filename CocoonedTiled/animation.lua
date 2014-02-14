--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- animation.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

spriteOptions = { -- Sprite options for player and finish star
	player = {
		{frames = {9,8,7,6,5,4,3,2,1}, name = "move", time = 500},
		{frames = {1}, name = "still", time = 250}
	},
	energy = {
		{frames = {4,3,2,1}, name = "move", time = 500},
		{frames = {1}, name = "still", time = 250}
	},
	paneSwitch = {
		{frames = {6,5,4,3,2,1}, name = "move", time = 500},
		{frames = {1}, name = "still", time = 250}
	},
	["redAura"] = {
		{frames = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1}, name = "move", time = 1000},
		{frames = {1}, name = "still", time = 250}	
	}
}

objectNames = {
	[1] = "blueAura",
	[2] = "redAura",
	[3] = "greenAura",
	[4] = "moveWall",
	[5] = "blueTotem",
	[6] = "redTotem",
	[7] = "greenTotem",
	[8] = "switch",
	[9] = "switchWall"
}


		--TODO: add option for wolf
