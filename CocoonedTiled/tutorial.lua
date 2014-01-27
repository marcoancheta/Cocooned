

local tutorial

local textBox
local textObject1, textObject2, textObject3, textObject4, textObject5


function insertTutorialText()
	textObject1:setFillColor(0,0,0)
	textObject2:setFillColor(0,0,0)
	textObject3:setFillColor(0,0,0)
	textObject4:setFillColor(0,0,0)
	textObject5:setFillColor(0,0,0)

	textBox:toBack()

	tutorial:insert(textBox)
	tutorial:insert(textObject1)
	tutorial:insert(textObject2)
	tutorial:insert(textObject3)
	tutorial:insert(textObject4)
	tutorial:insert(textObject5)
end

function printGoal()
	tutorial = display.newGroup()
	tutorial.name = "tutorial"

	textBox = display.newRect( 720, 300, 1000, 320)
	textBox.alpha = 0.75
	textObject1 = display.newText("Great!!", 720, 200, native.Systemfont, 45)
	textObject2 = display.newText("Now that you know the mechanics", 720, 260, native.Systemfont, 40)
	textObject3 = display.newText("Try and get to the rune in the middle pane", 720, 310, native.Systemfont, 40)
	textObject4 = display.newText("(Tap this box to continue on with game)", 720, 360, native.Systemfont, 40)
	textObject5 = display.newText("", 720, 415, native.Systemfont, 40)
	
	insertTutorialText()
	
	tutorial:addEventListener("tap", tutorial4Pressed)
end


function printSwitchPaneText()

	physics.pause()
	tutorial = display.newGroup()
	tutorial.name = "tutorial"

	textBox = display.newRect( 720, 300, 1000, 320)
	textBox.alpha = 0.75
	textObject1 = display.newText("SWITCH PANES TUTORIAL:", 720, 200, native.Systemfont, 45)
	textObject2 = display.newText("Swipe Left, Right, Up, or Down to switch panes", 720, 260, native.Systemfont, 40)
	textObject3 = display.newText("You can swipe in map mode as well", 720, 310, native.Systemfont, 40)
	textObject4 = display.newText("But you can only swipe to adjacent panes", 720, 360, native.Systemfont, 40)
	textObject5 = display.newText("(Tap this box to continue)", 720, 410, native.Systemfont, 40)

	insertTutorialText()

	tutorial:addEventListener("tap", tutorial3Pressed)
end

function printMiniMapText()

	physics.pause()
	tutorial = display.newGroup()
	tutorial.name = "tutorial"

	textBox = display.newRect( 720, 300, 1000, 320)
	textBox.alpha = 0.75
	textObject1 = display.newText("MAP TUTORIAL:", 720, 200, native.Systemfont, 45)
	textObject2 = display.newText("Tap your screen twice to show a map of level", 720, 260, native.Systemfont, 40)
	textObject3 = display.newText("Tap twice again to close map", 720, 310, native.Systemfont, 40)
	textObject4 = display.newText("The highlighted pane is the pane you are in", 720, 360, native.Systemfont, 40)
	textObject5 = display.newText("(Tap this box to continue on with game)", 720, 410, native.Systemfont, 40)

	textObject5:setFillColor(0,0,0)
	
	insertTutorialText()

	tutorial:addEventListener("tap", tutorial2Pressed)

end

function printMovementText()

	physics.pause()
	tutorial = display.newGroup()
	tutorial.name = "tutorial"

	textBox = display.newRect( 720, 300, 800, 320)
	textBox.alpha = 0.75
	textObject1 = display.newText("Welcome to the Cocooned Tutorial!!", 720, 200, native.Systemfont, 40)
	textObject2 = display.newText("MOVEMENT TUTORIAL:", 720, 260, native.Systemfont, 45)
	textObject3 = display.newText("Tilt your device to move the character", 720, 315, native.Systemfont, 40)
	textObject4 = display.newText("(Tap this box to continue on with game)", 720, 365, native.Systemfont, 40)
	textObject5 = display.newText("", 720, 415, native.Systemfont, 40)

	insertTutorialText()

	tutorial:addEventListener("tap", tutorial1Pressed)

end

function tutorial1Pressed(event)

	if event.target.name == "tutorial" then
		tutorial:removeSelf()
		physics.start()
		timer.performWithDelay(2500, printMiniMapText)
	end

end

function tutorial2Pressed(event)

	if event.target.name == "tutorial" then
		tutorial:removeSelf()
		physics.start()
		timer.performWithDelay(3000, printSwitchPaneText)
	end

end

function tutorial3Pressed(event)

	if event.target.name == "tutorial" then
		tutorial:removeSelf()
		printGoal()
	end

end

function tutorial4Pressed(event)

	if event.target.name == "tutorial" then
		tutorial:removeSelf()
		physics.start()
	end

end
