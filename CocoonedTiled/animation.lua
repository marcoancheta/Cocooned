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
		{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, name = "move", time = 900},
		{frames = {1}, name = "stop", time = 250}
	},
	runeAnimation = {	
		{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18}, name = "move", time = 1000, loopCount = 1},
		{frames = {1}, name = "stop", time = 250}
	},
	deathAnimation = {
		{frames = {1,2,3,4}, name = "move", time = 5500, loopCount = 1},
	},
	["redAura"] = {
		{frames = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1}, name = "move", time = 780},
		{frames = {1}, name = "still", time = 10}	
	},
	["greenAura"] = {
		{frames = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1}, name = "move", time = 780},
		{frames = {1}, name = "still", time = 10}	
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

sheetOptions = {
	runeSheet = graphics.newImageSheet("mapdata/art/runeAnimation.png", 
				 {width = 72, height = 72, sheetContentWidth = 432, sheetContentHeight = 216, numFrames = 18}),
	deathSheet = graphics.newImageSheet("mapdata/art/screenCrack.png", 
				 {width = 1440, height = 864, sheetContentWidth =2886, sheetContentHeight =1734, numFrames = 4})

}


objectNames = {
	[1] = "blueAura",
	[2] = "redAura",
	[3] = "greenAura",
	[4] = "exitPortal",
	[5] = "fish1",
	[6] = "fish2",
	[7] = "blueTotem",
	[8] = "redTotem",
	[9] = "greenTotem",
	[10] = "switch",
	[11] = "switchWall"

}


		--TODO: add option for wolf
