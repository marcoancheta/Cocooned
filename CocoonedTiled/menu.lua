
--------------------------------------------------------------------------------
-- Require Global Variables
--------------------------------------------------------------------------------
local gameData = require("gameData")


--------------------------------------------------------------------------------
-- Creating Main Menu System
--------------------------------------------------------------------------------
function MM(event)
	-- create display group
	menuGroup = display.newGroup()

	-- create backgroung
	mainMenu = display.newImage("graphics/cocooned_bg.png")
	mainMenu.x = 700
	mainMenu.y = 400
	mainMenu:scale(2, 2.5)
	
	-- create play button
	play = display.newImage("graphics/play.png")
	play.name = "playButton"
	play.x = 700
	play.y = 550
	play.anchorX = 0.5
	play.anchorY = 0.5
	play:scale(2, 2)
	
	-- create options button
	options = display.newImage("graphics/options.png")
	options.name = "optionButton"
	options.x = 700
	options.y = 725
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2, 2)
	
	-- add objects to display group
	menuGroup:insert(mainMenu)
	menuGroup:insert(play)
	menuGroup:insert(options)
	
	-- add event listeners
	play:addEventListener("tap", playGame)
	options:addEventListener("tap", optionMenu)
end


--------------------------------------------------------------------------------
-- Play Button Event
--------------------------------------------------------------------------------
function playGame(event)
	if event.target.name == "playButton" then

		-- set global gameStart to true
		gameData.gameStart = true

		-- remove event listeners and display group
		options:removeEventListener("tap", optionMenu)
		play:removeEventListener("tap", playGame)
		menuGroup:removeSelf()
	end
end


--------------------------------------------------------------------------------
-- Options Button Event
--------------------------------------------------------------------------------
function optionMenu(event)
	if event.target.name == "optionButton" then

		-- set global gameStart to false
		gameData.gameStart = false
		print("POOP")

		-- remove event listeners and display group
		options:removeEventListener("tap", optionMenu)
		play:removeEventListener("tap", playGame)
		menuGroup:removeSelf()
	end
end


--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------

local menu = {
	MM = MM,
	playGame = playGame,
	optionMenu = optionMenu
}

return menu