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
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -720, 182  ,  -720, -48  ,  -688, -20  ,  -688, 157  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -636, 2  ,  -636, 156  ,  -687, 156  ,  -687, -19  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -600, 149  ,  -634, 156  ,  -634, 2  ,  -600, -3  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -598, 148  ,  -599, -2  ,  -571.190475463867, -1.33334350585938  ,  -551, 15  ,  -551, 154  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -503, 38  ,  -503, 181  ,  -550, 153  ,  -550, 17  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -451, 168  ,  -502, 182  ,  -502, 37  ,  -451, 37  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -415, 31  ,  -415, 178  ,  -450, 168  ,  -450, 35  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -368, 168  ,  -414, 176  ,  -414, 34  ,  -368, 28  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -326, 164  ,  -366, 167  ,  -366, 25  ,  -326, 25  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -287, 162  ,  -325, 167  ,  -325, 22  ,  -286, 15  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -240, 161  ,  -286, 164  ,  -287, 13  ,  -240, 12  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -199, 148  ,  -238, 158  ,  -238, 12  ,  -198, 12  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -197, 11  ,  -157, 11  ,  -157, 129  ,  -198, 145  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -156, 10  ,  -114, 0  ,  -114, 120  ,  -157, 132  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -113, 119  ,  -113, -2  ,  -74, 10  ,  -74, 115  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -720, 432  ,  -720, 392  ,  -680, 392  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -9, 45  ,  6, 80  ,  -9, 111  ,  -72, 115  ,  -72, 12  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -718, -371  ,  -658, -388  ,  -658, -265  ,  -718, -244  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -609, -266  ,  -657, -266  ,  -657, -386  ,  -609, -401  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -549, -250  ,  -608, -266  ,  -608, -399  ,  -549, -428  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -493, -433  ,  -493, -241  ,  -546, -251  ,  -546, -426  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -491, -244  ,  -490, -433  ,  -441, -431  ,  -441, -238  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -371, -265  ,  -411, -237  ,  -439, -243  ,  -439, -431  ,  -372, -430  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -315, -287  ,  -369, -267  ,  -370, -430  ,  -315, -432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -274, -288  ,  -314, -284  ,  -314, -432  ,  -274, -432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -273, -287  ,  -272, -432  ,  -204, -432  ,  -203, -268  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -137, -431  ,  -137, -272  ,  -202, -270  ,  -202, -433  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -85, -275  ,  -136, -274  ,  -136, -433  ,  -85, -432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -45, -388  ,  -83, -431  ,  -33, -431  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -83, -431  ,  -32, -329  ,  -25, -306  ,  -83, -277  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -32, -329  ,  -83, -431  ,  -45, -388  }
                    }
                    
                    
                    
		}
		
		, 
		["R"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -650, 432  ,  -720, 432  ,  -720, 213  ,  -650, 102  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -618, 432  ,  -649, 432  ,  -649, 99  ,  -617, 58  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -552, 60  ,  -552, 432  ,  -615, 432  ,  -616, 59  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -509, 83  ,  -465, 221  ,  -550, 431  ,  -550, 60  ,  -523.571426391602, 61.7619018554688  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -550, 431  ,  -465, 221  ,  -465, 431  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -366, 255  ,  -366, 430  ,  -464, 430  ,  -464, 223  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -289, 431  ,  -364, 431  ,  -364, 254  ,  -289, 246  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -221, 432  ,  -288, 431  ,  -288, 241  ,  -221, 236  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -159, 432  ,  -220, 432  ,  -220, 236  ,  -159, 232  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -95, 432  ,  -158, 432  ,  -158, 230  ,  -95, 225  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -43, 432  ,  -94, 432  ,  -94, 227  ,  -43, 222  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   25, 432  ,  -40, 432  ,  -40, 222  ,  25, 217  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   85, 216  ,  85, 432  ,  26, 432  ,  26, 216  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   87, 432  ,  87, 216  ,  141, 216  ,  142, 432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   205, 224  ,  205, 431  ,  142, 431  ,  142, 216  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   273, 239  ,  273, 432  ,  207, 432  ,  206, 224  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   274, 432  ,  274, 240  ,  346, 241  ,  348, 432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   413, 430  ,  349, 430  ,  348, 241  ,  412, 235  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   476, 261  ,  476, 432  ,  414, 432  ,  413, 236  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   477, 433  ,  478, 263  ,  545, 284  ,  545, 433  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   611, 290  ,  611, 430  ,  546, 429  ,  545, 285  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   670, 431  ,  612, 432  ,  612, 290  ,  671, 279  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   670, 277  ,  721, 258  ,  722, 433  ,  670, 431  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -680, -433  ,  -679, -249  ,  -718, -281  ,  -720, -433  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -638, -432  ,  -638, -239  ,  -678, -248  ,  -678, -432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -593, -433  ,  -594, -238  ,  -637, -241  ,  -637, -433  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -590, -432  ,  -550, -432  ,  -550, -243  ,  -591, -238  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -510, -250  ,  -548, -244  ,  -549, -432  ,  -509, -432  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -455, -300  ,  -509, -252  ,  -508, -431  ,  -454, -432  }
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

