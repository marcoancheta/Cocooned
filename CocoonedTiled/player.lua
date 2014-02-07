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
--default player prototype
local playerInstance = {
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

} 


local function rotateTransition(imageObject, rotationDelta, timeDelta)
        transition.to( imageObject, { rotation=rotationDelta, time=timeDelta, transition=easing.inOutCubic, tag='rotation' } )
end 

--call this to create a new player, but make sure to change parameters
function create(o)
	o = o or {} -- create object if user does not provide one
	return playerInstance:new(o)
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
function playerInstance:repel ()
		self.imageObject:applyLinearImpulse(2, 2, self.imageObject.x, self.imageObject.y)
		self.imageObject.angularVelocity = 0
end

-- attracts the player if they are near a totem pole
function playerInstance:attract (goTo)
		--self.imageObject:applyLinearImpulse(-1, -1, self.imageObject.x, self.imageObject.y)
		self.imageObject:setLinearVelocity(goTo, goTo, goTo, goTo)
		self.imageObject.angularVelocity = 0
end

function playerInstance:rotate (x,y)
		transition.cancel('rotation')
		angle = (floor(atan2(y, x) * ( 180 / pi))) 
		self.imageObject.rotation = angle +90
end

function playerInstance:addInventory(item) 
	self.inventory:addItem(item)
end

local player  = {
	create = create
}

return player

--[[if gamehasstarted then
		local velX = player1.imageObject.x
		local velY = player1.imageObject.y
		local deltaX = velX-player1.x
		local  deltaY = velY - player1.y
		if deltaX == 0 and deltaY ==0 then
			ball:pause()
		else
			ball:play()
		end
		player1.x = player1.imageObject.x
		player1.y = player1.imageObject.y
		player1.imageObject.isAwake = true
	end]]




 