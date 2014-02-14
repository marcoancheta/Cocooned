--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- bonus.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")

local bonus = {}
local trees = {}

local W = 40
local H = 24

local bGroup = display.newGroup()

local background
local timeIT = 10000

-- Initialize base variables
function bonus:init()
		
	-- Create our icey background
	background = display.newRect(720, 430, 2100, 1000)
	
	-- Create our tree table
	trees = {
		[1] = {
			imgPath = "mapdata/art/tree.png",
			speed = 100
		},
		[2] = {
			imgPath = "mapdata/art/tree2.png",
			speed = 100
		},
		[3] = {
			imgPath = "mapdata/art/tree3.png",
			speed = 100
		}
	}
end

-- Algorithm for random generation
local function getRand(event)

	-- Load in event parameters
	local params = event.source.params

	-- Set gravity to pull slightly on the Positive X-Axis
	physics.setGravity(0.1, 0)
	
	-- Create private collision
	local function onLocalCollision(self, event)
		if(event.phase == "began") then
			-- Collision with runes
			self.isVisible = false
			--self.isBodyActive = false
			self.isSensor = true
			self:removeEventListener("collision", self)
		end
	end	
	
	-- Initialize temp loaders
	local temp = {
		[1] = trees[math.random(1, #trees)],
		[2] = params.param2[math.random(1, #params.param2)],
	}
	
	-- Pass in sheetList
	local sheetListed = params.param3
	
	-- Create our random temporary objects
	local randTree = display.newImage(temp[1].imgPath)
	local randNrgy = display.newSprite(sheetListed, spriteOptions.energy)
	
	print("getRand")
	
	-- Assign Attributes to trees
	randTree.name = "tree"
	randTree.speed = temp[1].speed
	randTree.x, randTree.y = map.tilesToPixels(40, math.random(0, H))
	randTree:rotate(-90)
	randTree:toFront()
	physics.addBody(randTree, "kinematic")
	randTree.isSensor = true
	
	-- Initialize and assign attributes to tree physics bounding box
	local treeBoundingBox = display.newRect(randTree.x+100, randTree.y-35, 40, 30)
		  treeBoundingBox.speed = temp[2].speed
		  treeBoundingBox.alpha = 0
		  treeBoundingBox:toFront()
		  physics.addBody(treeBoundingBox, "static", {bounce=0})
					
	-- Assign Attributes to energy coin
	randNrgy.name = "energy"
	randNrgy.speed = temp[2].speed
	randNrgy.isVisible = true
	randNrgy.collision = onLocalCollision
	physics.addBody(randNrgy, "static", {bounce=0})
	randNrgy:rotate(-90)
	randNrgy:setSequence("move")
	randNrgy:play()	

	-- Position coins based on tree location
	if randTree.y < 400 then
		randNrgy.x, randNrgy.y = randTree.x, randTree.y + 150
	else
		randNrgy.x, randNrgy.y =  randTree.x, randTree.y - 150
	end
	
	-- Insert objects to map (params.param1) layer
	params.param1.layer["bg"]:remove(1)
	params.param1.layer["bg"]:insert(background)
	params.param1.layer["tiles"]:insert(randTree)
	params.param1.layer["tiles"]:insert(randNrgy)
	params.param1.layer["tiles"]:insert(treeBoundingBox)
	
	-- Add event listener to energy coins
	randNrgy:addEventListener("collision", randNrgy)
	
	-- Decrement timeIT by 50 every second
	timeIT = timeIT - 50
	
	-- End Transitions if timeIT < 5600
	if timeIT < 5600 then --5600 then
		transition.cancel(moveTree)
		transition.cancel(moveTBB)
		transition.cancel(moveNrgy)
		timer.cancel(event.source)
		randNrgy:removeEventListener("collision", randNrgy)
		gameData.gameEnd = true
	else
		-- Begin transitions
		local moveTree = transition.to(randTree, {time=timeIT, x=-5,
			onComplete=function(self) self.parent:remove(self); self=nil; end})
		
		local moveTBB = transition.to(treeBoundingBox, {time=timeIT+250, x=-10,
			onComplete=function(self) self.parent:remove(self); self=nil; end})
								 
		local moveNrgy = transition.to(randNrgy, {time=timeIT, x=-5,
			onComplete=function(self) display.remove(self); self=nil; end})
	end
	
	print("timeIT", timeIT)
end

-- Start Bonus Game
function bonus:start(pane, map, energy, sheetList)	
	print("start bonus")
	
	-- Random generation game timer
	treeTimer = timer.performWithDelay(1000, getRand, 0)
	treeTimer.params = {param1 = map, param2 = energy, param3 = sheetList}

end

-- Bonus Game Main Function
local function main(pane, map, energy, sheetList)
	print("in main")
	bonus:init()
	bonus:start(pane, map, energy, sheetList)	
end

bonus.main = main

return bonus