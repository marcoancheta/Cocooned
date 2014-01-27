
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- collisionDetection.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- Collision Detection Mechanic
--------------------------------------------------------------------------------
function createCollisionDetection(imageObject, player, mapData, map) 


  -- function for pre collision detection
  function imageObject:preCollision( event )
 
   local collideObject = event.other
   if collideObject.collType == "passThru" then
      require("Objects." .. collideObject.func)
      collide(collideObject, player, event, mapData)
   end
   
  end

  --function for collision detection
  function onLocalCollision( self, event )
    local collideObject = event.other
    if ( event.phase == "began" ) then
      -- debug print once collision began           
      print( "began: " .. collideObject.name)

      if collideObject.collType == "solid" then
        require("Objects." .. collideObject.func)
        collide(collideObject, player, event, mapData)
      end
      
    elseif ( event.phase == "ended" ) then

      --debug pring once collision ended
      print( "ended: ")
   
    end
  end

  -- add event listener to collision detection and pre collision detection
  imageObject.collision = onLocalCollision
  imageObject:addEventListener( "collision", imageObject )
  imageObject:addEventListener( "preCollision")

end

function changeCollision(imageObject, player, mapData) 
  imageObject:removeEventListener("collision" , imageObject)
  imageObject:removeEventListener("preCollision")

  createCollisionDetection(imageObject, player, mapData)
end



--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
local collisionDetection = {
  createCollisionDetection = createCollisionDetection,
  changeCollision = changeCollision
}

return collisionDetection