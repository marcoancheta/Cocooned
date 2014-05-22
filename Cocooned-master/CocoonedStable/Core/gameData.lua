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
	
	-- Game Booleans
	inWater = false,
	levelComplete = false,
	onIceberg = false,
	gRune = false,
	
	locked = false,
	
	-- Sound values
	sfxVolume = 5,
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
	defaultTime = 0
}

return gameData