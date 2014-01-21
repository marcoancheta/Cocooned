
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
      if (collideObject.collectable == true) then
        print(collideObject.name)
        player:addInventory(collideObject)
        collideObject:removeSelf( )
      end
     --[[ Magnetism: repel the ball when colliding with magnetized wall
     if (collideObject.name == "icewall") then
        print( "ran into iceWall")
        imageObject:applyLinearImpulse(.5, .5, imageObject.x)
        if(collideObject.name == "magnet") then
          collideObject:removeSelf()
        end
      end
      ]]--
    end
  end

  --function for collision detection
  function onLocalCollision( self, event )
    local collideObject = event.other
    if ( event.phase == "began" ) then

      -- debug print once collision began           
      print( "began: " .. collideObject.name)
      -- check to see if key is in inventory 
      
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

function changeCollision(imageObject, player) 
  imageObject:removeEventListener("collision" , imageObject)
  imageObject:removeEventListener("preCollision")

  createCollisionDetection(imageObject, player)
end



--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
local collisionDetection = {
  createCollisionDetection = createCollisionDetection,
  changeCollision = changeCollision
}

return collisionDetection