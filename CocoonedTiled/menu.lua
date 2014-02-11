--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- menu.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Load in Global Variables
--------------------------------------------------------------------------------
local gameData = require("gameData")
local sound = require("sound")
local widget = require("widget")

-- Create new menu display group
menuGroup = display.newGroup()
-- Create options group
optionsGroup = display.newGroup()
-- Create in-game options group
ingameOptionsGroup = display.newGroup()


--------------------------------------------------------------------------------
-- Create Sound Options system
--------------------------------------------------------------------------------
--[[
local function onSwitchPress(event)
	switch = event.target
	print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	if switch.isOn then
		gameData.BGM = true
		print(gameData.BGM)
	elseif switch.isOn == false then
		gameData.BGM = false
		print(gameData.BGM)
	end
end

function soundOptions(event)
	-- Create the widget
	local onOffSwitch = widget.newSwitch
	{
		left = 250,
		top = 200,
		style = "onOff",
		id = "onOffSwitch",
		isOn=true, 
		isAnimated=true,
		onPress = onSwitchPress
	}
end
]]--

--------------------------------------------------------------------------------
-- Create Main Menu System
--------------------------------------------------------------------------------
function MainMenu(event)

	-- Add main menu background image
	main = display.newImage("graphics/cocooned.png", 700, 400, true)
		
	-- Scale background image
	main:scale(0.5, 0.5)

	-- Add Play button
	play = display.newImage("graphics/play.png", 0, 0, true)
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
	options = display.newImage("graphics/options.png", 0, 0, true)
	options:setFillColor(0.5,0.5,0.5)
	options.name = "optionButton"
	options.x = 350
	options.y = 750
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2.5, 2.5)
	
	-- Insert all images/buttons into group
	menuGroup:insert(main)
	menuGroup:insert(play)
	menuGroup:insert(options)
		
	play:addEventListener("tap", buttonPressed)
	options:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- Create Options System
--------------------------------------------------------------------------------
function Options(event)
	
	-- Add options background image
	optionsBG = display.newImage("graphics/cocooned_menu.png", 0, 0, true)
	
	-- Create onScreen text objects
	optionText = display.newText("OPTIONS", 200, 150, native.Systemfont, 72)
	optionText:setFillColor(0, 0, 0)
	
	-- Scale background image
	optionsBG.x = 700
	optionsBG.y = 400
	optionsBG:scale(0.5, 0.5)
	
	-- Add Main Menu button
	backtoMain = display.newImage("graphics/main.png", 0, 0, true)

	-- Assign name for runtime functions
	backtoMain.name = "BacktoMain"

	-- Add Sound button
	--soundOptions = display.newImage("graphics/sound.png", 0, 0, true)

	-- Assign name for runtime functions
	--soundOptions.name = "soundOptions"
	
	-- Main menu button fixed location and scaled
	backtoMain.x = 350
	backtoMain.y = 650
	backtoMain.anchorX = 0.5
	backtoMain.anchorY = 0.5
	backtoMain:scale(2.5, 2.5)

	--[[ Sound options location
	soundOptions.x = 1000
	soundOptions.y = 650
	soundOptions.anchorX = 0.5
	soundOptions.anchorY = 0.5
	soundOptions:scale(2.5, 2.5)
	--]]
	
	optionsGroup:insert(optionsBG)
	optionsGroup:insert(backtoMain)
	--optionsGroup:insert(soundOptions)
	optionsGroup:insert(optionText)
	
	backtoMain:addEventListener("tap", buttonPressed)
	--soundOptions:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- Create In-Game Options System
--------------------------------------------------------------------------------
function ingameOptionsbutton(event)
	
	-- Add in-game options image (option_wheel.png)
	ingameOptions = display.newImage("graphics/option_wheel.png", 0, 0, true)
	
	-- Scale image size
	ingameOptions.x = 1435
	ingameOptions.y = 60
	ingameOptions:scale(1, 1)
	
	ingameOptions.name = "inGameOptionsBTN"
	
	gui.front:insert(ingameOptions)
	
	ingameOptions:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- In-Game Options Menu
