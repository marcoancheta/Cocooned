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
	-- THIS FUCKING DOES NOTHING:
	runes = {},
	runeSize = 1,
}

local wispAmount = 0

--------------------------------------------------------------------------------
-- Add Item - function that adds item name to inventory table
--------------------------------------------------------------------------------
function inventoryInstance:addItem(item, map)
	self.items[self.size] = item.name
	print("add inventory", #self.items, item.name)
	self.size = self.size + 1
	wispAmount = self.size
	print("self.size", self.size)
end

--------------------------------------------------------------------------------
-- Add Rune - function that adds rune name to inventory table
--------------------------------------------------------------------------------
function inventoryInstance:addRune(item, map, mapData)
	print("mapData.pane", mapData.pane)
	print("self.runeSize", self.runeSize)
	print("item.name", item.name)
	self.runes[mapData.pane][self.runeSize] = item.name
	print(self.name)
	print("self.runes["..mapData.pane.."]", self.runes[mapData.pane][1])
	print("add inventory", #self.runes, item.name)
	self.runeSize = self.runeSize + 1
end


function inventoryInstance:resetRunes()
	self.runeSize = 1
	self.size = 1
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
-- Clear - function that clears inventory table
--------------------------------------------------------------------------------
function inventoryInstance:clear()
	-- set all items in inventory to nil to remove
	self.items = {}
	self.size = 1
	-- set all runes in inventory to nil to remove
	self.runes = {}
	self.runeSize = 1
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
	createInventory = createInventory,
	inventoryInstance = inventoryInstance,
	wispAmount = wispAmount
}

-- return inventoryMechanic.lua
return inventoryMechanic
