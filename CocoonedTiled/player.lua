--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- player.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local floor = math.floor
local atan2 = math.atan2
local pi = math.pi

local inventoryMechanic = require("inventoryMechanic")
local gameData = require("gameData")
--default player prototype
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
	speedConst = 10,
	movement="accel",
	deathTimer = nil,
	slowDownTimer = nil,
	speedUpTimer = nil,
	curse = 1,
	escape = "center",
}
print(activateWind) 


local function rotateTransition(imageObject, rotationDelta, timeDelta)
        transition.to( imageObject, { rotation=rotationDelta, time=timeDelta, transition=easing.inOutCubic, tag='rotation' } )
end 

--call this to create a new player, but make sure to change parameters
function create(o)
	o = o or {} -- create object if user does not provide one
	return playerInstance:new(o)
end

function playerInstance:destroy()
	self.imageObject:removeSelf()
	self.imageObject = nil
	self.inventory:destroy()
	self.inventory = nil

end

--returns a player instance
function playerInstance:new (o) 
      	setmetatable(o, self)
    	self.__index = self
    	return o
end

--basic function that changes color
function playerInstance:changeColor (color)
		colors={['white']={1,1,1},['red']={1,0.5,0.5},['green']={0.5,1,0.5},['blue']={0.5,0.5,1}}
		--print(self.color)
    	self.color = color
    	c=colors[color]
    	self.imageObject:setFillColor(c[1],c[2],c[3])
end

-- repels the player if they hit a totem pole
function playerInstance:totemRepel (collideObject)
		print((self.imageObject.x - collideObject.x)/1000)
		self.imageObject:applyLinearImpulse((self.imageObject.x - collideObject.x)/175, (self.imageObject.y - collideObject.y)/175, self.imageObject.x, self.imageObject.y) 
		self.imageObject.angularVelocity = 0
end

-- repels the player if there is wind
function playerInstance:windRepel ()
		self.imageObject:applyLinearImpulse(2, 2, self.imageObject.x, self.imageObject.y)
		self.imageObject.angularVelocity = 0
end

-- attracts the player if they are near a totem pole
function playerInstance:attract (goTo)
		--self.imageObject:applyLinearImpulse(-1, -1, self.imageObject.x, self.imageObject.y)
		self.imageObject:setLinearVelocity(goTo, goTo, goTo, goTo)
		self.imageObject.angularVelocity = 0
end

function playerInstance:shrink()
	self.imageObject:scale(0.6, 0.6)
end

function playerInstance:slowTime(map)
	for check = 1, map.layer["tiles"].numChildren do
		if map.layer["tiles"][check].moveable == true then
			map.layer["tiles"][check].time = 20000
		end
	end
end

function playerInstance:breakWalls(map)
	local timer = timer.performWithDelay(10, changeType)
		  timer.params = {param1 = map}
end

function changeType(event)
	local params = event.source.params
	
	for check = 1, params.param1.layer["tiles"].numChildren do
		if params.param1.layer["tiles"][check].name == "orangeWall" then
			params.param1.layer["tiles"][check].bodyType = "dynamic"
		end
	end
end

function playerInstance:rotate (x,y)
		transition.cancel('rotation')
		angle = (floor(atan2(y, x) * ( 180 / pi))) 
		self.imageObject.rotation = angle +90
end

function playerInstance:addInventory(item, map) 
	self.inventory:addItem(item, map)
end

local player  = {
	create = create
}

return player






 