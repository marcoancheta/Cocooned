

function createMoveableObjects(map) 
	if tonumber(map.moveObj) > 0 then
		for check = 1, map.layer["tiles"].numChildren do
			if map.layer["tiles"][check].moveable == true then
					
				local obj = map.layer["tiles"][check]
				local moveObj = require("Objects." .. obj.func)
				moveObj.move(obj)
			end
		end
	end
end


local moveableObjects = {
	createMoveableObjects = createMoveableObjects
}

return moveableObjects