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
local generate = require("Objects.generateObjects")
local goals = require("Core.goals")
local widget = require("widget")
local memory = require("memory")
local snow = require("utils.snow")
local tutorialLib = require("utils.tutorialLib")
local loadingScreen = require("Loading.loadingScreen")

local tempGui
local menuGroup
local menuObjects = nil
local ingameOptions

--widget.setTheme("widget_theme_ios")
--local player1, player2 = nil
-- Create onScreen text object
--[[
local playerText = {
	--player's current speed
	[2] = display.newText(player.speedConst, 1150, 380, "Teacher_A", 69)
	--player's linear damping
	[3] = display.newText(player.imageObject.linearDamping, 1150, 225, "Teacher_A", 69)
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
	if menuGroup then
		menuGroup:removeSelf()
		menuGroup = nil
		
		for i=1, #menuObjects do
			menuObjects = nil
		end
	end
end

local function cleanInGameOptions()
	if ingameOptions then
		ingameOptions:removeSelf()
		ingameOptions = nil
	end
end

--------------------------------------------------------------------------------
-- Get accelerometer readings
--------------------------------------------------------------------------------
local function getAccelOffset(event)
	gameData.offSetX=-event.yGravity
	gameData.offSetY=-event.xGravity
	Runtime:removeEventListener("accelerometer", getAccelOffset)
end

--------------------------------------------------------------------------------
-- Player Accelerometer Controls
--------------------------------------------------------------------------------

local function playerAC(int)
	if player1 ~= nil then
		player1.imageObject.linearDamping = player1.imageObject.linearDamping + int
			
		if player2.isActive then
			player2.imageObject.linearDamping = player2.imageObject.linearDamping + int
		end
		--player's linear damping
		playerText = display.newText(player1.imageObject.linearDamping, 350, 100, "Teacher_A", 103)
		playerText:setFillColor(0, 0, 0)
		playerText:toFront()
	end
end


--------------------------------------------------------------------------------
-- Menu options update function. Pass in menuObjects.
--------------------------------------------------------------------------------
local function update(objGroup)
	if objGroup then
		if gameData.updateOptions then
			--[[if objGroup.name == "optGroup" then
				objGroup[9].text = gameData.bgmVolume * 10
				objGroup[10].text = gameData.sfxVolume * 10
			elseif objGroup.name == "igoptGroup" then]]--
				objGroup[10].text = gameData.bgmVolume * 10
				objGroup[11].text = gameData.sfxVolume * 10
			--end
		else
			objGroup:removeSelf()
			objGroup = nil
		end
	end
end

-- Main Menu
local transDelay = {
	[1] = function() clean(); gameData.selectWorld=true; gameData.inMainMenu=false; end,
	[2] = function() clean(); gameData.inOptions=true; gameData.inMainMenu=false; end
}

--------------------------------------------------------------------------------
-- Button events - function that holds button functionality
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function buttonPressed(event)
	sound.stopChannel(1)
	sound.playSound(sound.soundEffects[1])
	--[[ Play button pressed ]]--
	if event.target.name == "playButton" then
		loadingScreen.loadingInit(tempGui)
		-- show pressed objects
		menuObjects[4].alpha = 1
		-- Remove menuGroup
		--clean()
		-- User pressed play, set gameActive to true
		local tempTran = transition.to(menuObjects[4],{time=250, alpha=1, onComplete=transDelay[1]})
		--local tempTrans = transition.to(menuObjects[2],{time=200, alpha=0, onComplete=transDelay[1]})
		--gameData.selectWorld = true		
	--[[ Options button pressed ]]--
	elseif event.target.name == "optionButton" then	
		loadingScreen.loadingInit(tempGui)
		-- show pressed objects
		menuObjects[5].alpha = 1
		-- Remove menuGroup
		--clean()
		--snow.meltSnow()
		-- Call to options display
		local tempTran = transition.to(menuObjects[5],{time=250, alpha=1, onComplete=transDelay[2]})
		--local tempTrans = transition.to(menuObjects[3],{time=200, alpha=0, onComplete=transDelay[2]})
		--gameData.inMainMenu = false
		--gameData.inOptions = true		
	--[[ Back to Main button pressed ]]--
	elseif event.target.name == "BacktoMain" then
		if gameData.debugMode then
			print("Back to Main Menu")
		end
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
	--[[ In game options button pressed ]]--	
	elseif event.target.name == "inGameOptionsBTN" then
		if gameData.preGame ~= true then
			if gameData.debugMode then
				print("In game options")
			end		
			-- gameData.inWorldSelector||inLevelSelector||ingame
			-- ( 1 = in that scene, -1 = was in that scene, 0 = no longer in that scene
			if gameData.inWorldSelector == 1 then
				gameData.inWorldSelector = -1
			elseif gameData.inLevelSelector == 1 then
				gameData.inLevelSelector = -1
			elseif gameData.ingame == 1 then
				-- pause snow
				snow.pauseSnow()
				gameData.ingame = -1
				-- disable pane switch and mini map
				gameData.allowMiniMap = false
				gameData.allowPaneSwitch = false
			end
			
			--gameData.gameOptions = true					
			gameData.inGameOptions = true
		end
	--[[ Back to Main from In-Game button pressed ]]--
	elseif event.target.name == "gotoMain" then
		if gameData.debugMode then
			print("Back to Main Menu")
		end
		-- clean out
		clean()		
		sound.soundClean()
		-- gameData.inWorldSelector||inLevelSelector||ingame
		-- ( 1 = in that scene, -1 = was in that scene, 0 = no longer in that scene
		if gameData.inWorldSelector == -1 then
			gameData.inWorldSelector = 0
		elseif gameData.inLevelSelector == -1 then
			goals.destroyGoals()
			gameData.inLevelSelector = 0
		elseif gameData.ingame == -1 then
			gameData.ingame = 0
			-- turn off pane switch and minimap
			gameData.allowPaneSwitch = false
			gameData.allowMiniMap = false
			-- clean tutorial files if exists
			if tutorialLib.tutorialStatus then
				tutorialLib:clean()
			end
		end
		--gameData.gameOptions = false
		gameData.gameEnd = true		
	--[[ Resume In-Game button pressed ]]--
	elseif event.target.name == "Resume" then
		if gameData.debugMode then
			print("Resume game")
		end
		-- clean out
		clean()		
		-- gameData.inWorldSelector||inLevelSelector||ingame
		-- ( 1 = in that scene, -1 = was in that scene, 0 = no longer in that scene
		if gameData.inWorldSelector == -1 then
			gameData.inWorldSelector = 1
		elseif gameData.inLevelSelector == -1 then
			gameData.inLevelSelector = 1
		elseif gameData.ingame == -1 then
			-- resume snow transition
			snow.resumeSnow()
			gameData.ingame = 1
			-- turn pane switch and mini map back on
			gameData.allowPaneSwitch = true
			gameData.allowMiniMap = true
		end
		
		--gameData.gameOptions = false
		gameData.resumeGame = true	
		
	elseif event.target.name == "restart" then
		clean()
		
		if gameData.inWorldSelector == -1 then
			gameData.selectWorld = true
		elseif gameData.inLevelSelector == -1 then
			gameData.inLevelSelector = 0
			gameData.selectLevel = true
		elseif gameData.ingame == -1 then
			-- clean tutorial files if exists
			if tutorialLib.tutorialStatus then
				tutorialLib:clean()
			end		
			gameData.levelRestart = true
		else
			gameData.levelRestart = true
		end
		
	elseif event.target.name == "level" then
		if gameData.debugMode then
			print("Back to Main Menu")
		end
		-- clean out
		clean()
		-- gameData.inWorldSelector||inLevelSelector||ingame
		-- ( 1 = in that scene, -1 = was in that scene, 0 = no longer in that scene
		if gameData.inWorldSelector == -1 then
			gameData.selectWorld = true
		elseif gameData.inLevelSelector == -1 then
			gameData.inLevelSelector = 0
			gameData.selectLevel = true			
		elseif gameData.ingame == -1 then
			gameData.ingame = 0
			-- turn off pane switch and minimap
			gameData.allowPaneSwitch = false
			gameData.allowMiniMap = false			
			-- clean tutorial files if exists
			if tutorialLib.tutorialStatus >= 1 then
				tutorialLib:clean()
				gameData.selectWorld = true
			else
				gameData.selectLevel = true
			end
		else
			gameData.selectLevel = true
		end
	elseif event.target.name == "calibrateAccelerometer" then
		local eventListener = Runtime:addEventListener("accelerometer", getAccelOffset)	
	--[[ invert controls switch button pressed ]]--
	elseif event.target.name == "invertControlsSwitch" then
		local switch = event.target		
		if switch.isOn then
			gameData.invert = -1
		else
			gameData.invert = 1
		end
		memory.toggle()	
	end
end

--------------------------------------------------------------------------------
-- Main Menu - function that creates menu System
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function mainMenu(event, gui)
	tempGui = gui

	if gameData.debugMode then
		print("In Main Menu")
	end
	
	if audio.isChannelPlaying(3) == false then
		sound.loadMenuSounds()
		sound.playBGM(sound.backgroundMusic[1])
	end
			
	-- Create new menu display group
	menuGroup = display.newGroup()
		
	menuObjects = {
		-- Add main menu background image
		[1] = display.newImageRect("mapdata/art/TitleScreen.png", 1460, 864),
		-- Add Play button
		[2] = display.newImageRect("mapdata/art/buttons/play_unpressed.png", 400, 250),
		-- Add Option buttons
		[3] = display.newImageRect("mapdata/art/buttons/options_unpressed.png", 400, 250),
		-- Add Play (Pressed) button
		[4] = display.newImageRect("mapdata/art/buttons/play_pressed.png", 400, 250),
		-- Add Option (Pressed) buttons
		[5] = display.newImageRect("mapdata/art/buttons/options_pressed.png", 400, 250)		
	}
	
	-- main menu background
	menuObjects[1].x = display.contentCenterX
	menuObjects[1].y = display.contentCenterY
	-- Add names for buttons for listener event
	menuObjects[2].name = "playButton"
	menuObjects[3].name = "optionButton"
	-- Position buttons
	-- [unpressed]
	menuObjects[2].x, menuObjects[2].y = display.contentCenterX - 300, display.contentCenterY + 200
	menuObjects[3].x, menuObjects[3].y = display.contentCenterX + 300, display.contentCenterY + 200	
	-- [pressed]
	menuObjects[4].x, menuObjects[4].y = display.contentCenterX - 300, display.contentCenterY + 200
	menuObjects[5].x, menuObjects[5].y = display.contentCenterX + 300, display.contentCenterY + 200
	-- temporarily hide pressed objects
	menuObjects[4].alpha = 0
	menuObjects[5].alpha = 0
	
	-- Iterate through all objects and apply as necessary	
	for i=1, #menuObjects do		
		if i > 1 and i < 4 then
			-- add event listener for new game and options only
			menuObjects[i]:addEventListener("tap", buttonPressed)
		end
		--menuGroup:insert(menuObjects[i])
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
	if gameData.debugMode then
		print("In Options")
	end
	
	-- Image sheet options and declaration
	local options = {
		frames = {
			{ x=0, y=0, width=40, height=70 },
			{ x=80, y=0, width=40, height=70 },
			{ x=205, y=0, width=40, height=70 },
			{ x=248, y=0, width=64, height=70 },
			{ x=336, y=0, width=70, height=70 }
		},
		sheetContentWidth = 406,
		sheetContentHeight = 70
	}
	
	local sliderSheet = graphics.newImageSheet("mapdata/art/slider/sliderSheet.png", options )
		
	local sfxVal = (gameData.sfxVolume*10)
	local bgmVal = (gameData.bgmVolume*10)
	
	-- Create new menu display group
	menuGroup = display.newGroup()
	
	menuObjects = {
		-- Background Scenery from: http://www.deviantart.com/art/A-House-for-Wendy-455901046
		[1] = display.newImageRect("mapdata/art/background/screens/scenery.png", 1460, 840),
		-- Add options background image
		[2] = display.newImageRect("mapdata/art/background/screens/options.png", 1460, 840),
		-- Add Main Menu button
		[3] = display.newImageRect("mapdata/art/buttons/main.png", 300, 300),
		-- Debug switch
		[4] = widget.newSwitch{style = "onOff", id = "onOffSwitch", 
							   onPress = buttonPressed},
		-- Debug text
		[5] = display.newText("Debug Mode: ", 350, 150, "Teacher_A", 52),
		-- Sound controller (SFX[6] - BGM[7])
		[6] = widget.newSlider{sheet = sliderSheet, leftFrame = 1, middleFrame = 2, rightFrame = 3, fillFrame = 4,
								frameWidth = 32, frameHeight = 70, handleFrame = 5, handleWidth = 90, handleHeight = 90,
								orientation="horizontal", width=360, height=80, value = sfxVal, 
								listener=sfxController},
		[7] = widget.newSlider{sheet = sliderSheet, leftFrame = 1, middleFrame = 2, rightFrame = 3, fillFrame = 4,
								frameWidth = 32, frameHeight = 70, handleFrame = 5, handleWidth = 90, handleHeight = 90,
								orientation="horizontal", width=360, height=80, value = bgmVal, 
								listener=bgmController},
		-- Sound text
		[8] = display.newText("Sound Volume: ", 350, 150, "Teacher_A", 52),
		[9] = display.newText("Music Volume: ", 350, 150, "Teacher_A", 52),
		-- Pre-store location in array for value text
		[10] = display.newText(gameData.sfxVolume*10, 350, 150, "Teacher_A", 40),
		[11] = display.newText(gameData.bgmVolume*10, 350, 150, "Teacher_A", 40),
		
		--Invert switch
		[12] = widget.newSwitch{style = "onOff", id = "onOffSwitch", 
							   onPress = buttonPressed},
		-- Invert text
		[13] = display.newText("Invert Controls: ", 350, 150, "Teacher_A", 52),

		-- Calibrate Accelerometer button
		[14] = display.newImageRect("mapdata/art/buttons/main.png", 300, 300),
	}
	
	menuObjects.name = "optGroup"
	
	-- White background back layer
	menuObjects[1].x = display.contentCenterX
	menuObjects[1].y = display.contentCenterY
	
	-- Options background image
	menuObjects[2].x = display.contentCenterX
	menuObjects[2].y = display.contentCenterY
	menuObjects[2].alpha = 0.9

	-- Main Menu button
	menuObjects[3].x = display.contentCenterX
	menuObjects[3].y = display.contentCenterY + 250
	menuObjects[3].name = "BacktoMain"
	menuObjects[3]:addEventListener("tap", buttonPressed)

	
	-- Options title text
	--menuObjects[3]:setFillColor(0, 0, 0)
	
	-- Debug toggle object
	if gameData.debugMode then
		menuObjects[4]:setState({isOn = true})
	elseif gameData.debugMode == false then
		menuObjects[4]:setState({isOn = false})
	end
	
	menuObjects[4].x = display.contentCenterX + 200
	menuObjects[4].y = display.contentCenterY + 75
	menuObjects[4].name = "debugSwitch"

	-- Debug text
	--menuObjects[4].anchorX = 0
	menuObjects[5].x = display.contentCenterX
	menuObjects[5].y = display.contentCenterY + 75
	menuObjects[5]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)	
	-- SFX Volume Slider
	menuObjects[6].x = display.contentCenterX
	menuObjects[6].y = display.contentCenterY
	-- BGM Volume Slider
	menuObjects[7].x = display.contentCenterX
	menuObjects[7].y = display.contentCenterY - 100
	-- SFX Volume Text
	menuObjects[8].x = display.contentCenterX
	menuObjects[8].y = display.contentCenterY - 50
	menuObjects[8]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)
	-- BGM Volume Text
	menuObjects[9].x = display.contentCenterX
	menuObjects[9].y = display.contentCenterY - 150
	menuObjects[9]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)
	-- Sound [0-100] Text
	menuObjects[10].x = display.contentCenterX + 225
	menuObjects[10].y = display.contentCenterY - 100
	menuObjects[10]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)
	-- Sound [0-100] Text
	menuObjects[11].x = display.contentCenterX + 225
	menuObjects[11].y = display.contentCenterY
	menuObjects[11]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)

	-- Inverted controls object
	if gameData.invert then
		menuObjects[12]:setState({isOn = true})
	elseif gameData.invert == false then
		menuObjects[12]:setState({isOn = false})
	end
	
	menuObjects[12].x = display.contentCenterX + 200
	menuObjects[12].y = display.contentCenterY + 125
	menuObjects[12].name = "invertControlsSwitch"
	
	-- Inverted Controls text
	menuObjects[13].x = display.contentCenterX
	menuObjects[13].y = display.contentCenterY + 125
	menuObjects[13]:setFillColor(86*0.0039216, 3*0.0039216, 102*0.0039216)	

	-- Main Menu button
	menuObjects[14].x = display.contentCenterX - 400
	menuObjects[14].y = display.contentCenterY + 250
	menuObjects[14].name = "calibrateAccelerometer"
	menuObjects[14]:addEventListener("tap", buttonPressed)
	
	for i=1, #menuObjects do
		menuGroup:insert(menuObjects[i])
	end
	
	return menuObjects
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
	ingameOptions = display.newImageRect("mapdata/art/buttons/option_wheel.png", 150, 150, true)

	-- Scale image size
	--ingameOptions.anchorX = 0
	--ingameOptions.anchorY = 1
	ingameOptions.x = display.contentCenterX + 650
	ingameOptions.y = display.contentCenterY - 330
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
	if gameData.debugMode then
		print("ingameMenu")
	end
	
	-- Create new menu display group
	menuGroup = display.newGroup()
	
	local menuNames = {
		[1] = "gotoMain",
		[2] = "Resume",
		[3] = "restart",
		[4] = "level",
	}
	
	menuObjects = {
		-- Add options background image
		[1] = display.newImageRect("mapdata/art/background/screens/pause.png", 1460, 860),
		-- Add Main Menu button
		[2] = display.newImageRect("mapdata/art/buttons/main.png", 350, 350),
		-- Add Resume game button
		[3] = display.newImageRect("mapdata/art/buttons/play.png", 350, 350),
		-- Add Restart game button
		[4] = display.newImageRect("mapdata/art/buttons/restart.png", 350, 350),
		-- Add Level select button
		[5] = display.newImageRect("mapdata/art/buttons/levelselect.png", 350, 350)
	}
	
	menuObjects.name = "igoptGroup"
		
	-- Assign position for:
	-- Menu Background
	menuObjects[1].x = display.contentCenterX
	menuObjects[1].y = display.contentCenterY
	menuObjects[1].alpha = 1
	-- Main Menu Button
	menuObjects[2].x = display.contentCenterX
	menuObjects[2].y = display.contentCenterY + 250
	-- Resume game button
	menuObjects[3].x = display.contentCenterX + 450
	menuObjects[3].y = display.contentCenterY
	-- Restart button
	menuObjects[4].x = display.contentCenterX - 450
	menuObjects[4].y = display.contentCenterY
	-- Level select button
	menuObjects[5].x = display.contentCenterX
	menuObjects[5].y = display.contentCenterY - 250
		
	-- Flip background image (horizontal)
	menuGroup:insert(menuObjects[1])
	
	for i=2, #menuObjects do
		-- Assign name for runtime functions
		menuObjects[i].name = menuNames[i-1]
		menuObjects[i].anchorX = 0.5
		menuObjects[i].anchorY = 0.5
		
		-- If in world selector and level selector:
		-- 		Disable Restart and level select button
		if gameData.inWorldSelector == -1 or gameData.inLevelSelector == -1 then
			menuObjects[4].alpha = 0.5
			menuObjects[5].alpha = 0.5			
			if i ~= 4 and i ~= 5 then
				-- add event listeners to buttons
				menuObjects[i]:addEventListener("tap", buttonPressed)
			end
		elseif gameData.ingame == -1 then
			menuObjects[4].alpha = 1
			menuObjects[5].alpha = 1
			-- add event listeners to buttons
			menuObjects[i]:addEventListener("tap", buttonPressed)
		end
		
		-- Add everything to menuGroup
		menuGroup:insert(menuObjects[i])
	end
		
	return menuObjects
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local menu = {
	--soundOptions = soundOptions,
	clean = clean,
	cleanInGameOptions = cleanInGameOptions,
	mainMenu = mainMenu,
	options = options,
	update = update,
	ingameOptionsbutton = ingameOptionsbutton,
	ingameMenu = ingameMenu
}

return menu
-- end of menu.lua