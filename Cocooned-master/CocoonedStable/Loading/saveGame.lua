--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- saveGame.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Derived from: http://tinyurl.com/opu6wzr
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local json = require("json")

local saveGame = {}

local function gameSave(t, filename)
	local path = system.pathForFile(filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
	
	local test = {
		SFX = t.sfxVolume,
		BGM = t.bgmVolume,
		player = t.player,
	}
	
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
		
        return true
    else
        return false
    end
end

saveGame.gameSave = gameSave

return saveGame