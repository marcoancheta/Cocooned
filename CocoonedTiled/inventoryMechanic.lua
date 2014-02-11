--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- inventoryMehcanic.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local inventoryInstance = {
	items = {},
	size = 1
}

function inventoryInstance:addItem(item)
	self.items[1] = item
	print(#self.items)
	self.size = self.size + 1
end

function inventoryInstance:new (o)
	setmetatable(o, self)
    self.__index = self
	return o
end

function inventoryInstance:destroy()
	for i = 1, #self.items do
			self.items[i] = nil
	end
	self.size = nil
end

--call this to create a new player, but make sure to change parameters
function createInventory(o)
	o = o or {} -- create object if user does not provide one
	return inventoryInstance:new(o)
end

local inventoryMechanic = {
	createInventory = createInventory
}

return inventoryMechanic
