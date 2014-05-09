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
local sound = require("sound")
local generate = require("Loading.generateObjects")
local widget = require("widget")
local memory = require("memory")
local snow = require("utils.snow")

local menuGroup
--local player1, player2 = nil
-- Create onScreen text object
--[[
local playerText = {
	--player's current speed
	[2] = display.newText(player.speedConst, 1150, 380, native.Systemfont, 69)
	--player's linear damping
	[3] = display.newText(player.imageObject.linearDamping, 1150, 225, native.Systemfont, 69)
}	
]]--

--------------------------------------------------------------------------------
-- Create Sound Options system
--------------------------------------------------------------------------------
local function sfxController(event)
	sound.setVolume(1, event.value)
end

local function bgmController(event)
	sound.setVolume(3, event.value)
end

--------------------------------------------------------------------------------
-- Clean menu system
--------------------------------------------------------------------------------
local function clean()
	menuGroup:removeSelf()
	menuGroup = nil
end

--------------------------------------------------------------------------------
-- Player Accelerometer Controls
--------------------------------------------------------------------------------
--[[
local function playerAC(int)
	if player1 ~= nil then
		player1.imageObject.linearDamping = player1.imageObject.linearDamping + int
			
		if player2.isActive then
			player2.imageObject.linearDamping = player2.imageObject.linearDamping + int
		end
		--player's linear damping
		playerText = display.newText(player1.imageObject.linearDamping, 350, 100, native.Systemfont, 103)
		playerText:setFillColor(0, 0, 0)
		playerText:toFront()
	end
end
]]--


