
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- menu.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Require Global Variables
--------------------------------------------------------------------------------
local gameData = require("gameData")
local ingame = false

--------------------------------------------------------------------------------
-- Creating Main Menu System
--------------------------------------------------------------------------------
function MM(event)

	ingame = false

	-- Create new menu group
	menuGroup = display.newGroup()
	
	-- Add main menu background image
	mainMenu = display.newImage("graphics/SILHOUETTE1.png")
	
	-- Scale background image
	mainMenu.x = 700
	mainMenu.y = 400
	mainMenu:scale(0.5, 0.5)

	-- Add Play button
	play = display.newImage("graphics/play.png")
	play:setFillColor(0.5,0.5,0.5)
	
	-- Assign name for runtime functions
	play.name = "playButton"
	
	-- Play button fixed location and scaled
	play.x = 350
	play.y = 580
	play.anchorX = 0.5
	play.anchorY = 0.5
	play:scale(2.5, 2.5)

	-- Option buttons: See play button details
	options = display.newImage("graphics/options.png")
	options:setFillColor(0.5,0.5,0.5)
	options.name = "optionButton"
	options.x = 350
	options.y = 750
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2.5, 2.5)
	
	-- Insert all images/buttons into group
	menuGroup:insert(mainMenu)
	menuGroup:insert(play)
	menuGroup:insert(options)
	
	-- Add listeners for click detection
	play:addEventListener("tap", playGame)
	options:addEventListener("tap", optionMenu)
end

--------------------------------------------------------------------------------
-- In-Game Options Button Event
--------------------------------------------------------------------------------
function ingameO(event)
	
	-- Create in-game options group
	igoptionsGroup = display.newGroup()
	
	-- Add in-game options image (option_wheel.png)
	igoptions = display.newImage("graphics/option_wheel.png")
	
	-- Scale image size
	igoptions.x = 1435
	igoptions.y = 60
	igoptions:scale(1, 1)
	
	igoptions.name = "igo"
	
	igoptionsGroup:insert(igoptions)
	
	igoptions:addEventListener("tap", gametoOptions)
	
end


--------------------------------------------------------------------------------
-- Options Button Event
--------------------------------------------------------------------------------
function O(event)

	-- Create options group
	optionsGroup = display.newGroup()
	
	-- Add options background image
	optionsBG = display.newImage("graphics/cocooned_bg.png")
	
	-- Scale background image
	optionsBG.x = 700
	optionsBG.y = 470
	optionsBG:scale(2, 3)
	
	-- Add Main Menu button
	mainM = display.newImage("graphics/main.png")
	
	-- Assign name for runtime functions
	mainM.name = "BacktoMain"
	
	-- Main menu button fixed location and scaled
	mainM.x = 700
	mainM.y = 650
	mainM.anchorX = 0.5
	mainM.anchorY = 0.5
	mainM:scale(2, 2)
	
	optionsGroup:insert(optionsBG)
	optionsGroup:insert(mainM)
	
	mainM:addEventListener("tap", backtoMain)
end


--------------------------------------------------------------------------------
-- Play Button Event
--------------------------------------------------------------------------------

-- When play button is clicked, do:
function playGame(event)
	if event.target.name == "playButton" then
		print("play")
		
		-- Remove listeners and group objects
		--display.remove(menuGroup)
		
		ingame = true
		
		-- User pressed play, set gameActive to true
		gameData.gameStart = true
		
		-- Remove display group
		menuGroup:removeSelf()
	end
end

-- When option button is clicked, do:
function optionMenu(event)
	if event.target.name == "optionButton" then
		print("options")
		
		
		-- Remove listeners and group objects
		display.remove(menuGroup)
				
		-- Make sure gameData.gameOn is still false
		gameData.gameOn = false
		
		-- Call to options display
		O(event)
	end
end

function backtoMain(event)
	if event.target.name == "BacktoMain" then
		display.remove(optionsGroup)
		
		print("back to main menu")
		
		if ingame then
			gui:removeSelf()
		end
		
		-- Callback to main menu display
		MM(event)
	end
end

function gametoOptions(event)
	if event.target.name == "igo" then
		display.remove(igoptionsGroup)
		
		print("ingame options open")
		
		O(event)
		igoptions:removeEventListener("tap", gametoOptions)
	end
end


--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------

local menu = {
	MM = MM,
	playGame = playGame,
	optionMenu = optionMenu,
	backtoMain = backtoMain,
	ingameO = ingameO,
	gametoOptions = gametoOptions
}

return menu