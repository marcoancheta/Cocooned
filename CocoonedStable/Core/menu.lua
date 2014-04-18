--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- menu.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Load in Global Variables
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")
local sound = require("sounds.sound")
local generate = require("Loading.generateObjects")
--local widget = require("widget")

local menuGroup
--local player1, player2 = nil

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
-- Updated by: Derrick
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
		menuGroup:removeSelf()
		menuGroup = nil
		gameData.resumeGame = true
		
	--[[ Increase or decrease speed ]]--
	elseif event.target.name == "plusButton" then
		--[[
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
		]]--
	elseif event.target.name == "minusButton" then
		--[[
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
		]]--
	elseif event.target.name == "plusButtonDamping" then
		--[[
		if player1 ~= nil then
			player1.imageObject.linearDamping = player1.imageObject.linearDamping +.25
			
			if player2.isActive then
				player2.imageObject.linearDamping = player2.imageObject.linearDamping +.25
			end
			--player's linear damping
			groupText[3].text = player1.imageObject.linearDamping
		end
		]]--
	elseif event.target.name == "minusButtonDamping" then
		--[[
		if player1 ~= nil then
			player1.imageObject.linearDamping = player1.imageObject.linearDamping -.25
			
			if player2.isActive then
				player2.imageObject.linearDamping = player2.imageObject.linearDamping -.25
			end
			--player's linear damping
			groupText[3].text = player1.imageObject.linearDamping
		end
		]]--
	end
end

--------------------------------------------------------------------------------
-- Main Menu - function that creates menu System
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function mainMenu(event)
	print("In Main Menu")
	
	-- Create new menu display group
	if menuGroup then
		menuGroup:removeSelf()
		menuGroup = nil
	else
		menuGroup = display.newGroup()
	end
	
	local menuObjects = {
		-- Add main menu background image
		[1] = display.newImageRect("mapdata/art/TitleScreen.png", 1425, 900),
		-- Add Play button
		[2] = display.newImageRect("mapdata/art/buttons/newgame.png", 400, 150),
		-- Option buttons: See play button details
		[3] = display.newImageRect("mapdata/art/buttons/options.png", 400, 150)
	}
		
	for i=1, #menuObjects do
		menuObjects[i].x = display.contentCenterX
		
		if i==1 then
			-- buttons[1] is not a menu button, it is a background
			menuObjects[1].y = display.contentCenterY
		elseif i==2 then
			menuObjects[i].y = display.contentCenterY + 100
			menuObjects[i].name = "playButton"
			menuObjects[i]:setFillColor(123*0.004,215*0.004,203*0.004, 0.8) 
			-- add event listener
			menuObjects[i]:addEventListener("tap", buttonPressed)
		elseif i==3 then
			menuObjects[i].y = display.contentCenterY + 270
			menuObjects[i].name = "optionButton"
			menuObjects[i]:setFillColor(123*0.004,215*0.004,203*0.004, 0.8) 
			-- add event listener
			menuObjects[i]:addEventListener("tap", buttonPressed)
		end
		
		menuGroup:insert(menuObjects[i])
	end
end

--------------------------------------------------------------------------------
-- Options - function that creates options menu system
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function options(event)
	print("In Options")
	
	-- Create new menu display group
	if menuGroup then
		menuGroup:removeSelf()
		menuGroup = nil
	else
		menuGroup = display.newGroup()
	end
	
	local menuObjects = {
		-- Add options background image
		[1] = display.newImageRect("mapdata/art/background/screens/cocooned_menu.png", 1425, 900),
		-- Add Main Menu button
		[2] = display.newImageRect("mapdata/art/buttons/main.png", 400, 150),
		-- Create onScreen text objects
		[3] = display.newText("OPTIONS", 350, 150, native.Systemfont, 103)
	}
		
	for i=1, #menuObjects do
		if i==1 then
			menuObjects[i].x = display.contentCenterX
			menuObjects[i].y = display.contentCenterY
		elseif i==2 then
			menuObjects[i].x = display.contentCenterX - 325
			menuObjects[i].y = display.contentCenterY + 150
			menuObjects[i].name = "BacktoMain"
			menuObjects[i]:addEventListener("tap", buttonPressed)
		elseif i==3 then
			menuObjects[i]:setFillColor(0, 0, 0)
		end
		
		menuGroup:insert(menuObjects[i])
	end
end

