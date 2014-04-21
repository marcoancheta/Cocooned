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
local timeIT
local loser = false

-- Initialize base variables
function bonus:init()

	loser = false		
	timeIT = 10000
		
	-- Create icy background
	background = display.newRect(720, 430, 2100, 1000)
	
	-- Create tree table
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
	
	-- Create avalanche
	avalanche = display.newImage("mapdata/art/snowFall.png")
	avalanche:scale(4, 4)
	avalanche.isVisible = false
	
end

-- Algorithm for random generation
local function getRand(event)

	-- Load in event parameters
	local params = event.source.params

	-- Set gravity to pull slightly on the Positive X-Axis
	physics.setGravity(-5, 0)
	
	-- Create private collision
	local function onLocalCollision(self, event)
		if(event.phase == "began") then
			if self.name == avalanche.name then
				loser = true
			else
				-- Collision with runes
				self.isVisible = false
				--self.isBodyActive = false
				self.isSensor = true
				self:removeEventListener("collision", self)
			end
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
	physics.addBody(randNrgy, "static", {bounce=-1})
	randNrgy:rotate(-90)
	randNrgy:setSequence("move")
	randNrgy:play()	
	
	-- Add collision detection for avalanche
	avalanche.name = "avalanche"
	avalanche.x, avalanche.y = map.tilesToPixels(3, 12.5)
	physics.addBody(avalanche, "static", {bounce=0})
	avalanche.collision = onLocalCollision
	avalanche.speed = temp[2].speed
	avalanche.isVisible = true

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
	params.param1.layer["tiles"]:insert(avalanche)
	
	-- Add event listener to energy coins
	randNrgy:addEventListener("collision", randNrgy)
	avalanche:addEventListener("collision", avalanche)
	
	-- Decrement timeIT by 50 every second
	timeIT = timeIT - 50
	
	local function destroy()
		transition.cancel(moveAval);
		transition.cancel(moveTree);
		transition.cancel(moveTBB);
		transition.cancel(moveNrgy);
		timer.cancel(event.source);
		randNrgy:removeEventListener("collision", randNrgy);
		avalanche:removeEventListener("collision", avalanche);
		randTree:removeSelf();
		randNrgy:removeSelf();
		avalanche:removeSelf()
		randTree = nil;
		randNrgy = nil;
		avalanche = nil;
		gameData.gameEnd = true;
	end
	
	
	-- End Transitions if timeIT in for 44 seconds
	-- timeIT = 10,000. Level ends at 5,600. Therefore 4,400 = 44 seconds.
	if timeIT < 5600 or loser then	--5600 then
		avalanche:removeSelf()
		avalanche = nil
		avalanche = display.newImage("mapdata/art/snowFall2.png")
		avalanche:scale(8, 4)
		avalanche.x, avalanche.y = map.tilesToPixels(3, 12.5)
		params.param1.layer["tiles"]:insert(avalanche)
		
		local moveAval = transition.to(avalanche, {time=2000, iterations=0, x=2000,
			onComplete=destroy})
			
		loser = false
	elseif timeIT > 5600 then
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