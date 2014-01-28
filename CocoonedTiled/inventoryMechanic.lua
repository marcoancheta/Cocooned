--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- inventoryMehcanic.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local inventoryInstance = {
	items = {}
}

function inventoryInstance:addItem(item)
	print(item)
	table.insert(self.items, item)
end

function inventoryInstance:new (o)
	setmetatable(o, self)
    self.__index = self
	return o
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
