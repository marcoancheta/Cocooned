
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- collisionDetection.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Collision Detection Mechanic
--------------------------------------------------------------------------------
function createCollisionDetection(imageObject, player) 

  -- function for pre collision detection
  function imageObject:preCollision( event )
 
   local collideObject = event.other
    if ( collideObject.collType == "passThru" ) then
      event.contact.isEnabled = false  --disable this specific collision!
      player:changeColor('blue')  -- change color of player
    end
  end

  --function for collision detection
  function onLocalCollision( self, event )
    if ( event.phase == "began" ) then

      -- debug print once collision began           
      print( "began: " .. event.other.name)
   
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

function changeCollision(player) 
  player:removeEventListener("collision" , player)
  player:removeEventListener("preCollision")

  createCollisionDetection(player)
end



--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
local collisionDetection = {
  createCollisionDetection = createCollisionDetection,
  changeCollision = changeCollision
}

return collisionDetection