--------------------------------------------------------------------------------
function ingameMenu(event)
	
	print("ingameMenu")
	-- Add options background image
	gameOptionsBG = display.newImage("graphics/cocooned_menu.png", 0, 0, true)
	
	-- Create onScreen text object
	ingameOptionText = display.newText("PAUSED", 1155, 100, native.Systemfont, 69)
	ingameOptionText:setFillColor(1, 0, 0)
	
	-- Scale background image
	gameOptionsBG.x = 700
	gameOptionsBG.y = 400
	gameOptionsBG:scale(-0.5, 0.5)
		
	-- Add Main Menu button
	gameMainM = display.newImage("graphics/main.png", 0, 0, true)
	-- Add Resume game button
	gameResume = display.newImage("graphics/resume.png", 0, 0, true)
		
	-- Assign name for runtime functions
	gameMainM.name = "gotoMain"
	gameResume.name = "Resume"
	
	-- Main menu button fixed location and scaled
	gameMainM.x = 1050
	gameMainM.y = 720
	gameMainM.anchorX = 0.5
	gameMainM.anchorY = 0.5
	gameMainM:scale(2.5, 2.5)
	
	gameResume.x = 1050
	gameResume.y = 550
	gameResume.anchorX = 0.5
	gameResume.anchorY = 0.5
	gameResume:scale(2.5, 2.5)
	
	gui.front:insert(gameOptionsBG)
	gui.front:insert(gameMainM)
	gui.front:insert(gameResume)
	gui.front:insert(ingameOptionText)
	
	gameMainM:addEventListener("tap", buttonPressed)
	gameResume:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- Button events
--------------------------------------------------------------------------------
function buttonPressed(event)
	-----------------------------
	--[[ Play button pressed ]]--
	if event.target.name == "playButton" then
		print("play button pressed")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
								
		-- Remove menuGroup
		play:removeEventListener("tap", buttonPressed)
		options:removeEventListener("tap", buttonPressed)
		menuGroup:remove(main)
		menuGroup:remove(play)
		menuGroup:remove(options)
		
		physics.start()
		physics.setGravity(0, 0)
		
		-- User pressed play, set gameActive to true
		gameData.selectLevel = true
		--gameData.gameStart = true
		gameData.inGameOptions = false

		
	
	--------------------------------
	--[[ Options button pressed ]]--
	elseif event.target.name == "optionButton" then
		print("options button pressed")
						
		-- Play Sound
		sound.playSound(event, sound.clickSound)
						
		-- Remove menuGroup
		play:removeEventListener("tap", buttonPressed)
		options:removeEventListener("tap", buttonPressed)
		menuGroup:remove(main)
		menuGroup:remove(play)
		menuGroup:remove(options)
		
		-- Call to options display
		gameData.inOptions = true

	-------------------------------------
	--[[ Back to Main button pressed ]]--
	elseif event.target.name == "BacktoMain" then
		print("Back to Main Menu")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
		
		-- Remove optionsGroup
		--optionsGroup:removeSelf()
		--backtoMain:removeEventListener("tap", buttonPressed)
		if optionsGroup then
			optionsGroup:remove(optionsBG)
			optionsGroup:remove(backtoMain)
			--optionsGroup:remove(soundOptions)
			optionsGroup:remove(optionText)
		end
		gameData.menuOn = true

		-------------------------------------
	--[[ Sound button pressed ]]--
	--[[
	elseif event.target.name == "soundOptions" then
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
		
		-- Remove optionsGroup
		--optionsGroup:removeSelf()
		--backtoMain:removeEventListener("tap", buttonPressed)
		if optionsGroup then
			optionsGroup:remove(optionsBG)
			optionsGroup:remove(soundOptions)
			optionsGroup:remove(backToMain)
			optionsGroup:remove(optionText)
		end
		
		gameData.menuOn = true
	]]--	
	----------------------------------------
	--[[ In game options button pressed ]]--	
	elseif event.target.name == "inGameOptionsBTN" then

		print("In game options")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
	
		-- Pause physics
		physics.pause()
	
		gui.front:remove(ingameOptions)
	
		gameData.inGameOptions = true
		
	--------------------------------------------------
	--[[ Back to Main from In-Game button pressed ]]--
	elseif event.target.name == "gotoMain" then
		print("Back to Main Menu")
				
		-- Play Sound
		sound.playSound(event, sound.clickSound)

		gameData.gameEnd = true
		gameData.menuOn = true

	---------------------------------------
	--[[ Resume In-Game button pressed ]]--
	elseif event.target.name == "Resume" then
		print("Resume game")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
		
		gui.front:remove(ingameOptionText)
		gui.front:remove(gameOptionsBG)
		gui.front:remove(gameMainM)
		gui.front:remove(gameResume)

		physics.start()
		
		gameData.resumeGame = true
	end
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
local menu = {
	--soundOptions = soundOptions,
	MainMenu = MainMenu,
	Options = Options,
	ingameOptionsbutton = ingameOptionsbutton,
	ingameMenu = ingameMenu,
	buttonPressed = buttonPressed
}

return menu
