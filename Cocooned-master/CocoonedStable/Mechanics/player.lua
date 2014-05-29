--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- player.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local floor = math.floor
local atan2 = math.atan2
local pi = math.pi
local auraDuration = 1000
local auraDensity = 3
local auraRange = 12
local auraEmitter = nil
-- inventory mechanic (inventoryMechanic.lua)
local inventoryMechanic = require("Mechanics.inventoryMechanic")
local particle_lib = require("Mechanics.auraEmitter")
-- GameData variables/booleans (gameData.lua)
local gameData = require("Core.gameData")
local sound = require("sound")

--------------------------------------------------------------------------------
-- Player Instance - player instance table that holds all properties
--------------------------------------------------------------------------------
-- Updated by: Derrick (re-organizing)
-- Previous: Andrew added xForce and yForce used in speedUp in gameLoop
--------------------------------------------------------------------------------
local playerInstance = {
	-- Strings
	imageObject = "",
	magnetized = "neutral", -- {negative, neutral, positive}
	color = "white",
	image = "null",
	--name = "hello",
	movement = "accel",
	--escape = "center",
	name = "kipcha",
	
	-- Int's
	x = 0,
	y = 0,
	tapPosition = 0,
	xGrav = 0,
	yGrav = 0,
	xForce = 0,
	yForce = 0,
	bounce = .25,
	curse = 1,
	maxSpeed = 6,
	speedConst = 5,
	defaultSpeed = 7,
	radius = 38, --default radius

	--waterEscape variables
	lastPositionX = nil,
	lastPositionY = nil,
	lastSavePoint = nil,
	lastPositionSaved = false,
	onLand = true,
	switchPanes = nil,
	miniMap = nil,
	
	-- Booleans
	deathTimer = nil,
	slowDownTimer = nil,
	speedUpTimer = nil,
	deathScreen = nil,
	small = false,
	breakable = false,
	shook = false,
	
	-- Functions
	inventory = inventoryMechanic.createInventory(),
	
	-- Arrays
	hasItem = {},
}

--------------------------------------------------------------------------------
-- Create Player
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
--call this to create a new player, but make sure to change parameters
local function create(o)
	o = o or {} -- create object if user does not provide one
	return playerInstance:new(o)
end

--------------------------------------------------------------------------------
-- Change Back - player function that changes image object back to normal size
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function changeBack(player)
	physics.removeBody(player)
	player:scale(2,2)
	physics.addBody(player, {radius = 36, bounce = .25, density = 0.3})
	physics.addBody(player, {radius = 38, bounce = .25, density = 0.3})
	if auraEmitter ~= nil then
		--changes the radius range of the aura particles to match up with the ball
		auraEmitter:changeRadius(25)
	end
	--player.linearDamping = 1.25
	print("un-shrinking the player back to normal size")
end

--------------------------------------------------------------------------------
-- Change Size - player function that shrinks the player image object
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function changeSize(player)
	physics.removeBody(player)
	player:scale(0.5,0.5)
	physics.addBody(player, {radius = 15, bounce = .25, density = 0.2}) --, density = 0.7})
	if auraEmitter ~= nil then
		--changes the radius range of the aura particles to match up with the ball
		auraEmitter:changeRadius(-25)
	end
	physics.setGravity(0,0)
	--player.linearDamping = 1.25
	print("SIZE")
end

--------------------------------------------------------------------------------
-- Change Type - player function that changes properties of objects to breakable
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
--[[
local function changeType(event)
	local params = event.source.params
	
	for check = 1, params.param1.layer["tiles"].numChildren do
		if params.param1.layer["tiles"][check].name == "orangeWall" then
			params.param1.layer["tiles"][check].bodyType = "dynamic"
		end
	end
end
]]--



--------------------------------------------------------------------------------
-- Change Body Type - player function that changes properties of objects to moveable
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function changeBodyType(event)
	local params = event.source.params
	for check = 1, params.param1.front.numChildren do
		local currObject = params.param1.front[check]
		--enables the movement of the switch walls and free icebergs when player gets the specific rune
		if  string.sub(currObject.name,1,10) == "switchWall" or(string.sub(currObject.name,1,12) == "fixedIceberg" and currObject.movement == "free") then
			params.param1.front[check].bodyType = "dynamic"
 			params.param1.front[check].isFixedRotation = true
		end
	end
