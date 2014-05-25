--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- font.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Require(s) / Global Variables
--------------------------------------------------------------------------------
local font = {
	TEACHERA = nil
}

--------------------------------------------------------------------------------
-- fontCheck - check to see which fonts exist on system/device
--------------------------------------------------------------------------------
local function check()
	-- FONT CHECK
	local fonts = native.getFontNames()
	for i,fontname in ipairs(fonts) do
		print(fonts[i])
	end
end

--------------------------------------------------------------------------------
-- setupFont - Setup font name for cross-platform devices
--------------------------------------------------------------------------------
local function setupFont()
	if "Win" == system.getInfo("platformName") then
		font.TEACHERA = "Teacher_A"
	elseif "Android" == system.getInfo("platformName") then
		font.TEACHERA = "Teacher_a"
	else
		-- Mac/iOS
		font.TEACHERA = "Teacher_A"
	end
end


--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
font.check = check
font.setupFont = setupFont
		
return font
-- end of font.lua