--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- gameData.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- gameData holds all global variables that will be used across all lua files

--------------------------------------------------------------------------------
-- Global Variables
--------------------------------------------------------------------------------
local gameData = {
	-- toggle debug mode
	debugMode = false,
	
	-- Game Loop Booleans
	preGame = nil,
	gameStart = false,
	gameScore = false,
	gameEnd = false,
	ingame = 0,
	resumeGame = false,
	menuOn = true,	
	inGameOptions = false,
	gameOptions = false,
	inOptions = false,
	inMainMenu = false,
	updateOptions = false,
	shadow = true,
	winning = false,
	
	-- Level Selector Booleans
	selectWorld = false,
	inWorldSelector = 0,
	selectLevel = false,
	inLevelSelector = 0,
	
	-- Touch interface booleans
	allowTouch = false,
	allowPaneSwitch = false,
	
	-- Minimap Booleans
	allowMiniMap = false,
	showMiniMap = false,
	isShowingMiniMap = false,

	-- Collision Booleans
	collOn = true,
	
	-- Game Booleans
	inWater = false,
	levelComplete = false,
	onIceberg = false,
	gRune = false,
	
	locked = false,
	
	-- Sound values
	sfxVolume = 10,
	bgmVolume = 5,
	
	-- mapData global
	mapData = {
		world = "A",
		levelNum = 1,
		pane = "M",
		version = 0
	},
	
	-- Game values
	gameTime = 0,
	defaultTime = 0,
	deaths = 0,

	--Accelerometer values
	offSetX = 0,
	offSetY = 0,
	invert = false,
}

local function printData()
	print("preGame", preGame)
	print("gameStart", gameStart)
	print("gameScore", gameScore)
	print("gameEnd", gameEnd)
	print("ingame", ingame)
	print("resumeGame", resumeGame)
	print("menuOn", menuOn)
	print("inGameOptions", inGameOptions)
	print("gameOptions", gameOptions)
	print("inOptions", inOptions)
	print("inMainMenu", inMainMenu)
	print("updateOptions", updateOptions)
	print("shadow", shadow)
	print("winning", winning)
	
	-- Level Selector Booleans
	print("selectWorld", selectWorld)
	print("inWorldSelector", inWorldSelector)
	print("selectLevel", selectLevel)
	print("inLevelSelector", inLevelSelector)
	
	-- Touch interface booleans
	print("allowTouch", allowTouch)
	print("allowPaneSwitch", allowPaneSwitch)
	
	-- Minimap Booleans
	print("allowMiniMap", allowMiniMap)
	print("showMiniMap", showMiniMap)
	print("isShowingMiniMap", isShowingMiniMap)

	-- Collision Booleans
	print("collOn", collOn)
	
	-- Game Booleans
	print("inWater", inWater)
	print("levelComplete", levelComplete)
	print("onIceberg", onIceberg)
	print("gRune", gRune)
	
	print("locked", locked)
end

gameData.printData = printData

return gameData