--------------------------------------------------------------------------------
-- In-Game Options - function that creates inGame options button
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function ingameOptionsbutton(event, map)
	local cX = display.contentCenterX
	local cY = display.contentCenterY

	-- Add in-game options image (option_wheel.png)
	local ingameOptions = display.newImage("mapdata/art/buttons/option_wheel.png", 0, 0, true)

	-- Scale image size
	ingameOptions.x = cX + 650
	ingameOptions.y = cY - 350
	ingameOptions.name = "inGameOptionsBTN"	
	ingameOptions:addEventListener("tap", buttonPressed)
	ingameOptions:toFront()
end


--------------------------------------------------------------------------------
-- In-Game Options Menu - function that creates inGame Options Menu
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
--local function ingameMenu(event, player, playerTwo, gui)
local function ingameMenu(event, gui)
	print("ingameMenu")		
	
	-- Create new menu display group
	if menuGroup then
		menuGroup:removeSelf()
		menuGroup = nil
	else
		menuGroup = display.newGroup()
	end
	
	--player1 = player
	--player2 = playerTwo
	
	local menuNames = {
		[1] = "gotoMain",
		[2] = "Resume",
		[3] = "minusButtonDamping",
		[4] = "plusButtonDamping",
		[5] = "minusButton",
		[6] = "plusButton"
	}
	
	local menuObjects = {
		-- Add options background image
		[1] = display.newImageRect("mapdata/art/background/screens/cocooned_menu.png", 1425, 900),
		-- Add Main Menu button
		[2] = display.newImageRect("mapdata/art/buttons/main.png", 400, 150),
		-- Add Resume game button
		[3] = display.newImageRect("mapdata/art/buttons/resume.png", 400, 150),
		-- Minus button	#1
		[4] = display.newImageRect("mapdata/art/buttons/minus.png", 100, 100),
		-- Plus button	#1
		[5] = display.newImageRect("mapdata/art/buttons/plus.png", 100, 100),
		-- Minus button	#2
		[6] = display.newImageRect("mapdata/art/buttons/minus.png", 100, 100),
		-- Pluss button #2
		[7] = display.newImageRect("mapdata/art/buttons/plus.png", 100, 100)
	}
	
	-- Create onScreen text object
	local groupText = {
		[1] = display.newText("PAUSED", 1155, 100, native.Systemfont, 69),
		--player's current speed
		--[2] = display.newText(player.speedConst, 1150, 380, native.Systemfont, 69)
		--player's linear damping
		--[3] = display.newText(player.imageObject.linearDamping, 1150, 225, native.Systemfont, 69)
	}	
		
	for i=1, #groupText do
		if i >= 2 then
			groupText[i]:setFillColor(0, 0, 0)
		else
			groupText[i]:setFillColor(1, 0, 0)
		end
		-- Add everything to menuGroup
		menuGroup:insert(groupText[i])
	end
	
	-- Assign position		
	menuObjects[1].x = display.contentCenterX
	menuObjects[1].y = display.contentCenterY	
	menuObjects[2].x = display.contentCenterX + 450
	menuObjects[2].y = display.contentCenterY + 150		
	menuObjects[3].x = display.contentCenterX + 450
	menuObjects[3].y = display.contentCenterY + 300	
	menuObjects[4].x = display.contentCenterX + 325
	menuObjects[4].y = display.contentCenterY - 175	
	menuObjects[5].x = display.contentCenterX + 575
	menuObjects[5].y = display.contentCenterY - 175
	menuObjects[6].x = display.contentCenterX + 325
	menuObjects[6].y = display.contentCenterY - 20		
	menuObjects[7].x = display.contentCenterX + 575
	menuObjects[7].y = display.contentCenterY - 20	
	
	-- Flip background image (horizontal)
	menuObjects[1]:scale(-1, 1)
				
	for i=1, #menuObjects do
		-- Assign name for runtime functions
		menuObjects[i].name = menuNames[i]
		menuObjects[i].anchorX = 0.5
		menuObjects[i].anchorY = 0.5
		
		-- add event listeners to buttons
		menuObjects[i]:addEventListener("tap", buttonPressed)
		-- Add everything to menuGroup
		menuGroup:insert(menuObjects[i])
	end
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local menu = {
	--soundOptions = soundOptions,
	mainMenu = mainMenu,
	options = options,
	ingameOptionsbutton = ingameOptionsbutton,
	ingameMenu = ingameMenu
}

return menu
-- end of menu.lua