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
--local widget = require("widget")

local menuGroup
local player1, player2 = nil
local groupText = {}

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

local function soundOptions(event)
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
-- Button events - function that holds button functionality
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function buttonPressed(event)
	--[[ Play button pressed ]]--
	if event.target.name == "playButton" then								
		-- Remove menuGroup
		menuGroup:removeSelf()
		menuGroup = nil
		-- User pressed play, set gameActive to true
		gameData.selectLevel = true
		
	--[[ Options button pressed ]]--
	elseif event.target.name == "optionButton" then		
		-- Remove menuGroup
		menuGroup:removeSelf()
		menuGroup = nil
		-- Call to options display
		gameData.inOptions = true
		
	--[[ Back to Main button pressed ]]--
	elseif event.target.name == "BacktoMain" then
		print("Back to Main Menu")
		-- Remove menuGroup		
		menuGroup:removeSelf()
		menuGroup = nil
		-- Go back to menu
		gameData.menuOn = true
		gameData.allowPaneSwitch = false
		gameData.allowMiniMap = false
		gameData.showMiniMap = false
		
	--[[ Back to Main from In-Game button pressed ]]--
	elseif event.target.name == "gotoMain" then
		print("Back to Main Menu")	
		physics.stop()
		
		gameData.menuOn = true		
		gameData.gameEnd = true

	--[[ In game options button pressed ]]--	
	elseif event.target.name == "inGameOptionsBTN" then
		print("In game options")			
		-- Pause physics
		physics.pause()
		gameData.inGameOptions = true	
		
	--[[ Resume In-Game button pressed ]]--
	elseif event.target.name == "Resume" then
		print("Resume game")
		if menuGroup then
			menuGroup:removeSelf()
			menuGroup = nil
		end
				
		physics.start()		
		gameData.resumeGame = true
	--[[ Increase or decrease speed ]]--
	elseif event.target.name == "plusButton" then
		if player1 ~= nil then
			player1.speedConst = player1.speedConst +1
			player1.maxSpeed = player1.maxSpeed +1
			
			if player2.isActive then
				player2.speedConst = player2.speedConst +1
				player2.maxSpeed = player2.maxSpeed +1
			end
			--player's current speed
			groupText[2].text = player1.speedConst		
		end
	elseif event.target.name == "minusButton" then
		if player1 ~= nil then
			player1.speedConst = player1.speedConst -1
			player1.maxSpeed = player1.maxSpeed -1
			
			if player2.isActive then
				player2.speedConst = player2.speedConst -1
				player2.maxSpeed = player2.maxSpeed -1
			end
			--player's current speed
			groupText[2].text = player1.speedConst
		end
	elseif event.target.name == "plusButtonDamping" then
		if player1 ~= nil then
			player1.imageObject.linearDamping = player1.imageObject.linearDamping +.25
			
			if player2.isActive then
				player2.imageObject.linearDamping = player2.imageObject.linearDamping +.25
			end
			--player's linear damping
			groupText[3].text = player1.imageObject.linearDamping
		end
	elseif event.target.name == "minusButtonDamping" then
		if player1 ~= nil then
			player1.imageObject.linearDamping = player1.imageObject.linearDamping -.25
			
			if player2.isActive then
				player2.imageObject.linearDamping = player2.imageObject.linearDamping -.25
			end
			--player's linear damping
			groupText[3].text = player1.imageObject.linearDamping
		end
	end
end

--------------------------------------------------------------------------------
-- Main Menu - function that creates menu System
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function MainMenu(event)
	print("In Main Menu")
	
	-- Create new menu display group
	if menuGroup then
		menuGroup:removeSelf()
		menuGroup = nil
	end
			
	local main = display.newImageRect("mapdata/art/TitleScreen.png", 1425, 900, true)
	local play = display.newImageRect("mapdata/art/buttons/newgame.png", 400, 150, true)
	local options = display.newImageRect("mapdata/art/buttons/options.png", 400, 150, true)
	
	play:setFillColor(123*0.004,215*0.004,203*0.004, 0.8)
	options:setFillColor(123*0.004,215*0.004,203*0.004, 0.8) 
	
	-- Add main menu background image
	main.x = display.contentCenterX
	main.y = display.contentCenterY
		
	-- Add Play button
	play.x = display.contentCenterX
	play.y = display.contentCenterY + 100
	play.name = "playButton"
	
	-- Option buttons: See play button details
	options.x = display.contentCenterX
	options.y = display.contentCenterY + 270
	options.name = "optionButton"
	
	menuGroup = display.newGroup()
	
	-- Insert all images/buttons into group
	menuGroup:insert(main)
	menuGroup:insert(play)
	menuGroup:insert(options)
		
	-- add event listeners for buttons
	play:addEventListener("tap", buttonPressed)
	options:addEventListener("tap", buttonPressed)
end

