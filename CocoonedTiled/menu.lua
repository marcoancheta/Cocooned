function MM(event)
	menuGroup = display.newGroup()
	mainMenu = display.newImage("graphics/cocooned_bg.png")
	mainMenu.x = 700
	mainMenu.y = 400
	mainMenu:scale(2, 2.5)
	
	play = display.newImage("graphics/play.png")
	play.name = "playButton"
	play.x = 700
	play.y = 550
	play.anchorX = 0.5
	play.anchorY = 0.5
	play:scale(2, 2)
	
	options = display.newImage("graphics/options.png")
	options.name = "optionButton"
	options.x = 700
	options.y = 725
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2, 2)
	
	menuGroup:insert(mainMenu)
	menuGroup:insert(play)
	menuGroup:insert(options)
	
	play:addEventListener("tap", playGame)
	options:addEventListener("tap", optionMenu)
end

function playGame(event)
	if event.target.name == "playButton" then
		gameActive = true
		play:removeEventListener("tap", playGame)
	end
end

function optionMenu(event)
	if event.target.name == "optionButton" then
		gameActive = false
		print("POOP")
		options:removeEventListener("tap", optionMenu)
	end
end

local menu = {
	MM = MM,
	playGame = playGame,
	optionMenu = optionMenu
}

return menu