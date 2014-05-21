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
	name = "hello",
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
	auraEmitter:changeRadius(25)
	physics.setGravity(0,0)
	--player.linearDamping = 1.25
	--player.density = .3
end

--------------------------------------------------------------------------------
-- Change Size - player function that shrinks the player image object
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local function changeSize(player)
	physics.removeBody(player)
	player:scale(0.5,0.5)
	physics.addBody(player, {radius = 15, bounce = .25, density = 0.1}) --, density = 0.7})
	auraEmitter:changeRadius(-25)
	physics.setGravity(0,0)
	--player.linearDamping = 1.25
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
-- Updated by: Marco
--------------------------------------------------------------------------------
local function changeBodyType(event)
	local params = event.source.params
	for check = 1, params.param1.front.numChildren do
		local currObject = params.param1.front[check]
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
		['red'] = {1,0.5,0.5}, 
		['green'] = {0.5,1,0.5},
		['blue'] = {0.5,0.5,1}
	}
    self.color = color
    c = colors[color]
    self.imageObject:setFillColor(c[1],c[2],c[3])
    if auraEmitter == nil then
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
			auraEmitter:moveParticles(self.imageObject.x, self.imageObject.y, self.color)
		else
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
	self.small = false
	local delayShrink = function() return changeBack( self.imageObject ) end
	timer.performWithDelay(100, delayShrink)
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
-- Shrink - player function that calls delay timer for changeSize
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:shrink() 
	self.small = true
	local delayShrink = function() return changeSize( self.imageObject ) end
	timer.performWithDelay(100, delayShrink)
end

--------------------------------------------------------------------------------
-- Slow Time - player function that slows time of moveable objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:slowTime(map)
	for check = 1, map.numChildren do
		if map[check].moveable == true then
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