--------------------------------------------------------------------------------
-- In-Game Options - function that creates inGame options button
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function ingameOptionsbutton(event, map)
	-- Add in-game options image (option_wheel.png)
	local ingameOptions = display.newImage("mapdata/art/buttons/option_wheel.png", 0, 0, true)

	-- Scale image size
	ingameOptions.x, ingameOptions.y = map.tilesToPixels(38, 2)	
	ingameOptions.name = "inGameOptionsBTN"	
	ingameOptions:addEventListener("tap", buttonPressed)
	ingameOptions:toFront()
end

--------------------------------------------------------------------------------
-- Options - function that creates options menu system
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function Options(event)
	print("In Options")
	menuGroup = display.newGroup()
	
	-- Add options background image
	local optionsBG = display.newImageRect("mapdata/art/background/screens/cocooned_menu.png", 
									1425, 900, true)
	optionsBG.x = display.contentCenterX
	optionsBG.y = display.contentCenterY
	
	-- Create onScreen text objects
	local optionText = display.newText("OPTIONS", 350, 150, native.Systemfont, 103)
	optionText:setFillColor(0, 0, 0)
		
	-- Add Main Menu button
	local backtoMain = display.newImageRect("mapdata/art/buttons/main.png", 400, 150, true)
	backtoMain.x = 350
	backtoMain.y = 650
	backtoMain.name = "BacktoMain"	
	
	menuGroup:insert(optionsBG)
	menuGroup:insert(backtoMain)
	menuGroup:insert(optionText)
	
	backtoMain:addEventListener("tap", buttonPressed)
end


--------------------------------------------------------------------------------
-- In-Game Options Menu - function that creates inGame Options Menu
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function ingameMenu(event, player, playerTwo, gui)
	print("ingameMenu")		
	menuGroup = display.newGroup()
	
	-- Add options background image
	local gameOptionsBG = display.newImageRect("mapdata/art/background/screens/cocooned_menu.png", 1425, 900, true)	
		
	local menuObjects = {
		-- Add Main Menu button
		[1] = display.newImageRect("mapdata/art/buttons/main.png", 400, 150, true),
		-- Add Resume game button
		[2] = display.newImageRect("mapdata/art/buttons/resume.png", 400, 150, true),
		-- Minus button	#1
		[3] = display.newImageRect("mapdata/art/buttons/minus.png", 100, 100, true),
		-- Plus button	#1
		[4] = display.newImageRect("mapdata/art/buttons/plus.png", 100, 100, true),
		-- Minus button	#2
		[5] = display.newImageRect("mapdata/art/buttons/minus.png", 100, 100, true),
		-- Pluss button #2
		[6] = display.newImageRect("mapdata/art/buttons/plus.png", 100, 100, true)
	}
	
	groupText = {
		-- Create onScreen text object
		[1] = display.newText("PAUSED", 1155, 100, native.Systemfont, 69),
		--player's current speed
		[2] = display.newText(player.speedConst, 1150, 380, native.Systemfont, 69),
		--player's linear damping
		[3] = display.newText(player.imageObject.linearDamping, 1150, 225, native.Systemfont, 69)
	}
	
	player1 = player
	player2 = playerTwo
	
	gameOptionsBG.x = display.contentCenterX
	gameOptionsBG.y = display.contentCenterY
	gameOptionsBG:scale(-1, 1)		
	
	-- Assign name for runtime functions
	-- Assign position		
	menuObjects[1].name = "gotoMain"
	menuObjects[1].x = display.contentCenterX + 450
	menuObjects[1].y = display.contentCenterY + 150
		
	menuObjects[2].name = "Resume"	
	menuObjects[2].x = display.contentCenterX + 450
	menuObjects[2].y = display.contentCenterY + 300
		
	menuObjects[6].name = "plusButton"
	menuObjects[6].x = display.contentCenterX + 575
	menuObjects[6].y = display.contentCenterY - 20

	menuObjects[5].name = "minusButton"
	menuObjects[5].x = display.contentCenterX + 325
	menuObjects[5].y = display.contentCenterY - 20
	
	menuObjects[4].name = "plusButtonDamping"
	menuObjects[4].x = display.contentCenterX + 575
	menuObjects[4].y = display.contentCenterY - 175

	menuObjects[3].name = "minusButtonDamping"
	menuObjects[3].x = display.contentCenterX + 325
	menuObjects[3].y = display.contentCenterY - 175
	
	menuGroup:insert(gameOptionsBG)
	
	for i=1, #groupText do
		if i >= 2 then
			groupText[i]:setFillColor(0, 0, 0)
		else
			groupText[i]:setFillColor(1, 0, 0)
		end
		-- Add everything to menuGroup
		menuGroup:insert(groupText[i])
	end
			
	for i=1, #menuObjects do
		menuObjects[i].anchorX = 0.5
		menuObjects[i].anchorY = 0.5
		
		-- Add everything to menuGroup
		menuGroup:insert(menuObjects[i])
		-- add event listeners to buttons
		menuObjects[i]:addEventListener("tap", buttonPressed)
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
	ingameMenu = ingameMenu
}

return menu

-- end of menu.lua