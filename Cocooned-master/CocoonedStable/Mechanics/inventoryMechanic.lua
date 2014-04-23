--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- inventoryMehcanic.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- mechanic creates an inventory table for players

--------------------------------------------------------------------------------
-- Inventory Instance - inventory object table
--------------------------------------------------------------------------------
local inventoryInstance = {
	items = {},
	size = 1,
	runes = {},
	runeSize = 1
}


--------------------------------------------------------------------------------
-- Add Item - function that adds item name to inventory table
--------------------------------------------------------------------------------
function inventoryInstance:addItem(item, map)
	self.items[self.size] = item.name
	print("add inventory", #self.items, item.name)
	self.size = self.size + 1
end

--------------------------------------------------------------------------------
-- Add Rune - function that adds rune name to inventory table
--------------------------------------------------------------------------------
function inventoryInstance:addRune(item, map)
	self.runes[self.size] = item.name
	print("add inventory", #self.runes, item.name)
	self.runeSize = self.runeSize + 1
end


function inventoryInstance:resetRunes()
	self.runeSize = 1
end
--------------------------------------------------------------------------------
-- New - function that creates a new iventory table
--------------------------------------------------------------------------------
function inventoryInstance:new (o)
	setmetatable(o, self)
    self.__index = self
	return o
end

--------------------------------------------------------------------------------
-- Destroy - function that destroys inventory table
--------------------------------------------------------------------------------
function inventoryInstance:destroy()

	-- set all items in inventory to nil to remove
	for i = 1, #self.items do
			self.items[i] = nil
	end
	self.size = nil

	-- set all runes in inventory to nil to remove
	for i = 1, #self.runes do
			self.runes[i] = nil
	end
	self.runeSize = nil

end

--------------------------------------------------------------------------------
-- Create Inventory
--------------------------------------------------------------------------------
--call this to create a new inventory, but make sure to change parameters
local function createInventory(o)
	o = o or {} -- create inventory if user does not provide one
	return inventoryInstance:new(o)
end

--------------------------------------------------------------------------------
-- Finish Up
--------------------------------------------------------------------------------
local inventoryMechanic = {
	createInventory = createInventory
}

-- return inventoryMechanic.lua
return inventoryMechanic
