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
	loadWolf = {
			{frames = {8,7,6,5,4,3,2,1}, name = "move", time = 500},
			{frames = {1}, name = "still", time = 250}
		},
	paneSwitch = {
		{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27}, name = "move", time = 1200},
		{frames = {1}, name = "stop", time = 250}
	},
	["redAura"] = {
		{frames = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1}, name = "move", time = 750},
		{frames = {1}, name = "still", time = 10}	
	},
	["greenAura"] = {
		{frames = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1}, name = "move", time = 1000},
		{frames = {1}, name = "still", time = 250}	
	},
	blueGhost = {
		{frames = {8,7,6,5}, name = "move", time = 500},
		{frames = {1}, name = "still", time = 250}
	},
	["exitPortal"] = {
		{frames = {5, 4, 3, 2}, name = "move", time = 500}, 
		{frames = {1}, name = "still", time = 250}
	}
}

objectNames = {
	[1] = "blueAura",
	[2] = "redAura",
	[3] = "greenAura",
	[4] = "exitPortal",
	[5] = "moveWall",
	[6] = "blueTotem",
	[7] = "redTotem",
	[8] = "greenTotem",
	[9] = "switch",
	[10] = "switchWall"

}


		--TODO: add option for wolf
