
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- collisionDetection.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- collision detection lua operates the collision detection for all objects
-- when an object collides or before it collides, the objects collide function is
-- called and does their own functions upon collision
-- for example, before a red aura collides with player, its collision is turned 
-- off and the player's color is changed


--------------------------------------------------------------------------------
-- Collision Detection Mechanic
--------------------------------------------------------------------------------
-- Updated by: Andrew (moved water collision to be spread out across, precollision, begin collision, and post collision)
--------------------------------------------------------------------------------
-- creates the collision detection for that pane
function createCollisionDetection(imageObject, player, mapData, map) 

  -- function for pre collision 
  -- before the object collides, call its own collide function
  function imageObject:preCollision( event )
 
  -- if the object is a passThru, calls it's collide function
   local collideObject = event.other
   if collideObject.collType == "passThru" and collideObject.name ~= "water" then
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
   end

   -- if the object is a solid, call it's collide function
   if collideObject.collType == "solid" then
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
   end

  -- if the object is a collectable, call it's collide function
  if collideObject.collectable == true then
      local col = require("Objects." .. collideObject.func)
      col.collide(collideObject, player, event, mapData, map)
      audio.play(wallHitSound)
   end

    --let the ball go through water
    if collideObject.name == "water" then
      -- disabled collision
      event.contact.isEnabled = false
    end
   

  end

  --function for collision detection
  -- when an object collides, call its own collide function
  function onLocalCollision( self, event )

    -- save the collide object
    local collideObject = event.other

    -- when collision began, do this
    if ( event.phase == "began" ) then

      -- if the object is a solid, call it's function
      if collideObject.collType == "solid" then
        local col = require("Objects." .. collideObject.func)
        col.collide(collideObject, player, event, mapData)
      end
      
      -- create particle effect
      if collideObject.collType == "wall" then
        --timer.performWithDelay(100, emitParticles(collideObject, targetObject, gui, physics))
      end

      --when the player collides with water, make sure that shook is false and call the water collision function.
      if collideObject.name == "water" then
        player.shook = false
        local col = require("Objects." .. collideObject.func)
        col.collide(collideObject, player, event, mapData, map)
      end

    -- when collision ends, do this
    elseif ( event.phase == "ended" ) then
      --if the player shook, and the collision with water ended
      if collideObject.name == "water" and player.shook == true then
        player.movement = "accel"
        player.shook = false
      end
    end
  end

  -- add event listener to collision detection and pre collision detection
  imageObject.collision = onLocalCollision
  imageObject:addEventListener( "collision", imageObject )
  imageObject:addEventListener( "preCollision")

end

--------------------------------------------------------------------------------
-- Collisison Detection - change the collision detection
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
-- changes the collision detection for all objects in new pane
function changeCollision(imageObject, player, mapData, map) 

  -- remove old collision detection event listeners
  imageObject:removeEventListener("collision" , imageObject)
  imageObject:removeEventListener("preCollision")

  -- create new collision detection event listeners
  createCollisionDetection(imageObject, player, mapData, map)
end

--------------------------------------------------------------------------------
-- Collision Detection - remove all collision detection event listeners
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function destroyCollision(imageObject)
  imageObject:removeEventListener("collision" , imageObject)
  imageObject:removeEventListener("preCollision")
end

--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
local collisionDetection = {
  createCollisionDetection = createCollisionDetection,
  changeCollision = changeCollision,
  destroyCollision = destroyCollision
}

return collisionDetection

-- end of collisionDetection.lua