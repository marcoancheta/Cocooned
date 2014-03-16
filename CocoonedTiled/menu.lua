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
local player1 = nil

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
-- Main Menu - function that creates menu System
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function MainMenu(event)

	-- Add main menu background image
	main = display.newImage("mapdata/art/TitleScreen.png", 720, 425, true)
		
	-- Scale background image
	main:scale(1.1, 1.1)

	-- Add Play button
	play = display.newImage("mapdata/art/buttons/newgame.png", 0, 0, true)
	play:setFillColor(0.5,0.5,0.5)
	
	-- Assign name for runtime functions
	play.name = "playButton"
	
	-- Play button fixed location and scaled
	play.x = 750
	play.y = 580
	play.anchorX = 0.5
	play.anchorY = 0.5
	play:scale(2.5, 2.5)

	-- Option buttons: See play button details
	options = display.newImage("mapdata/art/buttons/options.png", 0, 0, true)
	options:setFillColor(0.5,0.5,0.5)
	options.name = "optionButton"
	options.x = 750
	options.y = 750
	options.anchorX = 0.5
	options.anchorY = 0.5
	options:scale(2.5, 2.5)
		
	-- Insert all images/buttons into group
	menuGroup:insert(main)
	menuGroup:insert(play)
	menuGroup:insert(options)
		
	-- add event listeners for buttons
	play:addEventListener("tap", buttonPressed)
	options:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- Options - function that creates options menu system
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function Options(event)
	
	-- Add options background image
	optionsBG = display.newImage("mapdata/art/background/screens/cocooned_menu.png", 0, 0, true)
	
	-- Create onScreen text objects
	optionText = display.newText("OPTIONS", 200, 150, native.Systemfont, 72)
	optionText:setFillColor(0, 0, 0)
	
	-- Scale background image
	optionsBG.x = 700
	optionsBG.y = 400
	optionsBG:scale(0.5, 0.5)
	
	-- Add Main Menu button
	backtoMain = display.newImage("mapdata/art/buttons/main.png", 0, 0, true)

	-- Assign name for runtime functions
	backtoMain.name = "BacktoMain"

	-- Add Sound button
	--soundOptions = display.newImage("mapdata/art/buttons/sound.png", 0, 0, true)

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
-- n-Game Options - function that creates inGame options button
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function ingameOptionsbutton(event, player)
	--get player and create a local reference to it for button press function
	player1 = player

	-- Add in-game options image (option_wheel.png)
	ingameOptions = display.newImage("mapdata/art/buttons/option_wheel.png", 0, 0, true)

	-- Scale image size
	ingameOptions.x = 1435
	ingameOptions.y = 60
	ingameOptions:scale(1, 1)
	
	ingameOptions.name = "inGameOptionsBTN"
	
	gui.front:insert(ingameOptions)
	
	ingameOptions:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- In-Game Options Menu - function that creates inGame Options Menu
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function ingameMenu(event, player)
	player1 = player
	print("ingameMenu")
	-- Add options background image
	gameOptionsBG = display.newImage("mapdata/art/background/screens/cocooned_menu.png", 0, 0, true)
	
	-- Create onScreen text object
	ingameOptionText = display.newText("PAUSED", 1155, 100, native.Systemfont, 69)
	ingameOptionText:setFillColor(1, 0, 0)

	--player's current speed
	ingameOptionTextSpeed = display.newText(player1.speedConst, 1150, 380, native.Systemfont, 69)
	ingameOptionTextSpeed:setFillColor(0, 1, 0)
	
	--player's linear damping
	ingameOptionTextDamping = display.newText(player1.imageObject.linearDamping, 1150, 180, native.Systemfont, 69)
	ingameOptionTextDamping:setFillColor(0, 1, 0)

	-- Scale background image
	gameOptionsBG.x = 700
	gameOptionsBG.y = 400
	gameOptionsBG:scale(-0.5, 0.5)
		
	-- Add Main Menu button
	gameMainM = display.newImage("mapdata/art/buttons/main.png", 0, 0, true)
	-- Add Resume game button
	gameResume = display.newImage("mapdata/art/buttons/resume.png", 0, 0, true)
		
	-- Assign name for runtime functions
	gameMainM.name = "gotoMain"
	gameResume.name = "Resume"
	
	-- Main menu button fixed location and scaled
	gameMainM.x = 1050
	gameMainM.y = 720
	gameMainM.anchorX = 0.5
	gameMainM.anchorY = 0.5
	gameMainM:scale(2.5, 2.5)
	
	-- Resume button fixed location and scaled
	gameResume.x = 1050
	gameResume.y = 550
	gameResume.anchorX = 0.5
	gameResume.anchorY = 0.5
	gameResume:scale(2.5, 2.5)

	-- Plus button	
	plus = display.newImage("mapdata/art/buttons/plus.png", 0, 0, true)
	plus:setFillColor(0.5,0.5,0.5)
	plus.name = "plusButton"
	plus.x = 1250
	plus.y = 380
	plus.anchorX = 0.5
	plus.anchorY = 0.5
	plus:scale(.25, .25)

	-- Minus button	
	minus = display.newImage("mapdata/art/buttons/minus.png", 0, 0, true)
	minus:setFillColor(0.5,0.5,0.5)
	minus.name = "minusButton"
	minus.x = 1050
	minus.y = 380
	minus.anchorX = 0.5
	minus.anchorY = 0.5
	minus:scale(.25, .25)

	-- Plus button	
	plusDamping = display.newImage("mapdata/art/buttons/plus.png", 0, 0, true)
	plusDamping:setFillColor(0.5,0.5,0.5)
	plusDamping.name = "plusButtonDamping"
	plusDamping.x = 1250
	plusDamping.y = 180
	plusDamping.anchorX = 0.5
	plusDamping.anchorY = 0.5
	plusDamping:scale(.25, .25)

	-- Minus button	
	minusDamping = display.newImage("mapdata/art/buttons/minus.png", 0, 0, true)
	minusDamping:setFillColor(0.5,0.5,0.5)
	minusDamping.name = "minusButtonDamping"
	minusDamping.x = 1050
	minusDamping.y = 180
	minusDamping.anchorX = 0.5
	minusDamping.anchorY = 0.5
	minusDamping:scale(.25, .25)
	

	gui.front:insert(gameOptionsBG)
	gui.front:insert(gameMainM)
	gui.front:insert(gameResume)
	gui.front:insert(ingameOptionText)
	gui.front:insert(ingameOptionTextSpeed)
	gui.front:insert(plus)
	gui.front:insert(minus)
	gui.front:insert(plusDamping)
	gui.front:insert(minusDamping)
	
	-- add event listeners to buttons
	gameMainM:addEventListener("tap", buttonPressed)
	gameResume:addEventListener("tap", buttonPressed)
	plus:addEventListener("tap", buttonPressed)
	minus:addEventListener("tap", buttonPressed)
	plusDamping:addEventListener("tap", buttonPressed)
	minusDamping:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- Button events - function that holds button functionality
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function buttonPressed(event)
	-----------------------------
	--[[ Play button pressed ]]--
	if event.target.name == "playButton" then
		--print("play button pressed")
		
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
		--print("options button pressed")
						
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
		--print("Back to Main Menu")
		
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

		--print("In game options")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
	
		-- Pause physics
		physics.pause()
	
		gui.front:remove(ingameOptions)
	
		gameData.inGameOptions = true
		
	--------------------------------------------------
	--[[ Back to Main from In-Game button pressed ]]--
	elseif event.target.name == "gotoMain" then
		--print("Back to Main Menu")
				
		-- Play Sound
		sound.playSound(event, sound.clickSound)

		gameData.gameEnd = true
		gameData.menuOn = true

	---------------------------------------
	--[[ Resume In-Game button pressed ]]--
	elseif event.target.name == "Resume" then
		--print("Resume game")
		
		-- Play Sound
		sound.playSound(event, sound.clickSound)
		
		gui.front:remove(ingameOptionText)
		ingameOptionTextSpeed:removeSelf()
		ingameOptionTextDamping:removeSelf()
		gui.front:remove(gameOptionsBG)
		gui.front:remove(gameMainM)
		gui.front:remove(gameResume)
		gui.front:remove(plus)
		gui.front:remove(minus)
		gui.front:remove(plusDamping)
		gui.front:remove(minusDamping)

		physics.start()
		
		gameData.resumeGame = true
	---------------------------------------
	--[[ Increase or decrease speed ]]--
	elseif event.target.name == "plusButton" then
		if player1 ~= nil then
			ingameOptionTextSpeed:removeSelf()
			player1.speedConst = player1.speedConst +1
			player1.maxSpeed = player1.maxSpeed +1
			--player's current speed
			ingameOptionTextSpeed = display.newText(player1.speedConst, 1150, 380, native.Systemfont, 69)
			ingameOptionTextSpeed:setFillColor(0, 1, 0)
			gui.front:insert(ingameOptionTextSpeed)			
		end
	elseif event.target.name == "minusButton" then
		if player1 ~= nil then
			ingameOptionTextSpeed:removeSelf()
			player1.speedConst = player1.speedConst -1
			player1.maxSpeed = player1.maxSpeed -1
			--player's current speed
			ingameOptionTextSpeed = display.newText(player1.speedConst, 1150, 380, native.Systemfont, 69)
			ingameOptionTextSpeed:setFillColor(0, 1, 0)
			gui.front:insert(ingameOptionTextSpeed)
		end
	elseif event.target.name == "plusButtonDamping" then
		if player1 ~= nil then
			ingameOptionTextDamping:removeSelf()
			player1.imageObject.linearDamping = player1.imageObject.linearDamping +.25
			--player's linear damping
			ingameOptionTextDamping = display.newText(player1.imageObject.linearDamping, 1150, 180, native.Systemfont, 69)
			ingameOptionTextDamping:setFillColor(0, 1, 0)
			gui.front:insert(ingameOptionTextDamping)			
		end
	elseif event.target.name == "minusButtonDamping" then
		if player1 ~= nil then
			ingameOptionTextDamping:removeSelf()
			player1.imageObject.linearDamping = player1.imageObject.linearDamping -.25
			--player's linear damping
			ingameOptionTextDamping = display.newText(player1.imageObject.linearDamping, 1150, 180, native.Systemfont, 69)
			ingameOptionTextDamping:setFillColor(0, 1, 0)
			gui.front:insert(ingameOptionTextDamping)
		end
	end
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Marco
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

-- end of menu.lua