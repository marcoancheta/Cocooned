--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- player.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua file that creates player object tables and its functionality

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local floor = math.floor
local atan2 = math.atan2
local pi = math.pi
-- inventory mechanic (inventoryMechanic.lua)
local inventoryMechanic = require("inventoryMechanic")
-- GameData variables/booleans (gameData.lua)
local gameData = require("gameData")


--------------------------------------------------------------------------------
-- Player Instance - player instance table that holds all properties
--------------------------------------------------------------------------------
-- Updated by: Andrew added xForce and yForce used in speedUp in gameloop
--------------------------------------------------------------------------------
playerInstance = {
	x=0,
	y=0,
	magnetized='nuetral', -- {negative, nuetral, positive}
	color='white',
	image = 'null',
	name = 'hello',
	radius = 38, --default radius
	bounce = .25,
	imageObject = '',
	hasItem={},
	tapPosition=0,
	inventory = inventoryMechanic.createInventory(),
	xGrav = 0,
	yGrav = 0,
	xForce = 0,
	yForce = 0,
	speedConst = 10,
	maxSpeed = 6,
	movement="accel",
	deathTimer = nil,
	slowDownTimer = nil,
	speedUpTimer = nil,
	deathScreen = nil,
	curse = 1,
	escape = "center",
	small = false,
	breakable = false,
	shook = false,
	defaultSpeed = 10
}

--------------------------------------------------------------------------------
-- Rotate Transition - function that rotates player image object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local function rotateTransition(imageObject, rotationDelta, timeDelta)
        transition.to( imageObject, { rotation=rotationDelta, time=timeDelta, transition=easing.inOutCubic, tag='rotation' } )
end 

--------------------------------------------------------------------------------
-- Create Player
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
--call this to create a new player, but make sure to change parameters
function create(o)
	o = o or {} -- create object if user does not provide one
	return playerInstance:new(o)
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
function playerInstance:new (o) 
      	setmetatable(o, self)
    	self.__index = self
    	return o
end

--------------------------------------------------------------------------------
-- Change Color - player function that changes player's color
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:changeColor (color)
		colors={['white']={1,1,1},['red']={1,0.5,0.5},['green']={0.5,1,0.5},['blue']={0.5,0.5,1}}
		--print(self.color)
    	self.color = color
    	c=colors[color]
    	self.imageObject:setFillColor(c[1],c[2],c[3])
end

--------------------------------------------------------------------------------
-- Totem Repel - player function that repels player object from totem
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:totemRepel (collideObject)
		print((self.imageObject.x - collideObject.x)/1000)
		self.imageObject:applyLinearImpulse((self.imageObject.x - collideObject.x)/175, (self.imageObject.y - collideObject.y)/175, self.imageObject.x, self.imageObject.y) 
		self.imageObject.angularVelocity = 0
end

--------------------------------------------------------------------------------
-- Wind Repel - player function that repels player object from wind
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:windRepel (rX, rY)
		self.imageObject:applyLinearImpulse((self.imageObject.x - (self.imageObject.x+rX))/175, (self.imageObject.y - (self.imageObject.y+rY))/175, self.imageObject.x, self.imageObject.y)
		self.imageObject.angularVelocity = 0
end

--------------------------------------------------------------------------------
-- Attract - player function that attracts player object to totem
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:attract (goTo)
		--self.imageObject:applyLinearImpulse(-1, -1, self.imageObject.x, self.imageObject.y)
		self.imageObject:setLinearVelocity(goTo, goTo, goTo, goTo)
		self.imageObject.angularVelocity = 0
end

--------------------------------------------------------------------------------
-- Change Back - player function that changes image object back to normal size
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function changeBack(player)
	physics.removeBody(player)
	player:scale(2,2)
	physics.addBody(player, {radius = 36, bounce = .25})
	physics.setGravity(0,0)
	player.linearDamping = 1.25
	player.density = .3
end

--------------------------------------------------------------------------------
-- UnShrink - player function that calls delay timer for changeBack
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:unshrink()
	self.small = false
	local delayShrink = function() return changeBack( self.imageObject ) end
	timer.performWithDelay(20, delayShrink)
end


--------------------------------------------------------------------------------
-- Change Size - player function that shrinks the player image object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function changeSize(player)
	physics.removeBody(player)
	player:scale(0.5,0.5)
	physics.addBody(player, {radius = 10, bounce = .25, density = 0.7})
end

--------------------------------------------------------------------------------
-- Shrink - player function that calls delay timer for changeSize
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:shrink() 
	self.small = true
	local delayShrink = function() return changeSize( self.imageObject ) end
	timer.performWithDelay(20, delayShrink)
end

--------------------------------------------------------------------------------
-- Slow Time - player function that slows time of moveable objects
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:slowTime(map)
	for check = 1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].moveable == true then
			map.layer["tiles"][check].time = 20000
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
	local timer = timer.performWithDelay(10, changeType)
		  timer.params = {param1 = map}
end

--------------------------------------------------------------------------------
-- Change Type - player function that changes properties of objects to breakable
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function changeType(event)
	local params = event.source.params
	
	for check = 1, params.param1.layer["tiles"].numChildren do
		if params.param1.layer["tiles"][check].name == "orangeWall" then
			params.param1.layer["tiles"][check].bodyType = "dynamic"
		end
	end
end


--------------------------------------------------------------------------------
-- Move Walls - player function that calls delay timer for changeBodyType
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:moveWalls(map)
	self.breakable = true
	local timer = timer.performWithDelay(10, changeBodyType)
		  timer.params = {param1 = map}
end

--------------------------------------------------------------------------------
-- Change Body Type - player function that changes properties of objects to moveable
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function changeBodyType(event)
	local params = event.source.params
	for check = 1, params.param1.layer["tiles"].numChildren do
		currName = string.sub(params.param1.layer["tiles"][check].name,1,10)
		if  currName == "switchWall" then
			params.param1.layer["tiles"][check].bodyType = "dynamic"
 			params.param1.layer["tiles"][check].isFixedRotation = true
		end
	end
end


--------------------------------------------------------------------------------
-- Rotate - player function that rotates image object
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:rotate (x,y)
		transition.cancel('rotation')
		angle = (floor(atan2(y, x) * ( 180 / pi))) 
		self.imageObject.rotation = angle +90
end

--------------------------------------------------------------------------------
-- Add Inventory - player function that adds items to inventory table
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function playerInstance:addInventory(item, map) 
	self.inventory:addItem(item, map)
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
	create = create
}

return player

-- end of player.lua




 