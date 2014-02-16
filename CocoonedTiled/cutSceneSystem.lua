--TODO: add in levels that have cutscenes
local numberOfScreens= {} --level number, number of cutscenes


function cutScene(levelNumber)
	--TODO: for loop that displays each scene in order
	for i= numberOfScreens[levelNumber],0,-1 do
		loadingBG = display.newImage('mapdata/cutscenes/level'..levelNumber .. i .. '.jpg', 10, 20,true )
	end
	--TODO: add button to go through scenes? or just tap on image to delete
	--TODO: remove listener for taps or button
