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

---------------------------------------------------------------------------------------------
-- gameData:resetData() - Reset gameData back to default, as if fresh restart on data
---------------------------------------------------------------------------------------------
function gameData:resetData()
	-- print("BEGIN RESET")
	
	-- toggle debug mode
	self.debugMode = false
	
	-- Game Loop Booleans
	self.preGame = nil
	self.gameStart = false
	self.gameScore = false
	self.gameEnd = false
	self.ingame = 0
	self.resumeGame = false
	self.menuOn = true	
	self.inGameOptions = false
	self.gameOptions = false
	self.inOptions = false
	self.inMainMenu = false
	self.updateOptions = false
	self.shadow = true
	self.winning = false
	
	-- Level Selector Booleans
	self.selectWorld = false
	self.inWorldSelector = 0
	self.selectLevel = false
	self.inLevelSelector = 0
	
	-- Touch interface booleans
	self.allowTouch = false
	self.allowPaneSwitch = false
	
	-- Minimap Booleans
	self.allowMiniMap = false
	self.showMiniMap = false
	self.isShowingMiniMap = false

	-- Collision Booleans
	self.collOn = true
	
	-- Game Booleans
	self.inWater = false
	self.levelComplete = false
	self.onIceberg = false
	self.gRune = false	
	self.locked = false
	
	-- Game values
	self.gameTime = 0
	self.defaultTime = 0
	self.deaths = 0
	
	-- print("RESET COMPLETE")
end

---------------------------------------------------------------------------------------------
-- gameData:resetVolume() - Reset volume back to default factory values
---------------------------------------------------------------------------------------------
function gameData:resetVolume()
	-- Sound values
	self.sfxVolume = 10
	self.bgmVolume = 5
end

---------------------------------------------------------------------------------------------
-- gameData:resetMapData() - Reset gameData.mapData back to default
---------------------------------------------------------------------------------------------
function gameData:resetMapData()
	-- mapData global
	self.mapData = {
		world = "A",
		levelNum = 1,
		pane = "M",
		version = 0
	}
end

---------------------------------------------------------------------------------------------
-- gameData:printData() - Print everything in here out to console
---------------------------------------------------------------------------------------------
function gameData:printData()
	print("preGame", self.preGame)
	print("gameStart", self.gameStart)
	print("gameScore", self.gameScore)
	print("gameEnd", self.gameEnd)
	print("ingame", self.ingame)
	print("resumeGame", self.resumeGame)
	print("menuOn", self.menuOn)
	print("inGameOptions", self.inGameOptions)
	print("gameOptions", self.gameOptions)
	print("inOptions", self.inOptions)
	print("inMainMenu", self.inMainMenu)
	print("updateOptions", self.updateOptions)
	print("shadow", self.shadow)
	print("winning", self.winning)
	
	-- Level Selector Booleans
	print("selectWorld", self.selectWorld)
	print("inWorldSelector", self.inWorldSelector)
	print("selectLevel", self.selectLevel)
	print("inLevelSelector", self.inLevelSelector)
	
	-- Touch interface booleans
	print("allowTouch", self.allowTouch)
	print("allowPaneSwitch", self.allowPaneSwitch)
	
	-- Minimap Booleans
	print("allowMiniMap", self.allowMiniMap)
	print("showMiniMap", self.showMiniMap)
	print("isShowingMiniMap", self.isShowingMiniMap)

	-- Collision Booleans
	print("collOn", self.collOn)
	
	-- Game Booleans
	print("inWater", self.inWater)
	print("levelComplete", self.levelComplete)
	print("onIceberg", self.onIceberg)
	print("gRune", self.gRune)
	
	print("locked", self.locked)
	
	print("gameData.mapData.world", self.mapData.world)
	print("gameData.mapData.levelNum", self.mapData.levelNum)
	print("gameData.mapData.pane", self.mapData.pane)
end

return gameData