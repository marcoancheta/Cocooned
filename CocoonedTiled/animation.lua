--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- animation.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- this lua file holds all sprite animation properties


--------------------------------------------------------------------------------
-- spriteOptions -holds the sequences for each objects (frames and sequence name)
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
spriteOptions = { 
	player = {
		{frames = {9,8,7,6,5,4,3,2,1}, name = "move", time = 500},
		--{frames = {20,19,18,17,16,15,14,13,12,11,10}, name = "shrink", time = 500},
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
		{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18}, name = "move", time = 1500, loopCount = 1},
		{frames = {1}, name = "stop", time = 250}
	},
	shrinkAnimation = {
		{frames = {1,2,3,4,5,6,7,8,9,10,11}, name = "move", time = 750, loopCount = 1},
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
	["blueAura"] = {
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
	},
	["wolf"] = {
		{frames = {1,2,3,4,5,6,7,8}, name = "move", time = 300},
		{frames = {1}, name = "still", time = 250}
	}
}

--------------------------------------------------------------------------------
-- sheetOptions - holds the sprite sheets for all objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
sheetOptions = {
	runeSheet = graphics.newImageSheet("mapdata/art/runeAnimation.png", 
				 {width = 72, height = 72, sheetContentWidth = 432, sheetContentHeight = 216, numFrames = 18}),
	shrinkSheet = graphics.newImageSheet("mapdata/graphics/switchPanesSheet.png", 
				 {width = 72, height = 72, sheetContentWidth = 792, sheetContentHeight = 72, numFrames = 11}),
	deathSheet = graphics.newImageSheet("mapdata/art/screenCrack.png", 
				 {width = 1552, height = 864, sheetContentWidth =3108, sheetContentHeight =1728, numFrames = 4}),
	wolfSheet = graphics.newImageSheet("mapdata/art/woldSheet.png", 
				 {width = 144, height = 72, sheetContentWidth = 1152, sheetContentHeight = 72, numFrames = 8}),

}

--------------------------------------------------------------------------------
-- objectNames - holds the name of all objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
objectNames = {
	[1] = "blueAura",
	[2] = "redAura",
	[3] = "greenAura",
	[4] = "wolf",
	[5] = "exitPortal",
	[6] = "fish1",
	[7] = "fish2",
	[8] = "blueTotem",
	[9] = "redTotem",
	[10] = "greenTotem",
	[11] = "switch",
	[12] = "switchWall"

}

