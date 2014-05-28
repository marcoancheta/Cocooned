local tutorialLib = {}
local hintText = {
			  --popped up?, text, box x position, box y position, box width, box height,
	"tiltTip" = {false, "Tilt to move.", 20, 20, 500, 500},
	"runeTip1" = {false, "Runes grant abilities.", 20, 20, 500, 500},
	"runeTip2" = {false, "Collect all runes in a level to activate portal.", 20, 20, 500, 500},
	"waterTip" = {false, "Shake to swim to shore.", 20, 20, 500, 500},
	"portalTip" = {false, "Collect all runes in a level to activate portal.", 20, 20, 500, 500},
	"swipePaneTip" = {false, "Tap or swipe to swap panes.", 20, 20, 500, 500}
}

function deleteHint(event)
	--delete text, rect and listener
	hintText[event.target.name].rect:removeEventListener("tap", deleteHint)
	hintText[event.target.name].rect:removeSelf()
	hintText[event.target.name].text:removeSelf
	hintText[event.target.name].rect = nil
	hintText[event.target.name].text = nil
	--delayed call to create swipe hint?
end


--called in movement 
function tutorialLib:showTipBox(tipType, gui)
	local playerSeen = hintText[tipType][1]
	local tipText = hintText[tipType][2]
	local boxPosX = hintText[tipType][3]
	local boxPosY = hintText[tipType][4]
	local boxWidth = hintText[tipType][5]
	local boxHeight = hintText[tipType][6]
	local toolTip = {}
	if playerSeen == false then
		toolTip[1] = display.newRect(0, 0, boxWidth, boxHeight)
		toolTip[1].x, toolTip[1].y = generate.tilesToPixels(boxPosX, boxPosY)
		-- same visuals as goal box
		toolTip[1]:setStrokeColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		toolTip[1]:setFillColor(167*0.00392156862, 219*0.00392156862, 216*0.00392156862)
		toolTip[1].strokeWidth = 15
		toolTip[1].name = tipType

		--add tap functionality
		toolTip[1]:addEventListener("tap", deleteHint)
		
		toolTip[2] = display.newText(toolTip[1].x + (boxWidth/2), toolTip[1].y + (boxHeight/2), font.TEACHERA, 72)
		toolTip[2]:setFillColor(0,0,0)
		gui.front:insert(toolTip[1])
		gui.front:insert(toolTip[2])
		hintText[tipType][1] = true
		hintText[tipType].rect = toolTip[1]
		hintText[tipType].text = toolTip[2]
	end
end

return tutorialLib

