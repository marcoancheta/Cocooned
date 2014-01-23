
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
local sound = require("sound")
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
	ingameOptionsGroup = display.newGroup()
	
	-- Add in-game options image (option_wheel.png)
	ingameOptions = display.newImage("graphics/option_wheel.png")
	
	-- Scale image size
	ingameOptions.x = 1435
	ingameOptions.y = 60
	ingameOptions:scale(1, 1)
	
	ingameOptions.name = "igo"
	
	gui:insert(ingameOptions)
	
	ingameOptions:addEventListener("tap", gametoOptions)
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
-- Options Button Event
--------------------------------------------------------------------------------
function gameO(event, gui)

	-- Create options group
	gameOptionsGroup = display.newGroup()
	
	-- Add options background image
	gameOptionsBG = display.newImage("graphics/cocooned_bg.png")
	
	-- Scale background image
	gameOptionsBG.x = 700
	gameOptionsBG.y = 470
	gameOptionsBG:scale(2, 3)
	gameOptionsBG:rotate(180)
		
	-- Add Main Menu button
	gameMainM = display.newImage("graphics/main.png")
	-- Add Resume game button
	gameResume = display.newImage("graphics/resume.png")
		
	-- Assign name for runtime functions
	gameMainM.name = "BacktoMain"
	gameResume.name = "resume"
	
	-- Main menu button fixed location and scaled
	gameMainM.x = 700
	gameMainM.y = 650
	gameMainM.anchorX = 0.5
	gameMainM.anchorY = 0.5
	gameMainM:scale(2, 2)
	
	gameResume.x = 700
	gameResume.y = 500
	gameResume.anchorX = 0.5
	gameResume.anchorY = 0.5
	gameResume:scale(2, 2)
	
	gameOptionsGroup:insert(gameOptionsBG)
	gameOptionsGroup:insert(gameMainM)
	gameOptionsGroup:insert(gameResume)
	
	gameMainM:addEventListener("tap", backtoMain)
	gameResume:addEventListener("tap", resumeGame)
end


--------------------------------------------------------------------------------
-- Play Button Event
--------------------------------------------------------------------------------

-- When play button is clicked, do:
function playGame(event)
	if event.target.name == "playButton" then
		print("play")
		
		-- Play Sound
		sound.playSound(event, sound.mainmenuSound)
				
		-- Remove listeners and group objects
		gameData.ingame = true
		
		-- User pressed play, set gameActive to true
		gameData.gameStart = true
		gameData.inOptions = false
		
		-- Remove display group
		menuGroup:removeSelf()
	end
end


--------------------------------------------------------------------------------
-- Option Menu Button Event
--------------------------------------------------------------------------------

-- When option button is clicked, do:
function optionMenu(event)
	if event.target.name == "optionButton" then
		print("options")
		
		-- Remove listeners and group objects
		display.remove(menuGroup)
				
		-- Play Sound
		sound.playSound(event, sound.mainmenuSound)
		
		-- Call to options display
		O(event)
	end
end

--------------------------------------------------------------------------------
-- In-Game Option Menu Button Event
--------------------------------------------------------------------------------

-- When in-game option button is clicked, do:
function gametoOptions(event)
	if event.target.name == "igo" then	
		print("ingame options open")
		
		-- Play Sound
		sound.playSound(event, sound.mainmenuSound)
		
		-- Pause physics, mechanics, etc.
		physics.pause()
		gameData.inOptions = true
		
		-- go to game options
		gameO(event)
		
		-- Remove display objects and event listeners
		ingameOptions:removeEventListener("tap", gametoOptions)
		ingameOptionsGroup:removeSelf()
	end
end

--------------------------------------------------------------------------------
-- In-Game Option Choices Event
--------------------------------------------------------------------------------

-- When resume game button is clicked, do:
function resumeGame(event)
	if event.target.name == "resume" then
		print("Return to game")
				
		-- Re-add option menu button and listeners
		ingameO(event)
		
		-- Play Sound
		sound.playSound(event, sound.mainmenuSound)
		
		-- Resume physics
		physics.start()
		
		--gameData.ingame = true
		gameData.inOptions = false
		gameData.showMiniMap = true
	
		-- Remove everything in in-game option menu
		if gameOptionsGroup then
			display.remove(gameOptionsGroup)
		end
	end
end

-- also used in main menu options
-- When back to main menu button is clicked, do:
function backtoMain(event)
	if event.target.name == "BacktoMain" then
		print("back to main menu")
				
		if gameData.ingame then
			display.remove(optionsGroup)
			gui:removeSelf()
		end
		
		-- Play Sound
		sound.playSound(event, sound.mainmenuSound)
		
		-- Callback to main menu display
		MM(event)
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
	gametoOptions = gametoOptions,
	ingame = ingame,
	resumeGame = resumeGame,
	gameO = gameO
}

return menu