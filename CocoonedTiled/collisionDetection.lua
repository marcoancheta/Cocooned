
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- collisionDetection.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Particle Emitter
--------------------------------------------------------------------------------
local emitter = require("particleEmitter")
local miniMapMechanic = require("miniMap")

--Base emitter props
local radiusRange = 100

local duration = 1200 --800
local startAlpha = 1
local endAlpha = 0
local pImage = nil
local pImageWidth = nil
local pImageHeight = nil
local emitterDensity = 5

--Mortar props
local particleSpeed = 200
local particleEmitterDensity = 2
local particleRadiusRange = 200
local particleThickness = 4
local particleEmitter = emitterLib:createEmitter(radiusRange, particleThickness, duration, startAlpha, endAlpha, pImage, pImageWidth, pImageHeight)



--------------------------------------------------------------------------------
-- Collision Detection Mechanic
--------------------------------------------------------------------------------
function createCollisionDetection(imageObject, player, mapData, map, gui, physics, miniMap) 


  -- function for pre collision detection
  function imageObject:preCollision( event )
 
   local collideObject = event.other
   local targetObject = event.target
   if collideObject.collType == "passThru" then
      print(collideObject.func)
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
   end

   if collideObject.collType == "solid" then
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
      audio.play(wallHitSound)
   end

   if collideObject.collectable == true then
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
      miniMapMechanic.updateMiniMap(mapData, miniMap, map, event.target)
   end
   
   
  end

  --function for collision detection
  function onLocalCollision( self, event )
    local collideObject = event.other
    local targetObject = event.target
    if ( event.phase == "began" ) then
      -- debug print once collision began           
      --print( "began: " .. collideObject.name)

      if collideObject.collType == "solid" then
        local col = require("Objects." .. collideObject.func)
        col.collide(collideObject, player, event, mapData)
      end


      
      -- create particle effect
      if collideObject.collType == "wall" then
       -- timer.performWithDelay(100, emitParticles(collideObject, targetObject, gui, physics))
      end

    elseif ( event.phase == "ended" ) then
      --debug pring once collision ended
      --print( "ended: ")
        
    end
  end

  -- add event listener to collision detection and pre collision detection
  imageObject.collision = onLocalCollision
  imageObject:addEventListener( "collision", imageObject )
  imageObject:addEventListener( "preCollision")

end

function emitParticles(collideObject, targetObject, gui, physics)
  local midX = ( targetObject.x + collideObject.x ) * 0.5
  local midY = ( targetObject.y + collideObject.y ) * 0.5
   for i=1,particleEmitterDensity do
    particleEmitter:emit(gui, midX-20, midY, physics)
  end
end

function changeCollision(imageObject, player, mapData, map, gui, physics, miniMap) 
  imageObject:removeEventListener("collision" , imageObject)
  imageObject:removeEventListener("preCollision")

  createCollisionDetection(imageObject, player, mapData, map, gui, physics, miniMap)
end

function destroyCollision(imageObject)
  imageObject:removeEventListener("collision", imageObject)
  imageObject:removeEventListener("preCollision")
end



--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
local collisionDetection = {
  createCollisionDetection = createCollisionDetection,
  changeCollision = changeCollision,
  destroyCollision = destroyCollision
}

return collisionDetection