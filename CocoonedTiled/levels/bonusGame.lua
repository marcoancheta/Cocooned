--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- bonus.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local gameData = require("gameData")


local bonus = {}
local trees = {}

local W = display.contentWidth + 77
local H = display.contentHeight - 15

local bGroup = display.newGroup()

local timeIT = 4500

function bonus:init()
		
	local background = display.newRect(720, 430, W, H)
	
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

	energy = {
		[1] = {
			imgPath = "mapdata/art/coins.png",
			speed = 110
		},
		[2] = {
			imgPath = "mapdata/art/coins.png",
			speed = 110
		}
	}
	
	sheetList = graphics.newImageSheet(energy[1].imgPath, 
			 {width = 66, height = 56, sheetContentWidth = 267, sheetContentHeight = 56, numFrames = 4})
	
	
end

function bonus:getRand()

	physics.setGravity(0, 9.8)

	local temp = {
		[1] = trees[math.random(1, #trees)],
		[2] = energy[math.random(1, #energy)],
	}

	local randTree = display.newImage(temp[1].imgPath)
	local randNrgy = display.newSprite(sheetList, spriteOptions.energy)
	
	print("getRand")
	
	--physics.addBody(randTree, "static", {bounce=0})
	randTree.name = "tree"
	randTree.speed = temp[1].speed
	randTree.x = W + 50
	randTree.y = math.random(0, H)
	randTree:rotate(-90)
	randTree:toFront()
		
	if randTree.y < 400 then
		randNrgy.x = randTree.x + 100
		randNrgy.y = randTree.y + 225
	else
		randNrgy.x = randTree.x - 100
		randNrgy.y = randTree.y - 225
	end
			
	randNrgy.name = "energy"
	randNrgy.speed = temp[2].speed
	randNrgy:rotate(-90)
	randNrgy:setSequence("move")
	randNrgy:play()
		
	moveTree = transition.to(randTree, {time=timeIT, x=-10,
							 onComplete=function(self) self.parent:remove(self); self=nil; timeIT = timeIT - 50; return timeIT; end})
							 
	moveNrgy = transition.to(randNrgy, {time=timeIT, x=-10,
							 onComplete=function(self) self.parent:remove(self); self=nil; timeIT = timeIT - 50; return timeIT; end})
							 
							 
	if timeIT < 2000 then
		gameData.bonusLevel = false
		treeTimer = nil
		bonus.destroy()
	end				 
	
end

function bonus:start()	
	print("start bonus")
	treeTimer = timer.performWithDelay(1000, bonus.getRand, 0)
end

function bonus:destroy()
	print("destroy all")

	display.remove(moveTree)
	display.remove(moveNrgy)
	display.remove(temp)
	display.remove(trees)
	display.remove(energy)
	display.remove(background)
	display.remove(treeTimer)
	moveTree = nil
	moveNrgy = nil
	temp = nil
	trees = nil
	energy = nil
	background = nil
	
	gameData.gameEnd = true
end

local function main(ball)
	print("in main")
	bonus:init()
	bonus:start()	
end

bonus.main = main

return bonus