--------------------------------------------------------------------------------
-- Button events - function that holds button functionality
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function buttonPressed(event)
	sound.playSound(sound.soundEffects[1])
	--[[ Play button pressed ]]--
	if event.target.name == "playButton" then
		-- Remove menuGroup
		clean()
		-- User pressed play, set gameActive to true
		gameData.inMainMenu = false
		gameData.selectLevel = true		
	--[[ Options button pressed ]]--
	elseif event.target.name == "optionButton" then	
		-- Remove menuGroup
		clean()
		snow.meltSnow()
		-- Call to options display
		gameData.inMainMenu = false
		gameData.inOptions = true		
	--[[ Back to Main button pressed ]]--
	elseif event.target.name == "BacktoMain" then
		print("Back to Main Menu")
		-- Remove menuGroup		
		clean()
		-- Go back to menu
		gameData.menuOn = true		
	--[[ Debug switch button pressed ]]--
	elseif event.target.name == "debugSwitch" then
		local switch = event.target		
		if switch.isOn then
			gameData.debugMode = true
		else
			gameData.debugMode = false
		end
		memory.toggle()		
	--[[ Back to Main from In-Game button pressed ]]--
	elseif event.target.name == "gotoMain" then
		print("Back to Main Menu")	
		clean()
		gameData.gameEnd = true		
	--[[ In game options button pressed ]]--	
	elseif event.target.name == "inGameOptionsBTN" then
		print("In game options")			
		gameData.inGameOptions = true		
	--[[ Resume In-Game button pressed ]]--
	elseif event.target.name == "Resume" then
		print("Resume game")
		clean()
		gameData.resumeGame = true		
	--[[ Increase or decrease speed ]]--
	--[[
	elseif event.target.name == "plusButton" then
		playerAC(1)
	elseif event.target.name == "minusButton" then
		playerAC(-1)
	elseif event.target.name == "plusButtonDamping" then
		playerAC(.25)
	elseif event.target.name == "minusButtonDamping" then
		playerAC(-.25)
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
	if audio.isChannelPlaying(3) == false then
		print(audio.isChannelPlaying(3))
		sound.loadMenuSounds()
		sound.playBGM(sound.backgroundMusic)
	end
			
	-- Create new menu display group
	menuGroup = display.newGroup()
		
	local menuObjects = {
		-- Add main menu background image
		[1] = display.newImageRect("mapdata/art/TitleScreen.png", 1460, 864),
		-- Add Play button
		--[2] = display.newImageRect("mapdata/art/buttons/newgame.png", 400, 150),
		[2] = display.newCircle(display.contentCenterX - 350, display.contentCenterY + 210, 100 ),
		-- Option buttons: See play button details
		--[3] = display.newImageRect("mapdata/art/buttons/options.png", 400, 150)
		[3] = display.newCircle(display.contentCenterX + 370, display.contentCenterY + 210, 100 )
	}
		
	for i=1, #menuObjects do		
		if i > 1 then
			if i==2 then
				menuObjects[i].name = "playButton"
				--menuObjects[i]:setFillColor(123*0.004,215*0.004,203*0.004, 0.8)
				menuObjects[i]:setFillColor(0,0,0,0.01) 
			elseif i==3 then
				menuObjects[i].name = "optionButton"
				--menuObjects[i]:setFillColor(123*0.004,215*0.004,203*0.004, 0.8)
				menuObjects[i]:setFillColor(0,0,0,0.01) 			
			end			
			-- add event listener for new game and options only
			menuObjects[i]:addEventListener("tap", buttonPressed)
		else
			menuObjects[i].x = display.contentCenterX
			menuObjects[i].y = display.contentCenterY
		end
		
		menuGroup:insert(menuObjects[i])
	end
	
	return menuGroup
end

--------------------------------------------------------------------------------
-- Options - function that creates options menu system
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function options(event)
	print("In Options")
	local sfxVal = (gameData.sfxVolume*10)
	local bgmVal = (gameData.bgmVolume*10)
	
	-- Create new menu display group
	menuGroup = display.newGroup()
	
	local menuObjects = {
		-- Add options background image
		[1] = display.newImageRect("mapdata/art/background/screens/cocoonedMenu.png", 1460, 864),
		-- Add Main Menu button
		[2] = display.newImageRect("mapdata/art/buttons/main.png", 400, 150),
		-- Create onScreen text objects
		[3] = display.newText("OPTIONS", 350, 100, native.Systemfont, 103),
		-- Debug toggle object
		[4] = widget.newSwitch{x = 500, y = display.contentCenterY + 100, 
							   style = "onOff", id = "onOffSwitch", 
							   onPress = buttonPressed},
		-- Debug text
		[5] = display.newText("Debug Mode: ", 350, 150, native.Systemfont, 52),
		-- Sound controller (SFX[6] - BGM[7])
		[6] = widget.newSlider{orientation="horizontal", width=200, value = sfxVal, listener=sfxController},
		[7] = widget.newSlider{orientation="horizontal", width=200, value = bgmVal, listener=bgmController},
		-- Sound text
		[8] = display.newText("SFX Volume: ", 350, 150, native.Systemfont, 52),
		[9] = display.newText("BGM Volume: ", 350, 150, native.Systemfont, 52),
		[10] = display.newText("0                    100", 350, 150, native.Systemfont, 40),
		[11] = display.newText("0                    100", 350, 150, native.Systemfont, 40)
	}
		
	for i=1, #menuObjects do
		if i==1 then
			-- Options background image
			menuObjects[i].x = display.contentCenterX
			menuObjects[i].y = display.contentCenterY
		elseif i==2 then
			-- Main Menu button
			menuObjects[i].x = 325
			menuObjects[i].y = display.contentCenterY + 300
			menuObjects[i].name = "BacktoMain"
			menuObjects[i]:addEventListener("tap", buttonPressed)
			menuObjects[i]:setFillColor(0, 0, 1)
		elseif i==3 then
			-- Options text object
			menuObjects[i]:setFillColor(0, 0, 0)
		elseif i==4 then
			-- Debug toggle object
			if gameData.debugMode then
				menuObjects[i]:setState({isOn = true})
			end		
			menuObjects[i].name = "debugSwitch"
		elseif i==5 then
			-- Debug text
			menuObjects[i].x = 300
			menuObjects[i].y = display.contentCenterY + 100
			menuObjects[i]:setFillColor(0, 0, 0)
		elseif i==6 then
			-- SFX Volume Slider
			menuObjects[i].x = 300
			menuObjects[i].y = display.contentCenterY
		elseif i==7 then
			-- BGM Volume Slider
			menuObjects[i].x = 300
			menuObjects[i].y = display.contentCenterY - 100
		elseif i==8 then
			-- SFX Volume Text
			menuObjects[i].x = 300
			menuObjects[i].y = display.contentCenterY - 50
			menuObjects[i]:setFillColor(0, 0, 0)
		elseif i==9 then
			-- BGM Volume Text
			menuObjects[i].x = 300
			menuObjects[i].y = display.contentCenterY - 150
			menuObjects[i]:setFillColor(0, 0, 0)
		elseif i==10 then
			-- Sound [0-100] Text
			menuObjects[i].x = 320
			menuObjects[i].y = display.contentCenterY - 100
			menuObjects[i]:setFillColor(0, 0, 0)
		elseif i==11 then
			-- Sound [0-100] Text
			menuObjects[i].x = 320
			menuObjects[i].y = display.contentCenterY
			menuObjects[i]:setFillColor(0, 0, 0)
		end
		
		menuGroup:insert(menuObjects[i])
	end
	
	return menuGroup
end

--------------------------------------------------------------------------------
-- In-Game Options - function that creates inGame options button
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function ingameOptionsbutton(event, gui)
	local cX = display.contentCenterX
	local cY = display.contentCenterY

	-- Add in-game options image (option_wheel.png)
	local ingameOptions = display.newImageRect("mapdata/art/buttons/option_wheel.png", 90, 90, true)

	-- Scale image size
	--ingameOptions.anchorX = 0
	--ingameOptions.anchorY = 1
	ingameOptions.x = display.contentCenterX + 650
	ingameOptions.y = display.contentCenterY - 350
	ingameOptions.name = "inGameOptionsBTN"	
	ingameOptions:addEventListener("tap", buttonPressed)
	gui.front:insert(ingameOptions)
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
	menuGroup = display.newGroup()
	
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
		[1] = display.newImageRect("mapdata/art/background/screens/cocoonedMenu.png", 1460, 864),
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
		-- Plus button #2
		[7] = display.newImageRect("mapdata/art/buttons/plus.png", 100, 100),
		-- Pause text object
		[8] = display.newText("PAUSED", 1155, 100, native.Systemfont, 69)
	}
		
	-- Assign position		
	menuObjects[1].x = display.contentCenterX
	menuObjects[1].y = display.contentCenterY	
	menuObjects[2].x = display.contentCenterX + 450
	menuObjects[2].y = display.contentCenterY + 150		
	menuObjects[3].x = display.contentCenterX + 450
	menuObjects[3].y = display.contentCenterY + 315
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
	menuGroup:insert(menuObjects[1])
	
	for i=2, #menuObjects do
		-- Assign name for runtime functions
		menuObjects[i].name = menuNames[i-1]
		menuObjects[i].anchorX = 0.5
		menuObjects[i].anchorY = 0.5
		menuObjects[i]:setFillColor(0, 0, 1)
		
		-- add event listeners to buttons
		menuObjects[i]:addEventListener("tap", buttonPressed)
		-- Add everything to menuGroup
		menuGroup:insert(menuObjects[i])
	end
		
	return menuGroup
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