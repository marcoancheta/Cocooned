--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- player.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--default player prototype
local playerInstance = {
	x=0,
	y=0,
	magnetized='nuetral', -- {negative, nuetral, positive}
	color='white', --listOfColors{?????}
	image = "null",
	name = "hello"
} 


--returns a player instance
function playerInstance:new (o) 
      setmetatable(o, self)
      self.__index = self
      return o
end

--basic function that changes color
function playerInstance:changeColor (color)
      self.color = color
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




 