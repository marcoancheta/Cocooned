--------------------------------------------------------------------------------
-- Core Game Loop
--------------------------------------------------------------------------------
-- Updated by: Derrick 
--------------------------------------------------------------------------------
local function gameLoopEvents(event)
	-- Run monitorMemory from open to close.
	memory.monitorMem()
				
	if mapData.levelNum == "LS" then
		if gui.back[1] then
			-- Set Camera to Ball
			gui.back[1].setCameraFocus(ball)
			gui.back[1].setTrackingLevel(0.1)
		end
	end
	
	---------------------------------
	--[[ START LVL SELECTOR LOOP ]]--
	-- If select level do:
	if gameData.selectLevel then
		mapData.levelNum = "LS"
		mapData.pane = "LS"
		
		loadMap(mapData)
		menu.ingameOptionsbutton(event, gui)
				
		-- Re-evaluate gameData booleans	
		gameData.selectLevel = false
	end
	
	-----------------------------
	--[[ START GAMEPLAY LOOP ]]--
	-- If game has started do:
	if gameData.gameStart then
		print("start game")
		clean(event)
		
		mapData = gameData.mapData
		loadMap(mapData)
		menu.ingameOptionsbutton(event, map)
		
		-- Re-evaluate gameData booleans
		gameData.allowPaneSwitch = true
		gameData.allowMiniMap = true
		gameData.gameStart = false
	end

	-----------------------------
	--[[ END GAMEPLAY LOOP ]]--
	-- If game has ended do:
	if gameData.gameEnd then
		clean(event)
	
		-- set booleans
		gameData.menuOn = true
		gameData.gameEnd = false
	elseif gameData.levelRestart == true then
		clean(event)
		
		if gameData.menuOn ~= true then
			gameData.selectLevel = true
		else
			-- reset pane to middle pane
			mapData.pane = 'M'
			gameData.gameStart = true
		end
		
		gameData.levelRestart = false
	end
	
	-------------------
	--[[ MAIN MENU ]]--
	if gameData.menuOn then
		-- Go to main menu
		menu.mainMenu(event)
		
		-- Start BGM
		--sound.playBGM(event, sound.gameSound)
		
		-- reset mapData variables
		if mapData.pane ~= "M" then
			mapData.pane = "M"
			mapData.version = 0
		end

		-- Re-evaluate gameData booleans
		gameData.menuOn = false
	----------------------
	--[[ OPTIONS MENU ]]--	
	elseif gameData.inOptions then
		-- Go to options menu
		menu.options(event)																																																																						
		-- Re-evaluate gameData booleans
		gameData.inOptions = false		
	-------------------------
	--[[ IN-GAME OPTIONS ]]--
	elseif gameData.inGameOptions then
		-- Go to in-game option menu
		menu.ingameMenu(event, player1, player2, gui)
		
		-- Remove object listeners
		gui.back:removeEventListener("touch", swipeMechanics)
		gui.back:removeEventListener("tap", tapMechanic)
		Runtime:removeEventListener("accelerometer", controlMovement)
		Runtime:removeEventListener("enterFrame", speedUp)

		-- Re-evaluate gameData booleans
		--gameData.ingame = false
		gameData.allowMiniMap = false
		gameData.showMiniMap = false
		gameData.isShowingMiniMap = false
		gameData.inGameOptions = false
	--------------------------
	--[[ RESUME GAME LOOP ]]--		
	elseif gameData.resumeGame then
		-- Restart physics
		physics.start()		
		-- Re-add in game options button
		menu.ingameOptionsbutton(event, map)

		-- Add object listeners
		gui:addEventListener("touch", swipeMechanics)
		gui:addEventListener("tap", tapMechanic)
		Runtime:addEventListener("accelerometer", controlMovement)
		Runtime:addEventListener("enterFrame", speedUp)
		
		-- Re-evaluate gameData booleans
		gameData.inGameOptions = false
		gameData.allowMiniMap = true
		gameData.showMiniMap = true
		gameData.resumeGame = false
	end	
end

local gameLoop = {
	gameLoopEvents = gameLoopEvents
}

return gameLoop