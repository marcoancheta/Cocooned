--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- tutorial.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- variables
local tutorial
local tNum = 1
local textBox, box
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
	boxY = 432,
	boxW = 1250,
	boxH = 70,
	boxA = 0.75
}


-- tutorial text
local text = {
	[1] = {
		[1] = "MOVEMENT TUTORIAL:",
		[2] = "Tilt your device to move the character",
		[3] = "OBJECTIVE:",
		[4] = "Get to the RUNE",
		[5] = "(Tap to continue)",
		[6] = -100
	},

	[2] = {
		[1] = "MAP TUTORIAL:",
		[2] = "Tap twice to show or hide map of the level",
		[3] = "SWITCH PANES TUTORIAL:",
		[4] = "Swipe Left, Right, Up, or Down to switch panes",
		[5] = "OBJECTIVE:",
		[6] = "Get the RUNE at the bottom pane",
		[7] = "(Tap to continue)",
		[8] = -50
	},

	[3] = {
		[1] = "COLOR CHANGING TUTORIAL:",
		[2] = "Roll over the green or white aura to change colors",
		[3] = "You can pass through colored walls if you match colors",
		[4] = "OBJECTIVE:",
		[5] = "Collect 2 more RUNES in the level",
		[6] = "(Tap this box to continue)",
		[7] = -90
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

	box = display.newRect( 720, 432, 1500, 864)
	box.alpha = 0.01

	-- create background box for text display and set alpha
	local boxH = tBox.boxH*#text[tNum]

	textBox = display.newRect( tBox.boxX, tBox.boxY + text[tNum][#text[tNum]], tBox.boxW, boxH)
	textBox.alpha = tBox.boxA

	
	-- create text objects
	textObject = { }
		
	for i=1, #text[tNum]-1 do
		textObject[i] = display.newText(text[tNum][i], tBox.x, tBox.y + tBox.offsetLG*(i-1), tBox.font, tBox.fontSizeSM)
		-- set color of text objects
		textObject[i]:setFillColor(0,0,0)
	end

	-- insert text objects to display group
	tutorial:insert(box)
	tutorial:insert(textBox)
	for i=1, #textObject do
		tutorial:insert(textObject[i])
	end

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
	end
end

function resetTutorial()
	tNum = 1
end

-- funtion to remove tutorial asap
function removeTutorials()
	tutorial.removeSelf()
end
