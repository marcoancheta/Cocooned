local function itemSet(collideObject)
	if (setItem == true) then 
		print("setitem")
		if (collideObject == "key") then
			local key = display.newImage( "mapdata/art/key.png" )
        	key.x = 100
        	key.y = 100
        end
    end
end

local inventory = {
	itemSet = itemSet
}

return inventory

