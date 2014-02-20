require("levelFinished")

local function endAnimation( event )
 
  if ( event.phase == "ended" ) then
    local thisSprite = event.target  --"event.target" references the sprite
    thisSprite:removeSelf()  --play the new sequence; it won't play automatically!
  end
end

function collide(collideObject, player, event, mapData, map)
	event.contact.isEnabled = false
	player:addInventory(collideObject)
	--[[local runeCollide = display.newSprite(sheetOptions.runeSheet, spriteOptions.runeAnimation)
	runeCollide.x, runeCollide.y = collideObject.x - 45, collideObject.y
	runeCollide:setSequence("move")
	runeCollide:play()
	]]
 	collideObject:removeSelf()

 	--runeCollide:addEventListener( "sprite", endAnimation )

 	checkWin(player, map)

 	if map.tutorial == true then
 		require("tutorial")
 		printTutorial()
 	end
end





function removeObject(map, index, player)

end

local runeCollision = {
	collide = collide
}

return runeCollision