--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- menu.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function MM(event)
	-- Create new menu group
	menuGroup = display.newGroup()
	
	-- Add main menu background image
	mainMenu = display.newImage("graphics/cocooned_bg.png")
	
	-- Scale background image
	mainMenu.x = 700
	mainMenu.y = 400
	mainMenu:scale(1.9, 2.5)
	
	-- Add Play button
	play = display.newImage("graphics/play.png")
	
	-- Assign name for runtime functions
	play.name = "playButton"
	
	-- Play button fixed location and scaled
	play.x = 700
	play.y = 550
	play.anchorX = 0.5
	play.anchorY = 0.5
	play:scale(2, 2)
	
	-- Option buttons: See play button details
	options = display.newImage("graphics/options.png")
	options.name = "optionButton"
	options.x = 700
	options.y = 725
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2, 2)
	
	-- Insert all images/buttons into group
	menuGroup:insert(mainMenu)
	menuGroup:insert(play)
	menuGroup:insert(options)
	
	-- Add listeners for click detection
	play:addEventListener("tap", playGame)
	options:addEventListener("tap", optionMenu)
end

-- When play button is clicked, do:
function playGame(event)
	if event.target.name == "playButton" then
		play:removeEventListener("tap", playGame)
		gameActive = true
	end
end

-- When option button is clicked, do:
function optionMenu(event)
	if event.target.name == "optionButton" then
		options:removeEventListener("tap", optionMenu)
		gameActive = false
	end
end

local menu = {
	MM = MM,
	playGame = playGame,
	optionMenu = optionMenu
}

return menu