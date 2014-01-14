--------------------------------------------------------------------------------
--[[
Dusk Engine Demo

This is a rather unpolished interface; I wanted to publicize the engine before working on better demos.
--]]
--------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

local textureFilter = "nearest"
display.setDefault("minTextureFilter", textureFilter)
display.setDefault("magTextureFilter", textureFilter)

_G.levelNum = 1 -- Normally I'd be against using _G, but, in this case, this is the only way I can think of without making bob.lua one big function (or using a globals file, which would be a bit much just for a level designation number)

local function loadDemo()
	require("gameLoop")
end

local function alertListener(event)
	levelNum = 1 -- Because we put the buttons reversed so that they would be in the right positions, we have to invert the index to get the correct level
	loadDemo()
end

alertListener({index = 3})
--native.showAlert("Bob", "Welcome to the Dusk demo!\n\nChoose your level.", {"3", "2", "1"}, alertListener)