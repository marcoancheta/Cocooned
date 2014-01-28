--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- tutorial.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- variables
local tutorial
local tNum = 1
local textBox
local textObject1, textObject2, textObject3, textObject4, textObject5

-- tutorial text and box variables
local tBox = {
	x = 720,
	y = 200,
	font = nativeSystefont,
	fontSizeSM = 45,
	fontSizeLG = 55,
	offset = 50,
	offsetLG = 60,
	boxX = 720,
	boxY = 320,
	boxW = 1100,
	boxH = 350,
	boxA = 0.75
}


-- tutorial text
local text = {
	[1] = {
		[1] = "MOVEMENT TUTORIAL:",
		[2] = "Tilt your device to move the character",
		[3] = "(Tap this box to continue on with game)",
		[4] = "",
		[5] = ""
	},

	[2] = {
		[1] = "MAP TUTORIAL:",
		[2] = "Tap twice to show a map of the level",
		[3] = "Tap twice again to close map",
		[4] = "The highlighted pane is the pane you are in",
		[5] = "(Tap this box to continue on with game)"
	},

	[3] = {
		[1] = "SWITCH PANES TUTORIAL:",
		[2] = "Swipe Left, Right, Up, or Down to switch panes",
		[3] = "You can swipe in map mode as well",
		[4] = "But you can only swipe to adjacent panes",
		[5] = "(Tap this box to continue)"
	},

	[4] = {
		[1] = "Great!!",
		[2] = "Now that you know the mechanics",
		[3] = "Try and get to the rune in the middle pane",
		[4] = "(Tap this box to continue on with game)",
		[5] = ""

	}
}


function printTutorial()

	-- pause physics
	physics.pause()

	-- create new display group for tutorial
	tutorial = display.newGroup()

	-- name display group for event listener
	tutorial.name = "tutorial"

	-- create background box for text display and set alpha
	textBox = display.newRect( tBox.boxX, tBox.boxY, tBox.boxW, tBox.boxH)
	textBox.alpha = tBox.boxA

	-- create text objects
	textObject1 = display.newText(text[tNum][1], tBox.x, tBox.y, tBox.font, tBox.fontSizeLG)
	textObject2 = display.newText(text[tNum][2], tBox.x, tBox.y + tBox.offsetLG, tBox.font, tBox.fontSizeSM)
	textObject3 = display.newText(text[tNum][3], tBox.x, tBox.y + tBox.offsetLG*2, tBox.font, tBox.fontSizeSM)
	textObject4 = display.newText(text[tNum][4], tBox.x, tBox.y + tBox.offsetLG*3, tBox.font, tBox.fontSizeSM)
	textObject5 = display.newText(text[tNum][5], tBox.x, tBox.y + tBox.offsetLG*4, tBox.font, tBox.fontSizeSM)

	-- set color of text objects
	textObject1:setFillColor(0,0,0)
	textObject2:setFillColor(0,0,0)
	textObject3:setFillColor(0,0,0)
	textObject4:setFillColor(0,0,0)
	textObject5:setFillColor(0,0,0)

	-- insert text objects to display group
	tutorial:insert(textBox)
	tutorial:insert(textObject1)
	tutorial:insert(textObject2)
	tutorial:insert(textObject3)
	tutorial:insert(textObject4)
	tutorial:insert(textObject5)

	-- add display group to event listener (tap function)
	tutorial:addEventListener("tap", tutorialPressed)

end

-- event function for tap
function tutorialPressed(event)

	-- if event is tutorial do this:
	if event.target.name == "tutorial" then

		-- remove display group and increment tNum
		tutorial:removeSelf()
		tNum = tNum + 1

		-- unpause physics
		physics.start()
		if tNum < 4 then

			-- create a set timer for other tutorials
			timer.performWithDelay(2500, printTutorial)
		elseif tNum == 4 then

			-- play last tutorial
			printTutorial()
		end
		
		
	end
end

-- funtion to remove tutorial asap
function removeTutorials()
	tutorial.removeSelf()
end
