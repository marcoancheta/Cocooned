-- This file is for use with Corona(R) SDK
--
-- This file is automatically generated with PhysicsEdtior (http://physicseditor.de). Do not edit
--
-- Usage example:
--			local scaleFactor = 1.0
--			local physicsData = (require "shapedefs").physicsData(scaleFactor)
--			local shape = display.newImage("objectname.png")
--			physics.addBody( shape, physicsData:get("objectname") )
--

-- copy needed functions to local scope
local unpack = unpack
local pairs = pairs
local ipairs = ipairs

local M = {}

function M.physicsData(scale)
	local physics = { data =
	{ 
		
		["M"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -309, 252  ,  -310, 303  ,  -354, 255  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   720, 432  ,  -247, 432  ,  368, 269  ,  597, 277  ,  720, 311  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -274, 246  ,  -185, 247  ,  -262, 343  ,  -292, 339  ,  -310, 303  ,  -309, 252  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   368, 269  ,  -247, 432  ,  -201, 399  ,  193, 224  ,  247, 212  ,  338, 205  ,  361, 228  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -145, 243  ,  -27, 244  ,  -262, 343  ,  -185, 247  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   193, 224  ,  -27, 244  ,  -6, 226  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   193, 224  ,  -243, 344  ,  -262, 343  ,  -27, 244  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -243, 344  ,  193, 224  ,  -196, 372  ,  -229, 354  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -196, 372  ,  193, 224  ,  -201, 399  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   581, -276  ,  506, -285  ,  -152, -431  ,  720, -432  ,  720, -268  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   -278, -361  ,  -152, -431  ,  58, -288  ,  -92, -278  ,  -177, -285  ,  -223, -299  ,  -278, -321  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   506, -285  ,  395, -278  ,  58, -288  ,  -152, -431  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   207, -266  ,  395, -278  ,  315, -254  ,  257, -253  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = -1 },
                    shape = {   58, -288  ,  395, -278  ,  207, -266  }
                    }
                    
                    
                    
		}
		
	} }

        -- apply scale factor
        local s = scale or 1.0
        for bi,body in pairs(physics.data) do
                for fi,fixture in ipairs(body) do
                    if(fixture.shape) then
                        for ci,coordinate in ipairs(fixture.shape) do
                            fixture.shape[ci] = s * coordinate
                        end
                    else
                        fixture.radius = s * fixture.radius
                    end
                end
        end
	
	function physics:get(name)
		return unpack(self.data[name])
	end

	function physics:getFixtureId(name, index)
                return self.data[name][index].pe_fixture_id
	end
	
	return physics;
end

return M

