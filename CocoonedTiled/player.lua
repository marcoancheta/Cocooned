--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- player.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
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
	inventory = inventoryMechanic.createInventory()
} 


--returns a player instance
function playerInstance:new (o) 
      	setmetatable(o, self)
    	self.__index = self
    	--inventory = inventoryMechanic.createInventory{}
    	return o
end

--basic function that changes color
function playerInstance:changeColor (color)
		colors={['white']={0,0,0},['red']={1,0.5,0.5},['green']={0.5,1,0.5},['blue']={0.5,0.5,1}}
		print(self.color)
    	self.color = color
    	c=colors[color]
    	self.imageObject:setFillColor(c[1],c[2],c[3])
end

function playerInstance:addInventory(item)
	if item.name == "key" then 
		self.inventory:addItem(item)
	end
end
 
--call this to create a new player, but make sure to change parameters
function create(o)
	o = o or {} -- create object if user does not provide one
	return playerInstance:new(o)
end

local player  = {
	create = create
}

return player




 