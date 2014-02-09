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
		
		coin = {
			{frames = {4,3,2,1}, name = "move", time = 500},
			{frames = {1}, name = "still", time = 250}
		}
}
