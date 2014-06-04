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
-- Updated by: Andrew
--------------------------------------------------------------------------------
local animation = {
	-- Load sprite animation parameters
	spriteOptions = { 
		player = {
			{frames = {1,2,3,4,5,6,7,8,9,10}, name = "move", time = 500},
			--{frames = {20,19,18,17,16,15,14,13,12,11,10}, name = "shrink", time = 500},
			{frames = {1}, name = "still", time = 250}
		},
		player2 = {
			{frames = {1,2,3,4,5,6,7,8,9}, name = "move", time = 500},
			{frames = {1}, name = "still", time = 250}
		},
		energy = {
			{frames = {4,3,2,1}, name = "move", time = 500},
			{frames = {1}, name = "still", time = 250}
		},
		--paneSwitch = {
		--	{frames = {6,5,4,3,2,1}, name = "move", time = 500},
		--	{frames = {1}, name = "still", time = 250, loopCount = 1}
		--},
		wolf = {
				{frames = {8,7,6,5,4,3,2,1}, name = "move", time = 500},
				{frames = {1}, name = "still", time = 250}
			},
		paneSwitch = {
			{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, name = "move", time = 900},
			{frames = {1}, name = "stop", time = 250, loopCount = 1}
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
			{frames = {9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6, 7, 8, 9}, name = "move", time = 2000}, 
			{frames = {1}, name = "still", time = 250}
		},
		["worldPortal"] = {
			{frames = {9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6, 7, 8, 9}, name = "move", time = 850}, 
			{frames = {1}, name = "still", time = 250}
		},
		["wolf"] = {
			{frames = {1,2,3,4,5,6,7,8}, name = "move", time = 600},
			{frames = {1}, name = "still", time = 250}
		},
		["fish1"] = {
			{frames = {1,2,3,4,5}, name = "move", loopCount = 1,time = 300},
			{frames = {9,10,11,12}, name = "still", loopCount = 1, time = 250},
			{frames = {13,14,15,16,17,18,19,1,2,3,4,5,6,7,8}, name = "jumpingin", loopCount = 1, time = 250}
		},
		["fish2"] = {
			{frames = {1,2,3,4,5}, name = "move", loopCount = 1,time = 300},
			{frames = {9,10,11,12}, name = "still", loopCount = 1, time = 250},
			{frames = {13,14,15,16,17,18,19,1,2,3,4,5,6,7,8}, name = "jumpingin", loopCount = 1, time = 250}
		},
		["splash"] = {
			{frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}, name = "move", time = 600, start=1, count=15, loopCount=1},
			{frames = {3}, name = "still", time = 500}
		},
		["fishSplash"] = {
			{frames = {1,2,3,4,5,6,7,8}, name = "move", time = 400, start=1, count=8, loopCount=1},
			{frames = {3}, name = "still", time = 500}
		}
	},

	--------------------------------------------------------------------------------
	-- sheetOptions - holds the sprite sheets for all objects
	--------------------------------------------------------------------------------
	-- Updated by: Marco
	--------------------------------------------------------------------------------
	sheetOptions = {
		playerSheet = graphics.newImageSheet("mapdata/art/animation/AnimationRollSprite.png", 
				   {width = 72, height = 72, sheetContentWidth = 720, sheetContentHeight = 72, numFrames = 10}),
		playerSheet2 = graphics.newImageSheet("mapdata/art/animation/AnimationRollSprite2.png", 
				   {width = 72, height = 72, sheetContentWidth = 648, sheetContentHeight = 72, numFrames = 9}),
		runeSheet = graphics.newImageSheet("mapdata/art/animation/runeAnimation.png", 
					 {width = 72, height = 72, sheetContentWidth = 432, sheetContentHeight = 216, numFrames = 18}),
		shrinkSheet = graphics.newImageSheet("mapdata/art/animation/switchPanesSheet.png", 
					 {width = 72, height = 72, sheetContentWidth = 792, sheetContentHeight = 72, numFrames = 11}),
		deathSheet = graphics.newImageSheet("mapdata/art/animation/screenCrack.png", 
					 {width = 1552, height = 864, sheetContentWidth =3108, sheetContentHeight =1728, numFrames = 4}),
		wolfSheet = graphics.newImageSheet("mapdata/art/animation/wolfSheet.png", 
					 {width = 144, height = 72, sheetContentWidth = 1152, sheetContentHeight = 72, numFrames = 8}),
		paneSheet = graphics.newImageSheet("mapdata/art/animation/snowAnimation.png", 
					 {width = 1440, height = 891, sheetContentWidth = 7200, sheetContentHeight = 4081, numFrames = 20}),
		fish1Sheet = graphics.newImageSheet("mapdata/art/animation/fishspritesheet2.png", 
					 {width = 100, height = 100, sheetContentWidth = 1900, sheetContentHeight = 100, numFrames = 19}),
		fish2Sheet = graphics.newImageSheet("mapdata/art/animation/fishspritesheet2.png", 
					 {width = 100, height = 100, sheetContentWidth = 1900, sheetContentHeight = 100, numFrames = 19}),
		splashSheet = graphics.newImageSheet("mapdata/art/animation/splashSheet.png", 
					 {width = 400, height = 329, sheetContentWidth = 6000, sheetContentHeight = 329, numFrames = 15}),
		fishSplashSheet = graphics.newImageSheet("mapdata/art/animation/fishSplashSheet.png", 
					 {width = 500, height = 266, sheetContentWidth = 4000, sheetContentHeight = 266, numFrames = 8})

	},

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
		[6] = "worldPortal",
		[7] = "fish1",
		[8] = "fish2",
		[9] = "blueTotem",
		[10] = "redTotem",
		[11] = "greenTotem",
		[12] = "switch",
		[13] = "switchWall",
		[14] = "fixedIceberg"
	}
}

return animation