end


--------------------------------------------------------------------------------
-- Destroy - function that destroys player table and removes properties
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:destroy()
	-- remove deathScreen image object
	if self.deathScreen ~= nil then
		self.deathScreen:pause()
		self.deathScreen:removeSelf()
		self.deathScreen = nil
	end

	-- remove player image object
	self.imageObject:removeSelf()
	self.imageObject = nil

	-- destroy inventory of player
	self.inventory:destroy()
	self.inventory = nil
end

--------------------------------------------------------------------------------
-- New - creates new player object table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:new(o) 
    setmetatable(o, self)
    self.__index = self
    return o
end

--------------------------------------------------------------------------------
-- Change Color - player function that changes player's color
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function playerInstance:changeColor(color)
	local colors ={
		['white'] = {1,1,1},
		['red'] = {255*0.00392156862, 116*0.00392156862, 123*0.00392156862}, 
		['green'] = {40*0.00392156862, 196*0.00392156862, 58*0.00392156862},
		['blue'] = {73*0.00392156862, 213*0.00392156862, 218*0.00392156862}
	}
    self.color = color
    c = colors[color]
    --changes the color of the player
    self.imageObject:setFillColor(c[1],c[2],c[3])
    if auraEmitter == nil then
    	--starts up the aura emitter, gets updated in movement 
    	auraEmitter=auraEmitterLib:createEmitter(range, duration, self, 1, 0, nil, nil, nil, 20)
    end
end

--------------------------------------------------------------------------------
-- Update aura - updates location and color of aura
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function playerInstance:updateAura()
	if auraEmitter ~= nil then
		if self.color ~= "white" then
			--updates positiion of the particles
			auraEmitter:moveParticles(self.imageObject.x, self.imageObject.y, self.color)
		else
			--hides the particles if player changes color back to white
			auraEmitter:hideParticles()
		end
	end
end

--------------------------------------------------------------------------------
-- Delete Aura - deletes aura
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function playerInstance:deleteAura()
	if auraEmitter ~= nil then
		auraEmitter:destroy()
		auraEmitter=nil
	end
end

--------------------------------------------------------------------------------
-- Totem Repel - player function that repels player object from totem
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:totemRepel(collideObject)
	--print((self.imageObject.x - collideObject.x)/175)
	self.imageObject:applyLinearImpulse((self.imageObject.x - collideObject.x)/175, (self.imageObject.y - collideObject.y)/175, self.imageObject.x, self.imageObject.y) 
	self.imageObject.angularVelocity = 0
end

--------------------------------------------------------------------------------
-- Wind Repel - player function that repels player object from wind
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:windRepel(rX, rY)
	self.imageObject:applyLinearImpulse((self.imageObject.x - (self.imageObject.x+rX))/175, (self.imageObject.y - (self.imageObject.y+rY))/175, self.imageObject.x, self.imageObject.y)
	self.imageObject.angularVelocity = 0
end

--------------------------------------------------------------------------------
-- Attract - player function that attracts player object to totem
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:attract(goTo)
	--self.imageObject:applyLinearImpulse(-1, -1, self.imageObject.x, self.imageObject.y)
	self.imageObject:setLinearVelocity(goTo, goTo, goTo, goTo)
	self.imageObject.angularVelocity = 0
end


--------------------------------------------------------------------------------
-- UnShrink - player function that calls delay timer for changeBack
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:unshrink()
	--local delayShrink = function() return 
	--changeBack( self.imageObject )-- end
	--timer.performWithDelay(100, delayShrink)
	
	if self.small == true then
		physics.removeBody(self.imageObject)
		self.imageObject:scale(2,2)
		physics.addBody(self.imageObject, {radius = 38, friction=0, bounce = .25, density = 0.3})
		if auraEmitter ~= nil then
			auraEmitter:changeRadius(25)
		end
		self.imageObject.linearDamping = 1.25
		print("un-shrinking the player back to normal size")
		self.small = false
	end
end

