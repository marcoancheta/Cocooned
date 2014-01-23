--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- main.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Source(s) Cited:
--   Splash Screen Detail - http://developer.coronalabs.com/code/android-friendly-splash-screen-logic
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Global Variables
local sCounter = 0

function main(event)

   sCounter = sCounter + 1
   if( sCounter == 1 ) then
      -- Display splash screen
      splashScreen = display.newImageRect("Default.png", 1500, 800)
      splashScreen.x = 720
      splashScreen.y = 440
   elseif (sCounter > 120) then   -- show splash screen for 120 milliseconds
   
      -- Clear splash screen objects
      if (splashScreen ~= nil) then
           splashScreen:removeSelf()
           splashScreen = nil
      end
       
	  -- Remove Splash Screen Listener
      --Runtime:removeEventListener("enterFrame", main)

	  -- End Splash Screen Code
	   
	  -- Begin game details
	  --display.setStatusBar(display.HiddenStatusBar)

	  local textureFilter = "nearest"
	  display.setDefault("minTextureFilter", textureFilter)
	  display.setDefault("magTextureFilter", textureFilter)

	  local function loadGame()
			require("gameLoop")
	  end

	  loadGame()


	  --for rCorona
	  if system.getInfo("environment") == "simulator" then
			local rcorona = require("rcorona")
			rcorona.startServer(8181)
	  end
	 
   end
end
 
Runtime:addEventListener( "enterFrame", main )