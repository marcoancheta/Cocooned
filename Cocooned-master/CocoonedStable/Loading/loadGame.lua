--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- loadGame.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Derived from: http://tinyurl.com/opu6wzr
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local json = require("json")

local loadGame = {}

local function gameLoad(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
	
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        myTable = json.decode(contents);
		print(contents)
        io.close( file )
        return myTable 
    end
	
	print("file", file)
	
    return nil
end

loadGame.gameLoad = gameLoad

return loadGame