--------------------------------------------------------------------------------
-- Shrink - player function that calls delay timer for changeSize
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:shrink() 
	--local delayShrink = function() return 
	--changeSize( self.imageObject )-- end
	--timer.performWithDelay(100, delayShrink)
	if self.small == false then
		physics.removeBody(self.imageObject)
		self.imageObject:scale(0.5,0.5)
		physics.addBody(self.imageObject, {radius = 15, bounce = .25, density = 0.2}) --, density = 0.7})
		if auraEmitter ~= nil then
			auraEmitter:changeRadius(-25)
		end
		--player.linearDamping = 1.25
		print("SIZE")
		self.small = true
	end
end

--------------------------------------------------------------------------------
-- Rotate Transition - function that rotates player image object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function rotateTransition(imageObject, rotationDelta, timeDelta)
    transition.to(imageObject, {rotation=rotationDelta, time=timeDelta, transition=easing.inOutCubic, tag='rotation' } )
end 

--------------------------------------------------------------------------------
-- Slow Time - player function that slows time of moveable objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:slowTime(map)
	for check = 1, map.numChildren do
		if map[check].moveable == true and map[check].name ~= "player" then
			map[check].time = 20000
		end
	end
end

--------------------------------------------------------------------------------
-- Break Walls - player function that calls delay timer for changeType
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:breakWalls(map)
	self.breakable = true
	local timer = timer.performWithDelay(100, changeType)
		  timer.params = {param1 = map}
end

--------------------------------------------------------------------------------
-- Move Walls - player function that calls delay timer for changeBodyType
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:moveWalls(gui)
	local timer = timer.performWithDelay(100, changeBodyType)
		  timer.params = {param1 = gui}
end

--------------------------------------------------------------------------------
-- Rotate - player function that rotates image object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:rotate (x,y)
	transition.cancel('rotation')
	angle = (floor(atan2(y, x)*( 180 / pi))) 
	self.imageObject.rotation = angle + 90
end

--function playerInstance:saveSelf()
--
--end

--------------------------------------------------------------------------------
-- Death - player function that kills player and respawns
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function killPlayer(player, mapData, gui)
	print("I'm dying in pane " .. mapData.pane)
	player.lastPositionSaved = false
	player.shook = false
	player.onLand = true
	gameData.inWater = false
	gameData.allowPaneSwith = true
	gameData.onIceberg = false
	gameData.collOn = false

	local waterCol = require("Objects.collision.waterCollision")
	waterCol.reset()

	player.imageObject.alpha = 1
	player.imageObject.linearDamping = 1.25
	player.imageObject:setLinearVelocity(0,0)
	
	if player.lastPositionX == -100 then
		player.imageObject.x = player.lastSavePoint.x
		player.imageObject.y = player.lastSavePoint.y
		if player.lastSavePoint.moveable then
			print("this guy is an iceberg")
		end
	else
		player.imageObject.x = player.lastPositionX
		player.imageObject.y = player.lastPositionY
	end

	if player.lastSavePoint.pane ~= mapData.pane then
		local tempPane = mapData.pane
		mapData.pane = player.lastSavePoint.pane
		print("I gotta move panes!!")
		player.switchPanes.playTransition(tempPane, player.miniMap, mapData, gui, player)
	else
		print("I gotta turn collision ON!")
		local function turnCollOn() gameData.collOn = true end
		timer.performWithDelay(100, turnCollOn)
	end

end

--------------------------------------------------------------------------------
-- Death Timer - player function that kills player if in water for too long
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:startDeathTimer (mapData, gui)
	print("Starting TIMER!!!!! HURRY!!")
	local function passParams() killPlayer(self, mapData, gui) end
	self.deathTimer = timer.performWithDelay(3000, passParams)
end

--------------------------------------------------------------------------------
-- Stop Death Timer - player function that stops player from dying
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:stopDeathTimer ()
	if self.deathTimer then
		timer.cancel(self.deathTimer)
	end
end

--------------------------------------------------------------------------------
-- Add Inventory - player function that adds items to inventory table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:addInventory(item, map) 
	self.inventory:addItem(item, map)
end

function playerInstance:resetRune()
	self.inventory:resetRunes();
end

--------------------------------------------------------------------------------
-- Add Rune - player function that adds rune to inventory rune table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:addRune(item, map)
	self.inventory:addRune(item, map)
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local player  = {
	create = create,
	changeBack = changeBack,
	changeSize = changeSize,
	changeBodyType = changeBodyType
}

return player
-- end of player.lua