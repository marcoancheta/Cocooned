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
-- Game Analytics
--local GA = require("plugin.gameanalytics")

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar);

-- disable sleep screen mode on device
system.setIdleTimer(false)

-- Global Variables
local sCounter = 0

--[[
--Settings
GA.isDebug                   = true
GA.runInSimulator            = false

GA.submitWhileRoaming        = false
GA.waitForCustomUserID       = false
GA.newSessionOnResume        = false

GA.archiveEvents             = true
GA.archiveEventsLimit        = 512      -- kilobytes 

GA.batchRequests             = false
GA.batchRequestsInterval     = 30       -- seconds (minimum 1 second)

-- Built in quality events
GA.submitSystemInfo          = true

-- Built in error events
GA.submitUnhandledErrors     = false
GA.submitMemoryWarnings      = false    -- iOS only!
GA.maxErrorCount             = 20       -- errors per session

-- Built in design events
GA.useStoryboard             = false
GA.submitStoryboardEvents    = false

GA.submitAverageFps          = false
GA.submitAverageFpsInterval  = 30       -- seconds (minimum 5)

GA.submitCriticalFps         = false
GA.submitCriticalFpsInterval = 5        -- seconds (minimum 5)
GA.criticalFpsRange          = 15       -- frames  (minimum 10)

GA.criticalFpsBelow          = display.fps/2 -- half the fps value you set in the config.lua file


-- Initialize game analytics
GA.init ({
    game_key   = '2a94ff4a99f62d49f426ea18a0490ebd',
    secret_key = '98be3f1d7da678b370f3b92f421715c4c9ad95f4',
    build_name = '1.0'
})
]]--

--------------------------------------------------------------------------------
-- Main
--------------------------------------------------------------------------------
-- Updated by: Marco -- removed sprite loading screen
--------------------------------------------------------------------------------
function main(event)
	--[[
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
       
   end
	  -- Remove Splash Screen Listener
      --Runtime:removeEventListener("enterFrame", main)

	  -- End Splash Screen Code
	   
	  -- Begin game details
	  --display.setStatusBar(display.HiddenStatusBar)
	]]

	
	
	local textureFilter = "nearest"
	display.setDefault("minTextureFilter", textureFilter)
	display.setDefault("magTextureFilter", textureFilter)

--------------------------------------------------------------------------------
-- Load Game - function that loads game
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
	local function loadGame()
		-- start core game loop
		require("gameLoop")
	end

	-- start game
	loadGame()

	--for rCorona
	if system.getInfo("environment") == "simulator" then
		local rcorona = require("rcorona")
		rcorona.startServer(8181)
	end
end
 
--------------------------------------------------------------------------------
-- Finish Up - event listener that starts game
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
Runtime:addEventListener( "enterFrame", main )